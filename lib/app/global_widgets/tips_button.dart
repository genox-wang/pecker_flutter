import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

import '../../utils/index.dart';
import '../data/services/vibration_service.dart';
import 'anim_button.dart';

class TipsButton extends StatelessWidget {
  TipsButton({
    this.width,
    this.title,
    this.onTap,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.white,
    this.isLeft = false,
    this.animateIn = false,
    this.icon,
    this.backgroundColors,
    this.height,
    this.fontSize,
  });

  final double? width;
  final String? title;
  final Widget? icon;
  final Function()? onTap;
  final Color backgroundColor;
  final List<Color>? backgroundColors;
  final Color textColor;
  final double? fontSize;
  // 按钮是否靠左边
  final bool isLeft;
  final bool animateIn;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return buildAnimate(
      context,
      builder: buildButton,
    );
  }

  Widget buildButton(BuildContext context) {
    final h = height ?? 70.w;
    return AnimButton(
      onTap: onTap != null
          ? () {
              VibrationService.to.tapVibrate();
              onTap?.call();
            }
          : null,
      child: Container(
        padding: EdgeInsets.only(
          left: isLeft ? 25.w : 0,
          right: isLeft ? 0 : 25.w,
        ),
        width: width ?? 210.w,
        height: h,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: backgroundColors == null
              ? null
              : LinearGradient(colors: backgroundColors!),
          borderRadius: BorderRadius.only(
            topRight: isLeft ? Radius.circular(h) : Radius.zero,
            bottomRight: isLeft ? Radius.circular(h) : Radius.zero,
            topLeft: !isLeft ? Radius.circular(h) : Radius.zero,
            bottomLeft: !isLeft ? Radius.circular(h) : Radius.zero,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 0.5),
            ),
          ],
        ),
        alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) icon!,
            if (title != null)
              Text(
                title!,
                style: TextStyle(
                  fontSize: fontSize ?? 35.sp,
                  color: textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildAnimate(BuildContext context,
      {required Widget Function(BuildContext) builder}) {
    return animateIn
        ? PlayAnimation<double>(
            tween: 0.0.tweenTo(1.0).curved(Curves.easeOutCubic),
            delay: 0.2.seconds,
            duration: 0.3.seconds,
            builder: (context, child, value) => FractionalTranslation(
              translation: Offset(isLeft ? value - 1 : 1 - value, 0),
              child: builder(context),
            ),
          )
        : builder(context);
  }
}
