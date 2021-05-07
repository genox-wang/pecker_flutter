import 'package:flutter/material.dart';

import '../../utils/index.dart';
import 'controllers/my_button_controller.dart';
import 'my_button.dart';

class MyCommonButton extends StatelessWidget {
  MyCommonButton({
    required this.color,
    required this.width,
    required this.height,
    required this.title,
    this.titleSize,
    this.sub,
    required this.titleColor,
    this.subColor,
    this.onTap,
    this.simpleButtonGroup,
  });

  final Color color;
  final double width;
  final double height;
  final double? titleSize;
  final String title;
  final String? sub;
  final Color titleColor;
  final Color? subColor;
  final Function(MyButtonController)? onTap;
  final Object? simpleButtonGroup;

  @override
  Widget build(BuildContext context) {
    return MyButton(
      backgroundColor: color,
      group: simpleButtonGroup,
      width: width,
      height: height,
      radius: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize ?? 44.sp,
              color: titleColor,
            ),
          ),
          if (sub != null)
            Text(
              sub!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.sp,
                color: subColor ?? Colors.white,
              ),
            )
        ],
      ),
      onTap: onTap,
    );
  }
}
