import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pecker_flutter/app/global_widgets/index.dart';
import 'package:pecker_flutter/utils/index.dart';

import '../../../data/services/index.dart';

class HomeController extends GetxController {
  final bubbleBoxBtnKey = GlobalKey();

  @override
  void onInit() {
    TaskService.to.contextGot.complete();
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
