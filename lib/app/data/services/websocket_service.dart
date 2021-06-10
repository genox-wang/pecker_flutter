import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:synchronized/synchronized.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../config.dart';
import '../../../proto/request/common_request.pb.dart';
import '../../../proto/response/common_response.pb.dart';
import '../../../utils/index.dart';
import 'index.dart';

/// WebSocketService 服务
///
/// 支持断线重连
/// 发送消息匹配返回消息
/// 全局监听服务器消息
/// 全局监听服务器状态
///
/// 后端教育协议是基于 proto 协议的
/// 通用请求体是 [CommonRequest]
/// 通用返回体是 [CommonResponse]
/// 
/// 下面代码是保证 ws 连接后执行相关代码
/// ```
/// everWsConnected(Function() doTask) {
///    if (WebSocketService.to.wsState == WebSocketStatus.open) {
///      doTask();
///   }
///    _wsStatusSub = WebSocketService.to.onStatusChanged.listen((event) {
///      if (event == WebSocketStatus.open) {
///        doTask();
///     }
///   });
/// }
/// ```
/// 
/// 下面代码是全局监听后端推送的信息
/// ```
/// _wsOnMessageSub = WebSocketService.to.onMessage.listen((resp) {
///   ...
/// })
/// 
/// _wsOnMessageSub.cancel();
/// ```
class WebSocketService extends GetxService {
  static WebSocketService get to => Get.find();

  late Worker _connectivityWorker;

  late String url;

  @override
  void onInit() {
    sLog.d("WebSocketService onInit");
    onMessage = _onMessageController.stream;
    onStatusChanged = _onStatusChangedController.stream;

    url = wsHost;

    connect();

    _connectivityWorker =
        ever<ConnectivityResult>(ConnectivityService.to.rsStatus, (status) {
      if (status == ConnectivityResult.none) {
        close();
      } else {
        connect();
      }
    });
    super.onInit();
  }

  String get wsHost => Config.WS_HOST;

  @override
  void onClose() {
    _connectivityWorker.dispose();
    close();
    _onMessageController.close();
    _onStatusChangedController.close();
    _delayCloseTimer?.cancel();
    super.onClose();
  }

  /// 超时时间
  final int receiveTimeout = 10000;
  /// 断线重连延时
  final Duration reconnectDelay = 5.seconds;
  /// ping 间隔
  final Duration pingInterval = 8.seconds;

  // 异步消息映射
  Map<String, Completer<CommonResponse>> _completers =
      Map<String, Completer<CommonResponse>>();
  // 维护超时计数器
  Map<String, Timer> _timeOutTimerMap = Map<String, Timer>();

  IOWebSocketChannel? _channel;

  WebSocketStatus _wsStatus = WebSocketStatus.closed;
  WebSocketStatus get wsState => _wsStatus;

  StreamController<WebSocketStatus> _onStatusChangedController =
      StreamController<WebSocketStatus>.broadcast();

  late Stream<WebSocketStatus> onStatusChanged;

  StreamController<CommonResponse> _onMessageController =
      StreamController<CommonResponse>.broadcast();

  late Stream<CommonResponse> onMessage;

  Lock _lock = Lock();

  connect() {
    _lock.synchronized(() {
      if (wsState == WebSocketStatus.connecting ||
          wsState == WebSocketStatus.open) {
        return;
      }

      sLog.d("WebSocketService connect");
      _setStatus(WebSocketStatus.connecting);
      // 连接前清楚重连计时器
      _reConnectDelayTimer?.cancel();
      _channel = IOWebSocketChannel.connect(
        Uri.parse(url),
        pingInterval: pingInterval,
      );
      _channel?.stream.listen(
        (message) {
          _onMessage(message);
        },
        onError: (e, s) {
          sLog.d("WebSocketService onError:", e, s);
          close();
          // 异常断开后5秒重连
          reconnect(reconnectDelay);
        },
        onDone: () {
          sLog.d("WebSocketService onDone");
          // close();
          // 异常断开后5秒重连
          // 如果是服务器重启需要重连
          if (wsState != WebSocketStatus.closed &&
              wsState != WebSocketStatus.closing) {
            _setStatus(WebSocketStatus.closed);
            reconnect(reconnectDelay);
          }
        },
      );
      _setStatus(WebSocketStatus.open);
    });
  }

  Timer? _delayCloseTimer;

  onPause() {
    if (Platform.isIOS) {
      if (_delayCloseTimer?.isActive == true) {
        return;
      }
      // IOS退到后台 29秒要关闭网络，否则会被应用杀掉
      _delayCloseTimer = Timer(Duration(milliseconds: 29000), () {
        close();
      });
    }
  }

  /// 锁屏或者切换到后台恢复的时候请调用，保证 IOS 连接状态恢复
  onResume() {
    if (Platform.isIOS) {
      _delayCloseTimer?.cancel();
      _delayCloseTimer = null;
      connect();
    }
  }

  Timer? _reConnectDelayTimer;

  // 延时重连
  reconnect(Duration delay) {
    sLog.d("WebSocketService reconnect");
    _reConnectDelayTimer?.cancel();
    _reConnectDelayTimer = Timer(delay, () {
      connect();
    });
  }

  /// 断开连接
  close() {
    _lock.synchronized(() {
      sLog.d("WebSocketService close");
      // 关闭重连尝试
      _reConnectDelayTimer?.cancel();
      if (wsState == WebSocketStatus.closed ||
          wsState == WebSocketStatus.closing) {
        return;
      }
      _setStatus(WebSocketStatus.closing);
      _channel?.sink.close(status.goingAway);
      _setStatus(WebSocketStatus.closed);
    });
  }

  /// 发送消息
  /// 
  /// 如果超过超时时间还没有收到消息则返回超时
  /// 
  /// ```
  /// resp = await WebSocketService.to.send(d);
  /// ```
  Future<CommonResponse> send(CommonRequest cmd) {
    if (_channel == null || _channel?.closeCode != null) {
      return Future.error(WebSocketChannelException("websocket not connected"));
    }

    sLog.v("WebSocketService request ${cmd.protoType} ");

    _completers[cmd.ticket] = Completer();
    _channel?.sink.add(cmd.writeToBuffer());
    _timeOutTimerMap[cmd.ticket] =
        Timer(Duration(milliseconds: receiveTimeout), () {
      sLog.e("WebSocketService error ${cmd.protoType} timeout ");
      _completers[cmd.ticket]
          ?.completeError(WebSocketChannelException("timeout"));
      _completers.remove(cmd.ticket);
    });
    return _completers[cmd.ticket]!.future;
  }

  _setStatus(WebSocketStatus value) {
    if (this.wsState != value) {
      sLog.d("WebSocketService setStatus: $value");
      this._wsStatus = value;
      _onStatusChangedController.add(value);
    }
  }

  _onMessage(data) {
    var response = CommonResponse.fromBuffer(data);
    _timeOutTimerMap[response.ticket]?.cancel();
    _timeOutTimerMap.remove(response.ticket);
    sLog.v("WebSocketService respose ${response.protoType} ${response.status}");
    // 全局通过 onMessage 可以监听消息
    _onMessageController.add(response);
    // 通过 send 发送的消息给到返回值
    var completer = _completers[response.ticket];
    _completers.remove(response.ticket);
    completer?.complete(response);
  }
}

enum WebSocketStatus {
  connecting,
  open,
  closing,
  closed,
}
