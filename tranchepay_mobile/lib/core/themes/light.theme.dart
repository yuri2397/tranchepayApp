import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tranchepay_mobile/core/ui.dart';

import '../theme.colors.dart';

class LightTheme {
  get themeData => ThemeData(
      primaryColor: Color(primaryColor),
      scaffoldBackgroundColor: Color(neutralColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0, foregroundColor: Colors.white),
      brightness: Brightness.light,
      dividerColor: Ui.parseColorText("$neutralColor", opacity: 0.1),
      focusColor: Ui.parseColorText("$primaryColor"),
      hintColor: Ui.parseColorText("$primaryColor", opacity: 0.5),
      textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(primary: Ui.parseColorText("$primaryColor")),
      ),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Color(mainColor)),
      textTheme: GoogleFonts.getTextTheme(
        'Poppins',
        TextTheme(
          headline6: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: Ui.parseColorText("#000000"),
              height: 1.3),
          headline5: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Ui.parseColorText("#000000"),
              height: 1.3),
          headline4: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Ui.parseColorText("#000000"),
              height: 1.3),
          headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Ui.parseColorText("#000000"),
              height: 1.3),
          headline2: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: Ui.parseColorText("#000000"),
              height: 1.4),
          headline1: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w300,
              color: Ui.parseColorText("#000000"),
              height: 1.4),
          subtitle2: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: Ui.parseColorText("#000000"),
              height: 1.2),
          subtitle1: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w400,
              color: Ui.parseColorText("#000000"),
              height: 1.2),
          bodyText2: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w600,
              color: Ui.parseColorText("#000000"),
              height: 1.2),
          bodyText1: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: Ui.parseColorText("#000000"),
              height: 1.2),
          caption: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
              color: Colors.black,
              height: 1.2),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: Ui.parseColorText("$primaryColor"),
        secondary: Ui.parseColorText("$secondaryColor"),
      ).copyWith(secondary: Color(accentColor)));
}
