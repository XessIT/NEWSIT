import 'package:flutter/material.dart';

import 'color_resources.dart';


class AppThemes {
  static final appThemeData = {
    AppTheme.lightTheme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 10.0,
          color: ColorResource.colorFFFFFF,
        ),
      ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.white),
    ),
    AppTheme.darkTheme: ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.white),
    //  backgroundColor: Colors.black,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: 'Roboto-Regular',
          fontSize: 12.0,
          color: ColorResource.colorFFFFFF,
        ),
      ),
    )
  };

  getThemeCollections() {}
}

enum AppTheme {
  lightTheme,
  darkTheme,
}
