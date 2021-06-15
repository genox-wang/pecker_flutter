## 工具类

### AppChannel

应用内原生交互接口

[传送门](app_channel.md)

### Logger

基于 [logger](https://pub.flutter-io.cn/packages/logger) 包装，提供全局日志功能

通过 `Config.LOG_LEVEL` 配置日志等级

```dart
// 带方法堆栈的日志输出
log.v('verbose');
log.d('debug');
log.i('info');
log.w('warning');
log.e('error');
// 不带方法堆栈的日志输出
sLog.v('verbose');
sLog.d('debug');
sLog.i('info');
sLog.w('warning');
sLog.e('error');
```

### MyTools

应用常用方法汇总，比如转换器，生成器等

[传送门](my_tools.md)

### MyUI

常用 UI 创建的快捷入口

[传送门](my_ui.md)

### ScreenUtils

屏幕尺寸自适应

[传送门](screen_utils.md)

### Toast

模仿微信的 Toast 弹窗

```dart
Toast.i('消息', '提交成功');
Toast.e('错误', '提交失败');

Toast.show('消息', '提交成功', Icon.success, duration:Duration(seconds:3));
```
