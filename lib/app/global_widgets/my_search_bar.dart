import 'package:flutter/material.dart';

import '../../utils/screen.dart';

/// 通用搜索框
class MySearchBar extends StatelessWidget {
  MySearchBar({
    this.width,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.fontSize,
    this.controller,
    this.onChanged,
    this.onEditingComplete,
    this.readOnly = false,
    this.enabled = true,
    this.iconSize,
  });

  final double? width;
  final double? height;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? hintText;
  final Color? hintColor;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? iconSize;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final bool readOnly;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.w),
    );
    return SizedBox(
      width: width ?? ScreenUtil.screenWidth - 30.w,
      height: height ?? 85.w,
      child: TextField(
        textAlign: TextAlign.left,
        style: TextStyle(
          color: textColor ?? Theme.of(context).textTheme.bodyText1?.color,
          fontSize: fontSize ?? 38.sp,
        ),
        cursorColor: Theme.of(context).dividerColor,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            isDense: true,
            hintText: hintText ?? '搜索',
            hintStyle: TextStyle(
              color: hintColor ?? Theme.of(context).disabledColor,
              fontSize: fontSize ?? 38.sp,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: hintColor ?? Theme.of(context).disabledColor,
                    size: iconSize ?? 47.w,
                  )
                : Icon(
                    Icons.search,
                    color: hintColor ?? Theme.of(context).disabledColor,
                    size: iconSize ?? 47.w,
                  ),
            suffix: suffixIcon != null
                ? Icon(
                    suffixIcon,
                    color: hintColor ?? Theme.of(context).disabledColor,
                    size: iconSize ?? 47.w,
                  )
                : null,
            prefixIconConstraints: BoxConstraints(
              minWidth: height ?? 85.w,
              minHeight: height ?? 85.w,
            ),
            suffixIconConstraints: BoxConstraints(
              minWidth: height ?? 85.w,
              minHeight: height ?? 85.w,
            ),
            filled: true,
            fillColor: backgroundColor ?? Theme.of(context).cardColor,
            disabledBorder: inputBorder,
            errorBorder: inputBorder,
            focusedBorder: inputBorder,
            focusedErrorBorder: inputBorder,
            border: inputBorder),
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        readOnly: readOnly,
        enabled: enabled,
      ),
    );
  }
}
