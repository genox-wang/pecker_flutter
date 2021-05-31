## 编码规范

1. 同文件夹类超过3个用 `index.dart` 暴露给外部 `import`
```dart
export 'app_channel.dart';
export 'log.dart';
export 'my_tools.dart';
export 'my_ui.dart';
export 'screen.dart';
export 'toast.dart';
```

2. 类如果太臃肿，且功能无法进一步拆分的话，使用 `mixins` 拆分

3. 对于比较复杂的 Dialog 创建`page`，然后使用 `MyUI.showPageDailog` 打开
```dart
MyUI.showPageDailog(
  routeName: Routes.LOGIN,
  titleText: '登录注册',
  onDispose: loginBindingDispose,
)
```

4 `initService` 代码规范
  - 不出现业务代码
  - 只包含 Service 类
  - 多 Service 如果有依赖关系，需要严格使用 `await` 控制。

```dart
Future initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(TaskService()..init());
  await Get.putAsync(() => ConnectivityService().init());

  await Get.putAsync(() => SharedPreferecesService().init());
  Get.put(DbService());
  await Get.putAsync(() => AppService().init());

  await Get.putAsync(() => VibrationService().init());
}