import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

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

  final int receiveTimeout = 10000;

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
        pingInterval: Duration(seconds: 8),
      );
      _channel?.stream.listen(
        (message) {
          _onMessage(message);
        },
        onError: (e, s) {
          sLog.d("WebSocketService onError:", e, s);
          close();
          // 异常断开后5秒重连
          reconnect(5.seconds);
        },
        onDone: () {
          sLog.d("WebSocketService onDone");
          // close();
          // 异常断开后5秒重连
          // 如果是服务器重启需要重连
          if (wsState != WebSocketStatus.closed &&
              wsState != WebSocketStatus.closing) {
            _setStatus(WebSocketStatus.closed);
            reconnect(5.seconds);
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

  Future<CommonResponse> send(CommonRequest cmd) {
    if (_channel == null || _channel?.closeCode != null) {
      return Future.error(WebSocketChannelException("websocket not connected"));
    }

    sLog.v("WebSocketService request ${cmd.protoType} ");

    _completers[cmd.ticket] = Completer();
    _channel?.sink.add(cmd.writeToBuffer());
    _timeOutTimerMap[cmd.ticket] =
        Timer(Duration(milliseconds: receiveTimeout), () {
      sLog.d("WebSocketService error ${cmd.protoType} timeout ");
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
    _onMessageController.add(response);
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
