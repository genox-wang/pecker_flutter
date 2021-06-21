import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

import '../../../../utils/index.dart';
import '../../../global_widgets/index.dart';

class GlobalWidgetsSampleController extends GetxController {
  final bubbleBoxBtnKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
  }

  void showBubbleBox() {
    final context = bubbleBoxBtnKey.currentContext!;
    final box = context.findRenderObject() as RenderBox;
    final targetCenter = box.localToGlobal(Offset.zero) +
        Offset(box.paintBounds.width / 2, box.paintBounds.height / 2);
    BotToast.showAttachedWidget(
      attachedBuilder: (closeBubble) => MyBubbleBox(
        targetCenterOffset: targetCenter,
        backgroundColor: Colors.black38,
        child: Text(
          'BubbleBox',
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
      targetContext: context,
    );
  }

  void showMyDialog() {
    Get.dialog(MyDialog(
      backgroundColor: Get.theme.canvasColor,
      titleText: 'MyDialog',
      bodyText: 'Dialog info.',
      confirmText: 'OK',
      cancelText: 'Cancel',
      onConfirm: () async {
        if (MyTools.rand(2) == 0) {
          Toast.i('提交失败', '');
          return false;
        } else {
          return true;
        }
      },
    ));
  }

  void showPopAnimDialog() {
    Get.dialog(
      PopAnimBox(
        child: Dialog(
            child: Container(
          color: Colors.green,
          width: 200,
          height: 100,
        )),
      ),
    );
  }
}
