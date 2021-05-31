import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../app/data/services/index.dart';
import 'index.dart';

class Toast {
  static i(String title, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    show(title, message, LineAwesomeIcons.bell, duration: duration);
  }

  static e(String title, String message,
      {Duration duration = const Duration(seconds: 2)}) {
    show(title, message, LineAwesomeIcons.info_circle, duration: duration);
  }

  static httpE(String title, int? status) {
    e(title, HttpService.to.errorInfo(status));
  }

  static show(String title, String message, IconData iconData,
      {Duration duration = const Duration(seconds: 2)}) {
    BotToast.showEnhancedWidget(
      duration: duration,
      allowClick: true,
      toastBuilder: (closeFunc) => Center(
        child: Container(
          width: 500.w,
          padding: EdgeInsets.all(50.w),
          constraints: BoxConstraints(minHeight: 400.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.w), color: Colors.black54),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 120.w,
                color: Colors.white,
              ),
              SizedBox(height: 30.w),
              Text(
                title,
                style: TextStyle(fontSize: 40.sp, color: Colors.white),
              ),
              SizedBox(height: 20.w),
              Text(
                message,
                softWrap: true,
                style: TextStyle(fontSize: 35.sp, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
