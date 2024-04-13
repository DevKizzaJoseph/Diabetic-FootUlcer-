import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AppElevetedButtonTheme{
  AppElevetedButtonTheme._();

  static final lightElevetedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: MyColors.primary,
      disabledForegroundColor: Colors.grey,
      disabledBackgroundColor: Colors.grey,
      side: const BorderSide(color: MyColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
    )
  );


  static final darkElevetedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: MyColors.primary,
          disabledForegroundColor: Colors.grey,
          disabledBackgroundColor: Colors.grey,
          side: const BorderSide(color: MyColors.primary),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
      )
  );


}