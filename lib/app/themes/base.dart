import 'package:flutter/material.dart';

final baseTheme = ({Brightness brightness = Brightness.light}) => ThemeData(
      brightness: brightness,
      primaryColor: Color(0xFF1ac0c6),
      // 去除 item 点击水波纹
      highlightColor: Color.fromRGBO(0, 0, 0, 0),
      splashColor: Color.fromRGBO(0, 0, 0, 0),
      iconTheme: IconThemeData(color: Colors.blue),
      errorColor: Colors.deepOrangeAccent,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF0086DE),
      ),
    );
