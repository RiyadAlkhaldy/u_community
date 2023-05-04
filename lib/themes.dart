import 'package:flutter/material.dart';

class MyThemes {
  static final primary = Colors.blue;
  static final primaryColor = Colors.blue.shade300;

  static final darkTheme = ThemeData(
      // scaffoldBackgroundColor: Colors.grey.shade900,
      primaryColorDark: primaryColor,
      colorScheme: ColorScheme.dark(primary: primary),
      dividerColor: Colors.white,
      textTheme: TextTheme(
          titleSmall: TextStyle(
        // backgroundColor: Colors.blue,
        fontWeight: FontWeight.bold,
        // fontStyle: FontStyle.normal
      )));

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColorLight: primaryColor,
    colorScheme: ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
    dividerTheme: DividerThemeData(
      color: Colors.black,
    ),
  );
}
