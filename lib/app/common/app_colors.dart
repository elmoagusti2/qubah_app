import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const main = Color(0xFF105e82);
  static const baseGrey = Color(0xFFEEEEEE);
  static const white = Colors.white;
  static const blue10 = Color(0xFFf2f1ff);
  static const blue20 = Color(0xFFe7eff2);
  static const blueAccent = Color(0XFF1cbec9);
  static const red10 = Color(0xFFffeceb);
  static const orange10 = Color(0xFFfef5e6);
  static const orangeSubmission = Color(0xFFfe9504);
  static const grey10 = Color(0xFFfaf7f7);
  static const grey20 = Color(0xffD9D9D9);
  static const green10 = Color(0xFFe6f6f2);
  static const green30 = Color(0xFF558b6e);
  static const greenSubmission = Color(0xFF00af6c);
  static const errorLottie = Color(0xFF8c0000);
  static const successLottie = Color(0xFF27a001);

  static const ColorScheme showdatePickerScheme = ColorScheme(
    brightness: Brightness.light,
    error: main,
    onError: main,
    onSecondary: main,
    primary: main,
    background: Colors.white,
    surface: main,
    onPrimary: Colors.black,
    onSurface: Colors.black,
    inversePrimary: main,
    onBackground: main,
    onInverseSurface: main,
    secondary: main,
    surfaceTint: main,
  );

  static ThemeData mainScheme = ThemeData(
    primaryColor: main,
    primaryColorLight: main,
    colorScheme: const ColorScheme.light().copyWith(
      primary: main,
      onPrimary: Colors.white,
      onSurface: Colors.black,
      inversePrimary: main,
      onBackground: main,
      onInverseSurface: main,
      secondary: main,
    ),
    datePickerTheme: const DatePickerThemeData(
      rangePickerSurfaceTintColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: IconThemeData(color: Colors.white)),
  );

  static Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
        255,
        random.nextInt(256), // Red
        random.nextInt(256), // Green
        random.nextInt(256) // Blue
        );
  }
}
