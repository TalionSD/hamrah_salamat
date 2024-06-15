import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/utils/helper.dart';

final ThemeData theme = ThemeData(
  primaryColor: hexToColor("#84cc16"),
  scaffoldBackgroundColor: hexToColor("#f2f7f2"),
  fontFamily: 'Vazir',
  useMaterial3: true,

  colorScheme: ColorScheme(
    primary: hexToColor("#3b82f6"),
    secondary: hexToColor("#8b5cf6"),
    tertiary: hexToColor("#ffffff"),
    surface: hexToColor("#313a34"),
    onSurface: hexToColor("#647067"),
    error: hexToColor("#f43f5e"),
    onError: hexToColor('#ffe4e7'),
    onPrimary: hexToColor("#3b82f6"),
    onSecondary: hexToColor("#8b5cf6"),
    brightness: Brightness.light,
  ),


  
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: hexToColor("#ffffff"),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    displayMedium: TextStyle(
      color: hexToColor("#ffffff"),
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    displayLarge: TextStyle(
      color: hexToColor("#84cc16"),
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      color: hexToColor("#647067"),
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: hexToColor("#313a34"),
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: TextStyle(
      fontSize: 17,
      color: hexToColor("#313a34"),
      fontWeight: FontWeight.w200,
    ),
    labelMedium: TextStyle(
      color: hexToColor("#ffffff"),
      fontWeight: FontWeight.bold,
      fontSize: 17,
    ),
    titleSmall: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: hexToColor("#313a34"),
    ),
    titleMedium: TextStyle(
      color: hexToColor("#84cc16"),
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: hexToColor("#313a34"),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: hexToColor("#ffffff"),
    labelStyle: TextStyle(color: hexToColor("#84cc16")),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        color: hexToColor("#84cc16"),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        color: hexToColor("#313a34"),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        color: hexToColor("#f43f5e"),
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        color: hexToColor("#ffe4e7"),
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(
        color: hexToColor("#84cc16"),
      ),
    ),
  ),
  expansionTileTheme: ExpansionTileThemeData(
    collapsedBackgroundColor: hexToColor("#ffffff"),
    backgroundColor: hexToColor("#ffffff"),
    collapsedIconColor: hexToColor("#313a34"),
    iconColor: hexToColor("#84cc16"),
    textColor: hexToColor("#84cc16"),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: hexToColor("#f2f7f2"),
    surfaceTintColor: hexToColor("#f2f7f2"),
  ),
);
