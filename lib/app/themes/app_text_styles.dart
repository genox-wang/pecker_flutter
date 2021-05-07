import 'package:flutter/material.dart';

import '../../utils/screen.dart';

class AppTextStyles {
  static const _TITLE_SIZE = 50;
  static const _SUB_TITLE_SIZE = 45;
  static const _BODY_SIZE = 40;
  static const _SUB_BODY_SIZE = 32;

  static TextStyle get title => TextStyle(
        fontSize: _TITLE_SIZE.sp,
        // fontWeight: FontWeight.bold,
      );

  static TextStyle get subTitle => TextStyle(fontSize: _SUB_TITLE_SIZE.sp);

  static TextStyle get body => TextStyle(fontSize: _BODY_SIZE.sp);

  static TextStyle get subBody => TextStyle(
        fontSize: _SUB_BODY_SIZE.sp,
        fontWeight: FontWeight.w300,
      );
}

extension TextStyleExtensions on TextStyle {
  TextStyle get bold => this.merge(TextStyle(fontWeight: FontWeight.bold));

  TextStyle get normal => this.merge(TextStyle(fontWeight: FontWeight.normal));

  TextStyle get w300 => this.merge(TextStyle(fontWeight: FontWeight.w300));
}
