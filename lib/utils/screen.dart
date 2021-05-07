import 'package:flutter/material.dart';

class ScreenUtil {
  ScreenUtil._();

  static late MediaQueryData _mediaQueryData;

  /// UI 设计图的宽度
  static const double _defaultWidth = 1080;

  /// UI 设计图的高度
  static const double _defaultHeight = 1960;

  static late num _uiWidthPx;
  static late num _uiHeightPx;

  /// 屏幕宽度(dp)
  static late double _screenWidth;

  /// 屏幕高度(dp)
  static late double _screenHeight;

  /// 设备像素密度
  static late double _pixelRatio;

  /// 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  static late double _textScaleFactor;

  static late bool _allowFontScaling;

  static late double _px;

  static late double _rpx;

  static void initialize(BuildContext context,
      {double standardWidth = _defaultWidth,
      double standardHeight = _defaultHeight,
      bool allowFontScaling = false}) {
    _uiWidthPx = standardWidth;
    _uiHeightPx = standardHeight;

    _mediaQueryData = MediaQuery.of(context);
    // if (_mediaQueryData.size.width == _screenWidth &&
    //     _mediaQueryData.size.height == _screenHeight) {
    //   return;
    // }
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;

    _pixelRatio = _mediaQueryData.devicePixelRatio;

    _textScaleFactor = _mediaQueryData.textScaleFactor;

    // shortLogger.e(
    //     "ScreenUtil.init  _pixelRatio $_pixelRatio _textScaleFactor $_textScaleFactor $screenWidth- $screenHeight");

    _allowFontScaling = allowFontScaling;
    _rpx = _screenWidth / _uiWidthPx;
    _px = _screenHeight / _uiHeightPx * 2;
  }

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactor => _textScaleFactor;

  static double get pixelRatio => _pixelRatio;

  static double get screenWidth => _screenWidth;

  static double get screenHeight => _screenHeight;

  /// 设备宽度 px
  static double get screenWidthPx => _screenWidth * _pixelRatio;

  /// 设备高度 px
  static double get screenHeightPx => _screenHeight * _pixelRatio;

  /// 实际的dp与UI设计px的比例
  static double get scaleWidth => _screenWidth / _uiWidthPx;

  static double get scaleHeight => _screenHeight / _uiHeightPx;

  static double get scaleText => scaleWidth;

  static double setPx(double size) => _rpx * size * 2; //原型图像素为*2，所以这里需要扩大2倍

  static double setRpx(double size) => _px * size;

  static double setWidth(double size) => size * scaleWidth;

  static double setHeight(double size) => size * scaleHeight;

  static double setSp(double size, {bool? allowFontScalingSelf}) =>
      allowFontScalingSelf == null
          ? (_allowFontScaling
              ? (size * scaleText)
              : ((size * scaleText) / _textScaleFactor))
          : (allowFontScalingSelf
              ? (size * scaleText)
              : ((size * scaleText) / _textScaleFactor));

  static double setWidthPercent(double percent) =>
      (_screenWidth * percent) / 100;

  static double setHeightPercent(double percent) =>
      (_screenHeight * percent) / 100;

  static double get safeTop => _mediaQueryData.padding.top;

  static double get safeBottom => _mediaQueryData.padding.bottom;
}

extension NumExtensions on num {
  double get px => ScreenUtil.setPx(this.toDouble());

  double get rpx => ScreenUtil.setRpx(this.toDouble());

  double get w => ScreenUtil.setWidth(this.toDouble());

  double get h => ScreenUtil.setHeight(this.toDouble());

  double get sp =>
      ScreenUtil.setSp(this.toDouble(), allowFontScalingSelf: false);

  double get asp =>
      ScreenUtil.setSp(this.toDouble(), allowFontScalingSelf: true);

  double get wp => ScreenUtil.setWidthPercent(this.toDouble());

  double get hp => ScreenUtil.setHeightPercent(this.toDouble());
}
