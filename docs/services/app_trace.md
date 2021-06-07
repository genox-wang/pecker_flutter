## AppTraceService

### 使用方式

配合 `app/utils/trace_event.dart` 使用，在 `TraceEvents` 内定义事件，调用 `T().event(e)` 发送事件。

```dart
class TraceEvents {
  static const PUSH_AWAKE = 'push_awake';
}

...
// 事件埋点
T().event(TraceEvents.PUSH_AWAKE);

// 错误埋点
try {
     ...
} catch (e, s) {
  T().error(e,s,);
}
```

### 添加第三方埋点服务

#### 以添加友盟为例

添加 UmengService

```dart

class UmengService extends GetxService {
  static UmengService get to => Get.find();


  Future<UmengService> init() async {
    // 初始化 友盟插件
    return this;
  }

  onEvent(String event, {Map<String, dynamic>? params}) {
    // 调用友盟 onEvent
  }

  onPageStart(String page) {
    // 调用友盟 onPageStart
    FlutterUmengPlus.onPageStart(page);
  }

  onPageEnd(String page) {
    // 调用友盟 onPageEnd
    FlutterUmengPlus.onPageEnd(page);
  }
}

```

`init,dat` 内注册服务

```dart
initServices() async {
  ...
  await Get.putAsync(() => UmengService().init()); // 在 AppTraceService 前初始化
  Get.put(AppTraceService());
  ...
}
 
```

`AppTraceService` 中添加友盟友盟事件

```dart
class AppTraceService extends GetxService {
  static AppTraceService get to => Get.find();

  @override
  onClose() {
    super.onClose();
  }

  event(String event) {
    if (!kReleaseMode) {
      return;
    }
    UmengService.to.onEvent(event);
    Sentry.captureMessage(event);
  }

  error(Object e, [StackTrace? s]) {
    if (!kReleaseMode) {
      return;
    }
    Sentry.captureException(e, stackTrace: s);
  }

  pageStart(String page) {
    if (!kReleaseMode) {
      return;
    }
    UmengService.to.onPageStart(page);
  }

  pageEnd(String page) {
    if (!kReleaseMode) {
      return;
    }
    UmengService.to.onPageEnd(page);
  }
}

```