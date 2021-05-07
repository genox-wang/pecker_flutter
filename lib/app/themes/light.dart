import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primaryColor: Color(0xFF1ac0c6),
  // primarySwatch: Colors.blue,
  // 去除 item 点击水波纹
  highlightColor: Color.fromRGBO(0, 0, 0, 0),
  splashColor: Color.fromRGBO(0, 0, 0, 0),
  iconTheme: IconThemeData(color: Colors.blue),
  dividerColor: Colors.grey[100],
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
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFF12878b),
  ),
);
