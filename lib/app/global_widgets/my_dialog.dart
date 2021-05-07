import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../utils/screen.dart';
import 'controllers/my_button_controller.dart';
import 'my_button.dart';
import 'pop_anim_box.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({
    Key? key,
    this.backgroundColor,
    this.insetAnimationDuration,
    this.insetAnimationCurve,
    this.insetPadding,
    this.title,
    this.body,
    this.titleText = 'title',
    this.bodyText = 'body',
    this.confirmText = 'OK',
    this.cancelText = 'CANCEL',
    this.onConfirm,
    this.willPop = true,
    this.hasClose = false,
  }) : super(
          key: key,
        );
  final Color? backgroundColor;
  final Duration? insetAnimationDuration;
  final Curve? insetAnimationCurve;
  final EdgeInsets? insetPadding;
  final Widget? title;
  final Widget? body;
  final String titleText;
  final String bodyText;
  final String confirmText;
  final String cancelText;
  final Future<bool> Function(MyButtonController)? onConfirm;
  final bool willPop;
  final bool hasClose;

  @override
  Widget build(BuildContext context) {
    final child = Dialog(
      backgroundColor:
          backgroundColor ?? Theme.of(context).dialogTheme.backgroundColor,
      insetPadding: insetPadding ?? EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.w)),
      // elevation: 0,
      child: Container(
        constraints: BoxConstraints(
          minHeight: 100,
        ),
        width: 900.w,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                title ??
                    Container(
                      height: 160.w,
                      alignment: Alignment.center,
                      child: Text(
                        titleText,
                        style: TextStyle(
                          fontSize: 50.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                Divider(
                  thickness: 1.5,
                  indent: 50.w,
                  endIndent: 50.w,
                  height: 1.5,
                ),
                body ??
                    Padding(
                      padding: EdgeInsets.fromLTRB(80.w, 80.w, 80.w, 80.w),
                      child: Text(
                        bodyText,
                        style: TextStyle(
                          fontSize: 40.sp,
                        ),
                      ),
                    ),
                cancelText.isNotEmpty == true || confirmText.isNotEmpty == true
                    ? Container(
                        child: Row(
                          children: [
                            SizedBox(width: 30.w),
                            if (cancelText.isNotEmpty == true)
                              buildButton(
                                text: cancelText,
                                color: Colors.orange,
                                onTap: (_) {
                                  Get.back(
                                    result: MyDialogActions.cancel,
                                  );
                                },
                              ),
                            if (cancelText.isNotEmpty == true &&
                                confirmText.isNotEmpty == true)
                              SizedBox(width: 30.w),
                            if (confirmText.isNotEmpty == true)
                              buildButton(
                                text: confirmText,
                                color: Theme.of(context).primaryColor,
                                onTap: (controller) async {
                                  bool isClose = true;
                                  if (onConfirm != null) {
                                    isClose = await onConfirm!(controller);
                                  }
                                  if (isClose) {
                                    Get.back(
                                      result: MyDialogActions.confirm,
                                    );
                                  }
                                },
                              ),
                            SizedBox(width: 30.w),
                          ],
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 30.w),
              ],
            ),
            if (hasClose)
              Positioned(
                top: 10.w,
                right: 10.w,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 50.w,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              )
          ],
        ),
        // color: Colors.white,
      ),
    );
    return willPop
        ? PopAnimBox(child: child)
        : WillPopScope(
            child: PopAnimBox(child: child), onWillPop: () async => false);
  }

  buildButton({
    required String text,
    required Color color,
    Function(MyButtonController)? onTap,
  }) {
    return Flexible(
      child: MyButton(
        height: 130.w,
        text: text,
        radius: 130.w,
        fontSize: 40.sp,
        backgroundColor: color,
        fontColor: Colors.white,
        onTap: (conroller) {
          onTap?.call(conroller);
        },
      ),
    );
  }
}

enum MyDialogActions { confirm, cancel }
