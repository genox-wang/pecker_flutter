import 'dart:ui';

import 'package:flutter/material.dart';

import '../../utils/screen.dart';

class MyAppBarTitle extends StatelessWidget {
  MyAppBarTitle({
    this.title = '',
    this.isBlur = false,
  });

  final String title;
  final bool isBlur;

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(
      title,
      style: TextStyle(
        fontSize: 50.sp,
      ),
    );

    return isBlur
        ? Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 20,
                ),
                child: titleWidget,
              ),
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4,
                      sigmaY: 4,
                    ),
                    child: Container(color: Colors.white10),
                  ),
                ),
              ),
            ],
          )
        : titleWidget;
  }
}
