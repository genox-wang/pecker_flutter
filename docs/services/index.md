## Services

### 服务注册
`services/init.dart`

`initService` 代码规范
  - 不出现业务代码
  - 只包含 Service 类
  - 多 Service 如果有依赖关系，需要严格使用 `await` 控制。

```dart
Future initServices() async {
  Get.put(AppTraceService());
  Get.put(TaskService()..init());
  Get.put(LifecycleService());
  await Get.putAsync(() => ConnectivityService().init());
  await Get.putAsync(() => HttpService().init());
  await Get.putAsync(() => AppUpgraderService().init());
  Get.put(WebSocketService());
  Get.put(DbService());
  await Get.putAsync(() => AppService().init());
  await Get.putAsync(() => VibrationService().init());

  Get.lazyPut(() => ImagePickerService());
  Get.lazyPut(() => BrowserService());

  SplashController.to.allServicesReady.value = true;
}
```

### AppService
应用服务，初始化获取必要的设备信息

```dart
AppService.to.tempDir // 应用临时文件夹
AppService.to.appDocDir // 应用文档文件夹

AppService.to.buildNumber // 安卓的 versionCode  IOS 的 version
AppService.to.version // 安卓的 versionName  IOS 的 buildNumber

AppService.to.webviewUserAgent // UA

AppService.to.packageName // 包名

AppService.to.deviceMode // 手机型号
```

### AppTraceService

埋点服务, [使用说明](app_trace.md)

### AppUpraderService

应用更新信息展示。

`app/services/mixins/app_upgrader_infos_mixin.dart` 内配置对应指定版本的更新信息，当前版本的更新内容会如果没有展示过会展示一次

> buildNumber 最后两位是用于测试版本的，比如 `1.4.0` 对应的版本号可以是 1040000 ~ 1040099, 所以定义 `1.4.0` 版本说明的键值就是 `10400`

```dart
part of '../app_upgrader_service.dart';


final _infos = {
  '10400': '1.  游戏支持配置主题。 \n\n2.  游戏回放支持倍速功能。\n\n3.  调整每日挑战日历界面。\n\n4.  调整闯关界面。'
};

```

### AudioService

音效服务, 目前只播放音效， 不播放背景音乐

```dart
// 先缓存本地音频文件
Future<AudioService> init() async {
  _cache = AudioCache(prefix: 'assets/audio/', duckAudio: true);
  _cache.loadAll([
    "error.mp3",
  ]);
  return this;
}

...

// 使用的地方播放
AudioService.to.play('error.mp3')
```

### BrowserService

浏览器服务，提供应用内弹出 url 相关的服务

```dart
/// 应用内打开链接
BrowserService.to.openAppBrowser('https://www.baidu.com');
/// 系统浏览器打开链接
BrowserService.to.openSystemBrowser('https://www.baidu.com');
```

### ConnectvityService

手机连接状态服务, 可以通过以下方法监听

```dart
  late Worker _connectivityWorker;

  @override
  void onInit() {
    //
    // enum ConnectivityResult {
    //   wifi,
    //   mobile,
    //   none
    // }
    //
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

  @override
  void onClose() {
    _connectivityWorker.dispose()
    super.onClose();
  }

```

### DBService

数据库服务, [使用说明](db_service.md)

### HttpService

Http 服务, [使用说明](http.md)
### ImagePickerService

相册访问服务

```dart
// 从应用相册获取图片
final file = await ImagePickerService.getImage()
// 拍照获取图片
final file = await ImagePickerService.getImage(isCamera: true)
```

### LifecycleService

生命周期服务，可以通过以下代码监听生命周期

```dart
  late Worker _lifecycleWorker;

  @override
  void onInit() {
    _lifecycleWorker =
        ever<AppLifecycleState>(LifecycleService.to.rxStatus, (status) {
      if (status == AppLifecycleState.resumed) {
        TaskService.to.doTask(() => checkBattleCustomRoom());
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    _lifecycleWorker.dispose();
    super.onClose();
  }

```

### PreferecesService

SharedPreferences 服务

```dart
class SharedPreferecesService extends GetxService {
  // 定义存储字段
  String get token => _prefs.getString('_token') ?? '';
  set token(String value) => _prefs.setString('_token', value);
}

... 

// 外部使用
S().token = 'my token';
```


### TaskService

任务服务，用于让线型任务依次执行
比如多个弹出框同时弹出，为了防止弹框叠弹窗，可以让一个弹窗任务结束再打开下一个

默认第一个任务会在 `HomeController.onInit` 之后调用，这样所有 ui 在主界面之前不会弹出。

```dart
TaskService.to.doTask(() => MyUI.showDialog());
TaskService.to.doTask(() => MyUI.showDialog());
TaskService.to.doTask(() => MyUI.showDialog());

// MyUI 库里提供了几个方法通过 TaskService 包装的
MyUI.showSyncDefaultDialog();
MyUI.showSyncDialog();
```

### VibrationService

震动服务

```dart
// 点击震动
VibrationService.to.tapVibrate();
```

### WebSocketService

WebSocket 服务, [使用说明](ws.md)
