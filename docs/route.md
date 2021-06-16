## 路由

> 路由详细文档请参考 [getx 路由管理 文档](https://github.com/jonataslaw/getx/blob/master/documentation/zh_CN/route_management.md) 

#### 常用接口对应关系

```dart
Navigator.push  => Get.to
Navigator.pushNamed => Get.toNamed
Navigator.pushReplacement => Get.off
Navigator.pushReplacementNamed => Get.offName
Navigator.pop => Get.back
Navigator.popUtil => Get.util
```

#### 获取当前路由

通过 `Get.routing` 可以后去当前界面的路由

有时候我们还想知道哪个 `dialog` 或者 `bottomSheet` 显示了。那可以通过 `AppMiddlewares.curRoute` 获取路由名字

> 弹出的 `dialog` 后者 `bottomSheet` 需要配置 `routeSettings`

#### 规范使用流程

1. 创建 page

```shell
get create page:settings
```

2. 跳转到 settings

```dart
Get.toNamed(Routes.SETTINGS);
```

> 如果像使用  dialog 或者 bottomsheet 弹出

3. `settings_bindings.dart` 文件内添加销毁 Controller 方法

```dart
settingsBindingDispose() {
  Get.delete<SettingsController>();
}
```

4. 使用 dialog 或者 bottomsheet 打开

```dart
MyUI.showPageDailog(
    routeName: Routes.SETTINGS,
    onDispose: settingsBindingDispose,
    willPop: false,
    title: SizedBox(),
    titleText: '',
    hasClose: false,
    elevation: 0,
    backgroundColor: Colors.transparent,
    arguments: null,
  );
}

MyUI.showPageBottomSheet(
  routeName: Routes.SETTINGS,
  onDispose: settingsBindingDispose,
  arguments: null,
);
```