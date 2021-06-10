## HttpService

### 使用方法

#### 1. 配置

`lib/config.dart` 文件内配置 `host`

```dart
  // TODO http 请求 host
  static const API_HOST = kReleaseMode
      ? 'API_HOST'
      : 'API_HOST_TEST';
  // TODO ws 请求 host
  static const WS_HOST = kReleaseMode
      ? 'WS_HOST'
      : 'WS_HOST_TEST';
```

#### 2. 调用 apiRequest

一般来说 `api` 相关代码放在 `data/apis` 目录下
比如再 `apis` 目录下创建 `user.dart`

```dart
class UserApis {
  static final _http = HttpService.to;

  /// 调用 apiRequest 请求指定协议
  static Future<CommonResponse?> register(
      String cell, String verCode, String password) {
    var data = Register();
    data.cellphone = cell;
    data.verCode = verCode;
    data.passwd = password;
    return _http.apiRequest(ProtocolType.Register, data: data);
  }

  ...
}
```

### 更多


> 这个项目的网络请求接口，是目前根据实际业务需求包装的，协议使用的是 protobuf。 所以如果使用一致的协议可以直接使用，如果是其他协议或者协议结构有变化的需要进行一些改造

#### 协议说明

通用请求体
```proto
message CommonRequest {
  data.ProtocolType proto_type = 1;
  int64 version = 2;
  string token = 3;
  string ticket = 4;
  bytes data = 5;
}
``` 
通用返回体是
```proto
message CommonResponse {
  int32 status = 1;
  string token = 2;
  data.ProtocolType proto_type = 3;
  string ticket = 4;
  bytes data = 5;
}
```
其中 `token` 是必须的如果没有 `token` 的话会先请求 `RegDevice`注册设备。

```proto
message ReqDeviceRequest {
  data.DeviceType device_type = 1;
  data.DeviceKeyType dk_type = 2;
  string dk_value = 3;
  data.AppType app_type = 4;
}
```

#### apiRequest 默认优先使用 ws

- forceWs 是否强制使用 Ws, 如果 Ws 没有链接则返回错误

```dart
 static final _http = HttpService.to;
 _http.apiRequest(ProtocolType.ProcessNotification, data: data)
```

#### 快速解析 CommonResponse 

返回的 `CommonResponse` ，只有当 `s`tatus == 200` 时才需要，解析`data`。可以使用 `resposeWith` 包裹请求快速解析

- fromBuffer 解码数据方法
- [okStatus] 默认 resp.status == 200 才会解码，如果有其他状态也需要解码的话可以通过这个参数传入

```dart
  HttpService.resposeWith(
   apiRequest: () => _http.apiRequest(
      ProtocolType.BattleChallengeInvite,
      data: data,
      forceWs: true,
    ),
    okStatus: [BattleChallengeInviteStatus.StatusOK.value],
    fromBuffer: (data) => CodeResponse.fromBuffer(data),
  );
```



