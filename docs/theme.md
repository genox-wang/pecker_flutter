# 暗黑和亮色主题

### 主题色配置

`app/themes/base.dart` 配置通用主题

```dart

final baseTheme = ({Brightness brightness = Brightness.light}) => ThemeData(
      brightness: brightness,
      primaryColor: Color(0xFF1ac0c6),
      // 去除 item 点击水波纹
      highlightColor: Color.fromRGBO(0, 0, 0, 0),
      splashColor: Color.fromRGBO(0, 0, 0, 0),
      iconTheme: IconThemeData(color: Colors.blue),
      errorColor: Colors.deepOrangeAccent,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF0086DE),
      ),
    );

```

`app/themes/dark.dart` 配置暗黑主题

```dart
final darkTheme = baseTheme(brightness: Brightness.dark);
```

`app/themes/light.dart` 配置亮色主题

```dart
final lightTheme = baseTheme().copyWith(
  primaryColor: Color(0xFF1ac0c6),
  dividerColor: Colors.grey[200],
  dividerTheme: DividerThemeData(space: 1, thickness: 0.7),
  scaffoldBackgroundColor: Colors.grey[100],
  canvasColor: Colors.grey[100],
  cardColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[100],
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
```

### 主题切换

```dart
final result = await MyUI.showSelectionBottomSheet(
    selections: ['跟随系统', '黑暗模式', '亮色模式']);
if (result is int) {
  if (result == 0) {
    // 切换为跟随系统
    S().appThemeMode = AppThemeMode.system;
    Get.changeTheme(window.platformBrightness == Brightness.light
        ? lightTheme
        : darkTheme);
  } else if (result == 1) {
    // 切换为暗黑主题
    S().appThemeMode = AppThemeMode.dark;
    Get.changeTheme(darkTheme);
  } else if (result == 2) {
    // 切换为亮色主题
    S().appThemeMode = AppThemeMode.light;
    Get.changeTheme(lightTheme);
  }
}
```
