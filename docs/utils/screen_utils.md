## ScreenUtils

设备多尺寸自适应

### 初始化

```dart
GetMaterialApp(
  ...
  builder: (context, child) {
    ScreenUtil.initialize(context);
    return BotToastInit()(context, child);
  },
  ...
);
```

### 使用

目前我们项目都是以为 `1080x1920` 设计的，竖屏情况下我们一般宽度自适应。

```dart
// 绘制一个在设计稿上 尺寸为 300 x 200 的矩形。
Container(width: 300.w, height:200.w, color: Colors.red);
// 如果你不想在系统大字大小改变的时候，你的 Text 文字随之变化的话，文字我们建议使用 .sp 做自适应。
Text('Hello world', style:TextStyle(fontSize: 50.sp));
```