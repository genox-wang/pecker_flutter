import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:get/get.dart' as g;
import 'package:protobuf/protobuf.dart' as $pb;
import 'package:protobuf/protobuf.dart';
import 'package:uuid/uuid.dart';

import '../../../config.dart';
import '../../../proto/data/device_meta.pb.dart';
import '../../../proto/data/protocol_type.pb.dart';
import '../../../proto/request/common_request.pb.dart';
import '../../../proto/request/reg_device.pb.dart';
import '../../../proto/response/common_response.pb.dart';
import '../../../utils/index.dart';
import '../models/api_response.dart';
import 'index.dart';
import 'web_mocks/mock_base.dart';

class HttpService extends g.GetxService {
  static HttpService get to => g.Get.find();

  Dio? _dio;

  static final connectTimeOut = 10000;
  static final receiveTimeout = 15000;

  Completer? _regDeviceCompleter;

  List<MockBase> _mocks = [];

  Future<HttpService> init() async {
    sLog.e("HttpService init");
    _dio = new Dio(BaseOptions(
        baseUrl: apiHost,
        connectTimeout: connectTimeOut,
        receiveTimeout: receiveTimeout));
    // addInterceptor(_dio!);
    if (!kReleaseMode) {
      _mocks.addAll([
        // GameStageApiMock(),
      ]);
    }

    return this;
  }

  String get apiHost => Config.API_HOST;

  static Stream<List<int>> bytes(Uint8List data) {
    return Stream.fromIterable(data.map((e) => [e]));
  }

  static Future<APIResponse<T>> resposeWith<T extends GeneratedMessage>({
    required Future<CommonResponse?> Function() apiRequest,
    required T Function(List<int>) fromBuffer,
    List<int>? okStatus,
  }) {
    return apiRequest().then((resp) {
      if (resp != null &&
          (resp.status == 200 || (okStatus?.contains(resp.status) ?? false))) {
        return APIResponse<T>()
          ..statusCode = resp.status
          ..data = fromBuffer(resp.data);
      }
      return APIResponse<T>()..statusCode = resp?.status;
    }).catchError(
      (e) => APIResponse<T>()..statusCode = null,
    );
  }

  Future<CommonResponse?> apiRequest(
    ProtocolType type, {
    String? ticket,
    $pb.GeneratedMessage? data,
    bool forceWs = false,
  }) async {
    for (var m in _mocks) {
      final resp = await m.mock(type, ticket: ticket, data: data);
      if (resp != null) {
        return resp;
      }
    }
    // 判断当前联网状态，如果关闭网络直接返回
    if (ConnectivityService.to.status == ConnectivityResult.none ||
        (forceWs && WebSocketService.to.wsState != WebSocketStatus.open)) {
      sLog.w("apiRequest respose $type ${MyHTTPStatus.NO_CONNECTIVITY}");
      return CommonResponse()..status = MyHTTPStatus.NO_CONNECTIVITY;
    }
    // http 库是否初始化
    if (_dio == null) return CommonResponse()..status = MyHTTPStatus.NO_DIO;
    final appS = AppService.to;
    if (appS.buildNumber == null && S().imeiOrIdfa.isEmpty) {
      sLog.w("apiRequest respose $type ${MyHTTPStatus.LACK_ARGS}");
      return CommonResponse()..status = MyHTTPStatus.LACK_ARGS;
    }

    // 没有注册设备，尝试注册设备再请求
    if (S().token.isEmpty && type != ProtocolType.RegDevice) {
      if (_regDeviceCompleter != null) {
        await _regDeviceCompleter?.future;
      } else {
        _regDeviceCompleter = Completer();
        try {
          // 请求注册设备
          await regDevice();
        } finally {
          _regDeviceCompleter?.complete();
          _regDeviceCompleter = null;
        }
      }
    }

    if (S().token.isEmpty && type != ProtocolType.RegDevice) {
      sLog.w("apiRequest respose $type ${MyHTTPStatus.NO_TOKEN}");
      return CommonResponse()..status = MyHTTPStatus.NO_TOKEN;
    }

    final d = CommonRequest()
      ..ticket = ticket ?? Uuid().v4()
      ..version = $fixnum.Int64(appS.buildNumber!)
      ..protoType = type
      ..token = S().token;
    if (data != null) {
      d.data = data.writeToBuffer();
    }

    var url = "${type.toString().replaceFirst("ProtocolType.", "")}";

    sLog.w("apiRequest request $type");

    try {
      late CommonResponse resp;
      if (WebSocketService.to.wsState == WebSocketStatus.open) {
        resp = await WebSocketService.to.send(d);
        sLog.d("apiRequest response from ws");
      } else {
        final r = await _dio!.post(url,
            data: bytes(d.writeToBuffer()),
            options: Options(responseType: ResponseType.bytes));
        resp = CommonResponse.fromBuffer(r.data);
        sLog.d("apiRequest response from http");
      }

      sLog.w("apiRequest respose $type ${resp.status}");

      if (resp.token.isNotEmpty && S().token != resp.token) {
        sLog.w("apiRequest respose new token ${resp.token}");
        S().token = resp.token;
      }
      return resp;
    } catch (e) {
      sLog.e("apiRequest error $type $e");
      return null;
    }
  }

  Future<CommonResponse?> regDevice() {
    var data = ReqDeviceRequest();
    if (Platform.isAndroid) {
      data.deviceType = DeviceType.DeviceTypeAndroid;
      data.dkType = DeviceKeyType.DKTypeIMEI;
    } else if (Platform.isIOS) {
      data.deviceType = DeviceType.DeviceTypeIOS;
      data.dkType = DeviceKeyType.DKTypeIDFA;
    } else {
      data.deviceType = DeviceType.DeviceTypeUndefined;
      data.dkType = DeviceKeyType.DKTypeUndefined;
    }
    data.dkValue = S().imeiOrIdfa;
    return apiRequest(
      ProtocolType.RegDevice,
      data: data,
    );
  }

  String errorInfo(int? statusCode) {
    if (statusCode == MyHTTPStatus.NO_DIO) {
      return '网络未初始化。';
    } else if (statusCode == MyHTTPStatus.NO_CONNECTIVITY) {
      return '您未连接网络。';
    } else if (statusCode == MyHTTPStatus.LACK_ARGS) {
      return '初始化失败，请尝试重启应用。';
    }
    return '网络错误: $statusCode';
  }
}

class MyHTTPStatus {
  static const NO_DIO = 450;
  static const NO_CONNECTIVITY = 451;
  static const LACK_ARGS = 452;
  static const DULOGIN = 410;
  static const NO_TOKEN = 453;
}
