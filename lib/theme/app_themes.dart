import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import 'color_resources.dart';

class AppThemes {
  static const int darkBlue = 0;
  static const int lightOrange = 1;

  ThemeCollection getThemeCollections() {
    final ThemeData base = ThemeData.light();

    return ThemeCollection(themes: {
      AppThemes.darkBlue: ThemeData(
        primarySwatch: const MaterialColor(
          0xff020E36,
          <int, Color>{
            50: Color(0xff020E36),
            100: Color(0xff020E36),
            200: Color(0xff020E36),
            300: Color(0xff020E36),
            400: Color(0xff020E36),
            500: Color(0xff020E36),
            600: Color(0xff020E36),
            700: Color(0xff020E36),
            800: Color(0xff020E36),
            900: Color(0xff020E36),
          },
        ),
        scaffoldBackgroundColor: Colors.black,
        primaryColor: ColorResource.colorE02E23,
        textTheme: AppThemes().basicTextTheme(base.textTheme),
        floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
          backgroundColor: ColorResource.colorF58220,
        ),
        appBarTheme: const AppBarTheme(
          color: ColorResource.colorFFFFFF, // Set your AppBar color here
          iconTheme:
          IconThemeData(color: Colors.black), // Set AppBar icon color here
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          unselectedIconTheme: IconThemeData(color: Colors.white),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.red,
          selectedIconTheme: IconThemeData(color: Colors.red),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: CustomButtonTheme.primaryButtonStyle(),
        ),
      ),
      AppThemes.lightOrange: ThemeData(
        primarySwatch: const MaterialColor(
          0xffFDF3E6,
          <int, Color>{
            50: Color(0xffFDF3E6),
            100: Color(0xffFDF3E6),
            200: Color(0xffFDF3E6),
            300: Color(0xffFDF3E6),
            400: Color(0xffFDF3E6),
            500: Color(0xffFDF3E6),
            600: Color(0xffFDF3E6),
            700: Color(0xffFDF3E6),
            800: Color(0xffFDF3E6),
            900: Color(0xffFDF3E6),
          },
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: AppThemes().basicTextTheme(base.textTheme),
        floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
          backgroundColor: ColorResource.colorFDF3E6,
        ),
        appBarTheme: const AppBarTheme(
          color: ColorResource.colorFFFFFF, // Set your AppBar color here
          iconTheme:
          IconThemeData(color: Colors.black), // Set AppBar icon color here
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(color: Colors.white),
          unselectedLabelStyle: TextStyle(color: Colors.white),
          selectedIconTheme: IconThemeData(color: Colors.red),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: CustomButtonTheme.primaryButtonStyle(),
        ),
      ),
    });
  }

  static String toStr(int themeId) {
    switch (themeId) {
      case darkBlue:
        return 'Dark Blue';
      case lightOrange:
        return 'Light Orange';
      default:
        return 'Unknown';
    }
  }

  TextTheme basicTextTheme(TextTheme base) {
    return base.copyWith(
      // Used for font size of 6
      bodySmall: base.bodySmall!.copyWith(
        fontFamily: 'Poppins-Regular',
        fontSize: 6.0,
        color: ColorResource.colorFFFFFF,
        fontWeight: FontWeight.w400,
      ),
      // Used for font size of 12//subTitle
      titleMedium: base.titleMedium!.copyWith(
        fontFamily: 'Poppins-Regular',
        fontSize: 14,
        color: ColorResource.color767C86,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: base.titleSmall!.copyWith(
        fontFamily: 'Poppins-Regular',
        fontSize: 13.0,
        color: ColorResource.color767C86,
        fontWeight: FontWeight.w300,
      ),
      // Used for font size of 14,16//labelText
      bodyMedium: base.bodyMedium!.copyWith(
        fontFamily: 'Poppins-Regular',
        fontSize: 14.0,
        color: ColorResource.color767C86,
      ),
      // Used for emphasizing text and font size of 18,20,22//hintText
      bodyLarge: base.bodyLarge!.copyWith(
        fontFamily: 'Poppins-Regular',
        fontSize: 14.0,
        color: ColorResource.color414A58,
      ),
      // Used for large text in dialogs and font size of 24
      displayLarge: base.displayLarge!.copyWith(
        fontFamily: 'Poppins-Medium',
        fontSize: 22.0,
        color: ColorResource.color333333,
        fontWeight: FontWeight.bold,
      ),
      // Used for the primary text in app bars and font size of 26,28 and greater
      displayMedium: base.displayMedium!.copyWith(
        fontFamily: 'Poppins-Medium',
        fontSize: 18.0,
        color: ColorResource.color333333,
        fontWeight: FontWeight.w700,
      ),
      // used for button  //Title
      displaySmall: base.displaySmall!.copyWith(
        fontFamily: 'Poppins-Medium',
        fontSize: 16.0,
        color: ColorResource.color333333,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: base.labelLarge!.copyWith(
        fontFamily: 'Poppins-Regular',
        fontSize: 12.0,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: base.headlineLarge!.copyWith(
        fontFamily: 'Poppins-Medium',
        fontSize: 16.0,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}




class CustomButtonTheme {
  static ButtonStyle primaryButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent, // Transparent to allow gradient background
      shadowColor: Colors.transparent, // No shadow to maintain design
      padding: EdgeInsets.zero, // Padding handled inside the button
      minimumSize: Size(343, 48), // Fixed width and height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  static ButtonStyle otpButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF3B82F6), // Blue color as shown in the image
      minimumSize: Size(343, 48), // Fixed width and height
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0, // No shadow
    );
  }
}


