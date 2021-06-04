import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:supercharged/supercharged.dart';

import '../app/data/services/index.dart';
import '../app/global_widgets/index.dart';
import '../app/routes/app_pages.dart';
import 'screen.dart';

class MyUI {
  /// 通用 snackbar 基于 Get.snackbar 包装
  ///
  /// [title] 标题
  /// [message] 信息
  /// [icon] 左侧 icon
  /// [mainButton] 右侧按钮
  /// [duration] 打开时间
  /// [overlayBlur] 背景模糊度
  /// [instantInit] 如果设置成 false 可以在 initState 里调用
  static snackbar(
    String title,
    String message, {
    Icon? icon,
    TextButton? mainButton,
    Duration duration = const Duration(seconds: 6),
    double overlayBlur = 0,
    bool instantInit: true,
  }) {
    Get.snackbar(
      title,
      message,
      icon: icon,
      titleText: Text(
        title,
        style: TextStyle(
          fontSize: 40.sp,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(
          fontSize: 32.sp,
          color: Colors.white,
        ),
      ),
      instantInit: instantInit,
      backgroundColor: Colors.black45,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.symmetric(vertical: 120.w, horizontal: 40.w),
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      mainButton: mainButton,
      snackStyle: SnackStyle.FLOATING,
      boxShadows: [
        BoxShadow(
          offset: Offset(0.0, 6.0),
          blurRadius: 10.0,
          spreadRadius: 0.0,
          color: Colors.black12,
        ),
      ],
      overlayBlur: overlayBlur,
      animationDuration: 200.milliseconds,
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      duration: duration,
    );
  }

  /// 默认弹窗，多次调用，按顺序弹出
  ///
  /// ```
  /// MyUI.showSyncDefaultDialog(
  ///     title: '账号被踢出', body: '您的账号在其他设备登录！', confirmText: '确定');
  /// ```
  static Future showSyncDefaultDialog(
      {String title: '',
      String body = '',
      String confirmText = '',
      String cancelText = '',
      bool willPop = true,
      bool barrierDismissible = true,
      bool hasClose = true,
      String? routeName}) {
    return TaskService.to.doTask(
      () => showDefaultDialog(
        title: title,
        body: body,
        confirmText: confirmText,
        cancelText: cancelText,
        willPop: willPop,
        barrierDismissible: barrierDismissible,
        hasClose: hasClose,
        routeName: routeName,
      ),
    );
  }

  /// 默认弹窗
  ///
  /// ```
  /// await MyUI.showDefaultDialog(
  ///   title: 'v $version 更新内容',
  ///   body: _infos['${buildNumber ~/ 100}']!,
  ///   confirmText: '知道了',
  ///   barrierDismissible: false);
  /// ```
  ///
  /// [title] 标题
  /// [body] 详情
  /// [hasClose] 是否显示右上角关闭按钮
  /// [routeName] 路由名
  static Future<dynamic> showDefaultDialog(
      {String title: '',
      String body = '',
      String confirmText = '',
      String cancelText = '',
      bool willPop = true,
      bool barrierDismissible = true,
      bool hasClose = true,
      String? routeName}) {
    return Get.dialog(
      MyDialog(
        titleText: title,
        bodyText: body,
        cancelText: cancelText,
        confirmText: confirmText,
        willPop: willPop,
        hasClose: hasClose,
      ),
      transitionDuration: Duration.zero,
      barrierDismissible: barrierDismissible,
      routeSettings: RouteSettings(name: routeName ?? ''),
    );
  }

  /// 自定义弹窗，多次调用，按顺序弹出
  static Future<dynamic> showSyncDialog(
      {String titleText: '',
      String bodyText = '',
      String confirmText = '',
      String cancelText = '',
      bool barrierDismissible = true,
      Color? backgroundColor,
      Widget? title,
      bool willPop = true,
      Widget? body,
      Future<bool> Function()? onConfirm,
      bool hasClose = true,
      String? routeName}) {
    return TaskService.to.doTask(
      () => showDialog(
        titleText: titleText,
        bodyText: bodyText,
        confirmText: confirmText,
        cancelText: cancelText,
        barrierDismissible: barrierDismissible,
        backgroundColor: backgroundColor,
        title: title,
        willPop: willPop,
        body: body,
        onConfirm: onConfirm,
        hasClose: hasClose,
        routeName: routeName,
      ),
    );
  }

  /// 自定义弹窗
  ///
  /// ```
  /// MyUI.showDialog(
  ///    titleText: '选择训练难度',
  ///    body: Container(
  ///      height: 300,
  ///      padding: EdgeInsets.only(top: 20, bottom: 20),
  ///      child: Column(
  ///        mainAxisAlignment: MainAxisAlignment.spaceBetween,
  ///        children: List.generate(
  ///         3,
  ///         (index) => Text('难度$index'),
  ///        ),
  ///      ),
  ///    )
  /// )
  /// ```
  ///
  /// [titleText] 标题
  /// [title] 标题 Widget
  /// [bodyText] 详情
  /// [body] 详情 Widget
  /// [hasClose] 是否显示右上角关闭按钮
  /// [routeName] 路由名
  /// [backgroundColor] 背景色
  /// [onConfirm] 提交按钮被点击，返回 true，才关闭
  static Future<dynamic> showDialog(
      {String titleText: '标题',
      String bodyText = '内容',
      String confirmText = '',
      String cancelText = '',
      bool barrierDismissible = true,
      Color? backgroundColor,
      Widget? title,
      bool willPop = true,
      Widget? body,
      Future<bool> Function()? onConfirm,
      bool hasClose = true,
      String? routeName}) {
    return Get.dialog(
        MyDialog(
          title: title,
          titleText: titleText,
          body: body,
          bodyText: bodyText,
          cancelText: cancelText,
          confirmText: confirmText,
          backgroundColor: backgroundColor,
          onConfirm: onConfirm,
          willPop: willPop,
          hasClose: hasClose,
        ),
        barrierDismissible: barrierDismissible,
        transitionDuration: Duration.zero,
        routeSettings: RouteSettings(name: routeName ?? ''));
  }

  /// Page 通过 Dialog 展示， 由于不通过路由无法自动释放 Controller 所以需要通过 [onDispose] 手动释放
  ///
  /// ```
  /// MyUI.showPageDailog(
  ///   routeName: Routes.LOGIN,
  ///   titleText: '登录注册',
  ///   onDispose: loginBindingDispose,
  /// )
  /// ```
  ///
  /// [titleText] 标题
  /// [title] 标题 Widget
  /// [bodyText] 详情
  /// [body] 详情 Widget
  /// [hasClose] 是否显示右上角关闭按钮
  /// [routeName] 路由名
  /// [backgroundColor] 背景色
  /// [onConfirm] 提交按钮被点击，返回 true，才关闭
  /// [arguments] 路由传参
  static Future showPageDailog({
    String titleText: '',
    String confirmText = '',
    String cancelText = '',
    Widget? title,
    bool barrierDismissible = true,
    Color? backgroundColor,
    bool willPop = true,
    bool hasClose = true,
    Object? arguments,
    Future<bool> Function()? onConfirm,
    required String routeName,
    required Function onDispose,
  }) {
    final GetPage page = AppPages.routes.firstWhere((r) => r.name == routeName);

    page.binding?.dependencies();

    return Get.dialog(
      ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: Get.size.height - Get.mediaQuery.padding.top - 20),
        child: MyDialog(
          title: title,
          titleText: titleText,
          body: page.page(),
          width: 1000.w,
          cancelText: cancelText,
          confirmText: confirmText,
          backgroundColor: backgroundColor,
          onConfirm: onConfirm,
          willPop: willPop,
          hasClose: hasClose,
        ),
      ),
      barrierDismissible: barrierDismissible,
      transitionDuration: Duration.zero,
      routeSettings: RouteSettings(
        name: routeName,
        arguments: arguments,
      ),
    ).then((value) {
      onDispose();
      return value;
    });
  }

  /// Page 通过 BottomSheet 展示，由于不通过路由无法自动释放 Controller 所以需要通过 [onDispose] 手动释放
  ///
  /// ```
  ///  MyUI.showPageBottomSheet(
  ///    routeName: Routes.STAGE_LIST, onDispose: stageListBindingDispose);
  /// ```
  ///
  /// [routeName] 路由名
  /// [arguments] 路由传参
  static Future showPageBottomSheet({
    required String routeName,
    required Function onDispose,
    Object? arguments,
  }) {
    final GetPage page = AppPages.routes.firstWhere((r) => r.name == routeName);

    page.binding?.dependencies();

    return Get.bottomSheet(
      ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: Get.size.height - Get.mediaQuery.padding.top - 20),
        child: page.page(),
      ),
      isScrollControlled: true,
      ignoreSafeArea: true,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      barrierColor: Colors.black.withAlpha(40),
      settings: RouteSettings(name: routeName, arguments: arguments),
    ).then((value) {
      onDispose();
      return value;
    });
  }

  // 通用底部弹窗
  static Future showBottomSheet({Widget? child}) {
    return Get.bottomSheet(
      ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: Get.size.height - Get.mediaQuery.padding.top - 20),
        child: child,
      ),
      isScrollControlled: true,
      ignoreSafeArea: true,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      barrierColor: Colors.black.withAlpha(40),
    );
  }

  // 通用底部选择菜单

  /// ```
  /// final level = await MyUI.showSelectionBottomSheet(
  ///    selections: List.generate(3,
  ///        (index) => '难度$index')),
  ///    title: '配置游戏难度',
  ///    backgroundColor: Color(0xFF8800FF),
  ///    textColor: Colors.white,
  ///    dividerColor: Colors.purple.shade300,
  ///    routeName: 'battle_custom_room_level_selection',
  /// );
  /// if (level is int) {
  ///   ...
  /// }
  /// ```
  static Future showSelectionBottomSheet({
    required List<String> selections,
    String? title,
    String? routeName,
  }) {
    return Get.bottomSheet(
      ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: Get.size.height - Get.mediaQuery.padding.top - 20),
        child: MySelectionBottomSheet(
          title: title,
          selections: selections,
        ),
      ),
      ignoreSafeArea: true,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      barrierColor: Colors.black.withAlpha(40),
      settings: RouteSettings(name: routeName ?? ''),
    );
  }

  /// 关联组件的气泡弹窗
  ///
  ///```
  /// MyUI.showAttachedBubble(
  ///   context: themeButtonKey.currentContext!,
  ///   backgroundColor: Colors.white,
  ///   borderColor: Colors.black,
  ///   isDashedBorder: false,
  ///   borderSize: 3,
  ///   builder: (close) {
  ///     return Container(width:100, height:100);
  ///   }
  /// );
  ///```
  ///
  /// [builder] 自定义气泡内部的渲染
  /// [context] 目标组件的上下文
  /// [isDashedBorder] 边框是否虚线
  static showAttachedBubble({
    required BuildContext context,
    required Widget Function(Function()) builder,
    Color? backgroundColor,
    Color? borderColor,
    Duration? duration,
    double? borderSize,
    bool? isDashedBorder = false,
  }) {
    final box = context.findRenderObject() as RenderBox;
    final targetCenter = box.localToGlobal(Offset.zero) +
        Offset(box.paintBounds.width / 2, box.paintBounds.height / 2);
    BotToast.showAttachedWidget(
      duration: duration,
      attachedBuilder: (closeBubble) => MyBubbleBox(
        targetCenterOffset: targetCenter,
        backgroundColor: backgroundColor,
        child: builder(closeBubble),
        borderColor: borderColor,
        borderSize: borderSize,
        isDashedBorder: isDashedBorder ?? false,
      ),
      targetContext: context,
      preferDirection: PreferDirection.topCenter,
    );
  }

  static UniqueKey? _loadingKey;

  static final _loadingShowed = false.obs;
  static get loadingShowed => _loadingShowed.value;
  static set loadingShowed(value) => _loadingShowed.value = value;

  /// 展示加载动画，全屏添加遮罩，阻止点击事件
  ///
  /// ```
  /// MyUI.showLoadng();
  ///
  /// await doSomethine();
  ///
  /// MyUI.hideLoading();
  ///
  /// ```
  static showLoading() {
    if (_loadingKey != null) {
      return;
    }
    loadingShowed = true;
    _loadingKey = UniqueKey();
    BotToast.showWidget(
      toastBuilder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              width: 400.w,
              height: 400.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: Colors.black26),
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        );
      },
      key: _loadingKey,
    );
  }

  /// 隐藏加载动画
  static hideLoading() {
    if (_loadingKey == null) {
      return;
    }
    loadingShowed = false;
    BotToast.remove(_loadingKey!);
    _loadingKey = null;
  }

  static UniqueKey? _maskKey;

  // 添加全局透明遮罩，只阻挡点击事件
  static showMask() {
    if (_maskKey != null) {
      return;
    }
    _maskKey = UniqueKey();
    BotToast.showWidget(
      toastBuilder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {},
        );
      },
      key: _maskKey,
    );
  }

  // 隐藏遮罩
  static hideMask() {
    if (_maskKey == null) {
      return;
    }
    BotToast.remove(_maskKey!);
    _maskKey = null;
  }
}
