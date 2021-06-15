## MyUI

### snackBar

```dart
MyUI.static snackbar('提示', '恭喜提交成功’)
```

### Dialog

#### showDefaultDialog & showSyncDefaultDialog

默认弹窗

- title 标题
- body 详情
- hasClose 是否显示右上角关闭按钮
- routeName 路由名

```dart
MyUI.showDefaultDialog(
    title: 'v $version 更新内容',
    body: _infos['${buildNumber ~/ 100}']!,
    confirmText: '知道了',
    barrierDismissible: false);

// 通过 TaskSevice 包装
// 多次调用，按顺序弹出
MyUI.showSyncDefaultDialog();
MyUI.showSyncDefaultDialog();
MyUI.showSyncDefaultDialog();
```


#### showDialog & showSyncDialog

自定义弹窗

- titleText 标题
- title 标题 Widget
- bodyText 详情
- body 详情 Widget
- hasClose 是否显示右上角关闭按钮
- routeName 路由名
- backgroundColor 背景色
- onConfirm 提交按钮被点击，返回 true，才关闭
 
```dart
MyUI.showDialog(
    titleText: '选择训练难度',
    body: Container(
      height: 300,
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
        3,
        (index) => Text('难度$index'),
        ),
      ),
    )
)

// 通过 TaskSevice 包装
// 多次调用，按顺序弹出
MyUI.showSyncDialog();
MyUI.showSyncDialog();
MyUI.showSyncDialog();
```


### BottomSheet

#### showBottomSheet
 
通用底部弹窗，基于 Get.bottomSheet 的定制版

#### showSelectionBottomSheet

通用底部选择菜单

```dart
final level = await MyUI.showSelectionBottomSheet(
   selections: List.generate(3,
       (index) => '难度$index')),
   title: '配置游戏难度',
   backgroundColor: Color(0xFF8800FF),
   textColor: Colors.white,
   dividerColor: Colors.purple.shade300,
   routeName: 'battle_custom_room_level_selection',
);
if (level is int) {
  ...
}
```


### Page

`AppPages` 内注册的页面支持使用 Dialog 和 BottomSheet 弹出

#### showPageDailog
- titleText 标题
- title 标题 Widget
- bodyText 详情
- body 详情 Widget
- hasClose 是否显示右上角关闭按钮
- routeName 路由名
- backgroundColor 背景色
- onConfirm 提交按钮被点击，返回 true，才关闭
- arguments 路由传参

Page 通过 Dialog 展示， 由于不通过路由无法自动释放 Controller 所以需要通过 [onDispose] 手动释放

```dart
MyUI.showPageDailog(
    routeName: Routes.LOGIN,
  titleText: '登录注册',
  onDispose: loginBindingDispose,
)
```
 
#### showPageBottomSheet
- routeName 路由名
- arguments 路由传参

Page 通过 BottomSheet 展示，由于不通过路由无法自动释放 Controller 所以需要通过 [onDispose] 手动释放
  
```dart
MyUI.showPageBottomSheet(
  routeName: Routes.STAGE_LIST, onDispose: stageListBindingDispose);
```

### Loading

加载中弹窗

```dart
// 弹出加载动画，屏蔽点击事件
// 加载框保证唯一性，同时只会存在一个
MyUI.showLoading();
// 隐藏加载动画
MyUI.hideLoading();
```

### Mask

事件遮罩。
有些时候我们只想屏蔽点击事件并不想让有弹窗，这时候就可以用 Mask。
它弹出一个透明的遮罩，只遮挡点击事件

```dart
MyUI.showMask();
MyUI.hideMask();
```