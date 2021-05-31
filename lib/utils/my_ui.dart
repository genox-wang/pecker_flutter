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
  static snackbar(
    String title,
    String message, {
    Icon? icon,
    TextButton? mainButton,
    Duration duration = const Duration(seconds: 6),
    bool shouldIconPulse = false,
    double overlayBlur = 0,
    SnackType type = SnackType.NORMAL,

    /// with instantInit = false you can put snackbar on initState
    bool instantInit: true,
  }) {
    late Color backgroundColor;
    switch (type) {
      case SnackType.NORMAL:
        backgroundColor = Colors.black45;
        break;
      case SnackType.SUCCESS:
        backgroundColor = Colors.primaries[9].withAlpha(200);
        break;
      case SnackType.ERROR:
        backgroundColor = Colors.primaries[0].withAlpha(200);
        break;
    }
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
      backgroundColor: backgroundColor,
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
      shouldIconPulse: shouldIconPulse,
      animationDuration: 200.milliseconds,
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      // borderColor:
      //     Get.context != null ? Theme.of(Get.context!).disabledColor : null,
      // borderWidth: 1,
      duration: duration,
    );
  }

  static Future showSyncDefaultDialog(
      {String title: '标题',
      String body = '内容',
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

  static Future<dynamic> showDefaultDialog(
      {String title: '标题',
      String body = '内容',
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

  static Future<dynamic> showSyncDialog(
      {String titleText: '标题',
      String bodyText = '内容',
      String confirmText = '',
      String cancelText = '',
      bool barrierDismissible = true,
      Color? backgroundColor,
      Widget? title,
      bool willPop = true,
      Widget? body,
      Future<bool> Function(MyButtonController)? onConfirm,
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
      Future<bool> Function(MyButtonController)? onConfirm,
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
  static Future showPageDailog({
    String titleText: '标题',
    String confirmText = '',
    String cancelText = '',
    Widget? title,
    bool barrierDismissible = true,
    Color? backgroundColor,
    bool willPop = true,
    bool hasClose = true,
    Object? arguments,
    Future<bool> Function(MyButtonController)? onConfirm,
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

  /// Page 通过 BottomSheet 展示， 由于不通过路由无法自动释放 Controller 所以需要通过 [onDispose] 手动释放
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

  static hideLoading() {
    if (_loadingKey == null) {
      return;
    }
    loadingShowed = false;
    BotToast.remove(_loadingKey!);
    _loadingKey = null;
  }

  static UniqueKey? _maskKey;

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

  static hideMask() {
    if (_maskKey == null) {
      return;
    }
    BotToast.remove(_maskKey!);
    _maskKey = null;
  }
}

enum SnackType {
  NORMAL,
  SUCCESS,
  ERROR,
}
