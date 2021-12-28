import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'AppColors.dart';

class AppThemeData {
  //
  AppThemeData._();
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: whiteColor, 
    primaryColor: AppColors.appColorPrimary,
    primaryColorDark: AppColors.appColorPrimary,
    errorColor: Colors.red,
    hoverColor: Colors.grey,
    dividerColor: viewLineColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      color: AppColors.appLayout_background,
      iconTheme: IconThemeData(color: textPrimaryColor),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.appColorPrimary,
      primaryVariant: AppColors.appColorPrimary,
    ),
    cardTheme: CardTheme(color: Colors.white),
    iconTheme: IconThemeData(color: textPrimaryColor),
    textTheme: TextTheme(
      button: TextStyle(color: AppColors.appColorPrimary),
      headline6: TextStyle(color: textPrimaryColor),
      subtitle2: TextStyle(color: textSecondaryColor),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.appBackgroundColorDark,
    highlightColor: AppColors.appBackgroundColorDark,
    errorColor: Color(0xFFCF6676),
    appBarTheme: AppBarTheme(
        color: AppColors.appBackgroundColorDark,
        iconTheme: IconThemeData(color: whiteColor)),
    primaryColor: AppColors.color_primary_black,
    accentColor: whiteColor,
    dividerColor: Color(0xFFDADADA),
    primaryColorDark: AppColors.color_primary_black,
    hoverColor: Colors.black,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primaryTextTheme: TextTheme(
      headline6: primaryTextStyle(color: Colors.white),
      overline: primaryTextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.appBackgroundColorDark,
      onPrimary: AppColors.cardBackgroundBlackDark,
      primaryVariant: AppColors.color_primary_black,
    ),
    cardTheme: CardTheme(color: AppColors.cardBackgroundBlackDark),
    iconTheme: IconThemeData(color: whiteColor),
    textTheme: TextTheme(
      button: TextStyle(color: AppColors.color_primary_black),
      headline6: TextStyle(color: whiteColor),
      subtitle2: TextStyle(color: Colors.white54),
    ),
  );
}
// light tjeme
          // button: TextStyle(color: Colors.white),
          // headline: TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
          // display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          // display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          // display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainColor(1)),
          // display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1)),
          // subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondColor(1)),
          // title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainColor(1)),
          // body1: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
          // body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
          // caption: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(0.6)),
// dark them
      // button: TextStyle(color: Color(0xFF252525)),
      //     headline: TextStyle(fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
      //     display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
      //     display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
      //     display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainDarkColor(1)),
      //     display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondDarkColor(1)),
      //     subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
      //     title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainDarkColor(1)),
      //     body1: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
      //     body2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
      //     caption: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),