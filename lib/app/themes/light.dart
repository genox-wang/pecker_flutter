import 'package:flutter/material.dart';

import 'base.dart';

final lightTheme = baseTheme().copyWith(
  primaryColor: Color(0xFF1ac0c6),
  dividerColor: Colors.grey[200],
  dividerTheme: DividerThemeData(space: 1, thickness: 0.7),
  scaffoldBackgroundColor: Colors.grey[100],
  canvasColor: Colors.grey[100],
  cardColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[100],
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
);
