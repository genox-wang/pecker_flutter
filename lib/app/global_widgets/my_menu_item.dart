import 'package:flutter/material.dart';

class MyMenuItem extends StatelessWidget {
  MyMenuItem({
    required this.title,
    this.onTap,
  });

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
}
