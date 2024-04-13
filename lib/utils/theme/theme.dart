
import 'package:flutter/material.dart';

import 'custome themes/appbar_theme.dart';
import 'custome themes/bottom_sheet_theme.dart';
import 'custome themes/check_box_theme.dart';
import 'custome themes/chip_theme.dart';
import 'custome themes/eleveted_button_theme.dart';
import 'custome themes/outlined_button_theme.dart';
import 'custome themes/text_field_theme.dart';
import 'custome themes/text_theme.dart';

class AppTheme{
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color(0xff76ca71),
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevetedButtonTheme.lightElevetedButtonTheme,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: MyBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: MyCheckBoxTheme.lightCheckboxTheme,
    chipTheme: MyChiptheme.lightChipTheme,
    outlinedButtonTheme: MyOutlinedButton.lightOutlinedButton,
    inputDecorationTheme: MyTextFieldTheme.lightInputDecorationTheme,

  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: const Color(0xff76ca71),
      scaffoldBackgroundColor: Colors.black,
      textTheme: AppTextTheme.darkTextTheme,
      elevatedButtonTheme: AppElevetedButtonTheme.darkElevetedButtonTheme,
      appBarTheme: MyAppBarTheme.darkAppBarTheme,
      bottomSheetTheme: MyBottomSheetTheme.darkBottomSheetTheme,
      checkboxTheme: MyCheckBoxTheme.darkCheckboxTheme,
      chipTheme: MyChiptheme.darkChipTheme,
      outlinedButtonTheme: MyOutlinedButton.darkOutlinedButton,
      inputDecorationTheme: MyTextFieldTheme.darkInputDecorationTheme,

  );
}