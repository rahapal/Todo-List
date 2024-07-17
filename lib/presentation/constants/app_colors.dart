import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color green = Color(0xff4DB282);
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
}

class ThemeClass {
  ThemeClass._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.green,
    shadowColor: AppColors.greyShadow,
    colorScheme: const ColorScheme.light(
      primary: AppColors.green,
      secondary: AppColors.black,
      error: AppColors.red,
      surface: AppColors.fadedGreen,
    ),
    fontFamily: "poppins",
    hintColor: AppColors.borderGrey,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.black,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.green,
      colorScheme: ColorScheme.light(
        error: AppColors.red,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    appBarTheme:
        const AppBarTheme(centerTitle: true, backgroundColor: AppColors.white),
  );
}
