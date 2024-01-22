import 'package:flutter/material.dart';
import '../class.global.dart';

ThemeData checkMode(context, bool isDarkMode) {
  if (isDarkMode) {
    return ThemeData(
        primaryColor: AppColors.primaryColor[0],
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.primaryColor[1],
            displayColor: AppColors.primaryColor[1]),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 35, 215, 0),
          onPrimary: Colors.white,
          secondary: Color.fromARGB(255, 35, 215, 0),
          onSecondary: Colors.white,
          primaryContainer: Color.fromARGB(255, 229, 229, 229),
          error: Colors.black,
          onError: Colors.white,
          background: Colors.blue,
          onBackground: Colors.white,
          surface: Color.fromARGB(255, 229, 229, 229),
          onSurface: Colors.black,
        ),
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: AppColors.colorBlack),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid, color: AppColors.colorBlack),
            )));
  } else {
    return ThemeData(
        primaryColor: AppColors.primaryColor[0],
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.secondaryColor[1],
            displayColor: AppColors.secondaryColor[1]),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 35, 215, 0),
          onPrimary: Colors.white,
          secondary: Color.fromARGB(255, 35, 215, 0),
          onSecondary: Colors.white,
          primaryContainer: Color.fromARGB(255, 0, 0, 0),
          error: Colors.black,
          onError: Colors.white,
          background: Colors.blue,
          onBackground: Colors.white,
          surface: AppColors.colorBlack,
          onSurface: AppColors.colorWhite,
        ),
        inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(color: AppColors.colorWhite),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(style: BorderStyle.solid, color: Colors.white),
            )));
  }
}
