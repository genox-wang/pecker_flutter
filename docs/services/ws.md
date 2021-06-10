## WebSocketService

### 初始化 

```
 Get.put(WebSocketService());
```

### 发送消息

如果超过超时时间还没有收到消息则返回超时

```dart
resp = await WebSocketService.to.send(d);
```

### 接收消息

全局监听后端推送的信息

```dart
_wsOnMessageSub = WebSocketService.to.onMessage.listen((resp) {
  ...
})
 
_wsOnMessageSub.cancel();
```

### 监听状态

保证 ws 连接后执行相关代码

```dart
everWsConnected(Function() doTask) {
    if (WebSocketService.to.wsState == WebSocketStatus.open) {
      doTask(); 
    }
      _wsStatusSub = WebSocketService.to.onStatusChanged.listen((event) {
      if (event == WebSocketStatus.open) {
      doTask();
    }
  });
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

#### 重连机制

默认支持断线重连。
对于苹果设备退到后台 30 秒会断开连接，返回前台再连接。（因为 30秒 还连接苹果会杀掉应用）
