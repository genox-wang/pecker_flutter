import 'package:flutter/material.dart';

import '../../utils/index.dart';

class MyWidgetFactory {
  static AppBar appBar(
    BuildContext context, {
    String? title,
    PreferredSizeWidget? bottom,
    bool centerTitle = true,
    List<Widget>? actions,
    bool hideBack = false,
  }) =>
      AppBar(
        centerTitle: centerTitle,
        title: title == null
            ? null
            : Text(
                title,
                style: TextStyle(
                  fontSize: 50.sp,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconTheme.of(context).copyWith(
          color: Theme.of(context).textTheme.bodyText1?.color,
        ),
        leading: hideBack ? SizedBox() : null,
        actions: actions,
        bottom: bottom,
      );
}
