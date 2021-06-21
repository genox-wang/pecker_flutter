import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '../../generated/locales.g.dart';
import '../../utils/screen.dart';

/// 底部弹出选择框
class MySelectionBottomSheet extends StatelessWidget {
  MySelectionBottomSheet({
    this.title,
    required this.selections,
  });

  final String? title;
  final List<String> selections;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    selections.forEachIndexed((index, element) {
      final idx = index;
      children.add(
        buildButton(
            height: 130.w,
            text: element,
            onTap: () {
              Get.back(result: idx);
            }),
      );
      if (index < selections.length - 1) {
        children.add(
          Divider(
            indent: 15,
            endIndent: 15,
            height: 5,
            thickness: 1,
          ),
        );
      }
    });

    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Container(
              height: 160.w,
              alignment: Alignment.center,
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 5, spreadRadius: 0.5),
                ],
                color: Theme.of(context).cardColor,
              ),
            ),
          SizedBox(
            height: 20.w,
          ),
          ...children,
          Divider(
            height: 20.w,
            thickness: 20.w,
          ),
          buildButton(
              height: 150.w,
              text: LocaleKeys.app_cancel.tr,
              onTap: () => Get.back()),
          SizedBox(
            height: Get.mediaQuery.padding.bottom,
          ),
        ],
      ),
    );
  }

  Widget buildButton({
    Function()? onTap,
    required String text,
    required double height,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: height,
        // color: Theme.of(context).cardColor,
        alignment: Alignment.center,
        child: Text(text, style: TextStyle(fontSize: 40.sp)),
      ),
    );
  }
}
