import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color green = Color(0xff4DB282);
  static const Color lightGreen = Color(0xffDBF0E6);
  static const Color fadedGreen = Color(0xffAEE2C9);
  static Color buttonTextBlack = const Color(0xFF000000).withOpacity(0.73);
  static const Color black = Color(0xFF101314);
  static const Color blackShade = Color(0xFF101314);
  static Color greyShadow = const Color(0xff000000).withOpacity(0.2);
  static const Color grey = Color(0xff797979);
  static const Color textGrey = Color(0xffAAAAAD);
  static Color textGreyShadow = const Color(0xff272827).withOpacity(0.65);
  static const Color borderGrey = Color(0xff636564);
  static const Color white = Color(0xFFFFFFFF);
  static const Color light = Color(0xFFF9F9F9);
  static const Color red = Color(0xFFff4d4f);
  static const Color containerBgcolor = Color(0xFFF8FAFC);
  static const Color textFieldBorderColor = Color(0xFFCBD5E1);
}

class ThemeClass {
  ThemeClass._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.green,
    shadowColor: AppColors.greyShadow,
    cardTheme: CardTheme(
      color: AppColors.light,
      surfaceTintColor: AppColors.greyShadow,
      shadowColor: AppColors.greyShadow,
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.green,
      secondary: AppColors.black,
      error: AppColors.red,
      surface: AppColors.fadedGreen,
      shadow: AppColors.greyShadow,
      // onSurface: AppColors.lightGrey,
      // secondaryContainer: AppColors.lightGreen,
    ),
    fontFamily: "poppins",
    highlightColor: Colors.transparent,
    hintColor: AppColors.borderGrey,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.black,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.green,
      colorScheme: ColorScheme.light(
        error: AppColors.red,
        shadow: AppColors.greyShadow,
        outline: AppColors.borderGrey,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
  );
}
