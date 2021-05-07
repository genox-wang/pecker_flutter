import 'package:flutter/material.dart';

import '../../utils/screen.dart';

class MyAppBarAction extends StatelessWidget {
  MyAppBarAction({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final Function(BuildContext)? onTap;
  final GlobalKey iconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        key: iconKey,
      ),
      onPressed: () => onTap?.call(iconKey.currentContext!),
      iconSize: 70.w,
      color: Colors.black,
    );
  }
}
