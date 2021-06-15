## AppChannel

### 初始化

```dart
AppChannel.init();
```

### IOS 

#### 接口

```dart
// ios 应用市场好评
AppChannel.appReview();
 // ios 快速好评, 每个用户一年可以弹出三次
AppChannel.quickAppReview();
// ios 使用广告前需要申请 IDFA 权限
AppChannel.requestIDFA();
```

#### 监听

```dart
appChannelSub = AppChannel.onEvent.listen((event) {
  // IOS 切到后台
  if (event.type == AppChannelEventType.IOS_PAUSE) {
    WebSocketService.to.onPause();
    iosState = IOSLifecycleState.pause;
  // IOS 恢复前台
  } else if (event.type == AppChannelEventType.IOS_RESUME) {
    WebSocketService.to.onResume();
    iosState = IOSLifecycleState.resume;
  }
});
```

