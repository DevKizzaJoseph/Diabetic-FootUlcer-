
import 'package:flutter/material.dart';

class MyColors{
  MyColors._();


  //app colors

  static const Color primary = Color(0xff012ab6);
  static const Color secondary = Color(0xffffc565);
  static const Color accent = Color(0xFFb0c7ff);

  //gradient colors
  static const Gradient linearGradieent = LinearGradient(
    begin: Alignment(0.0, 0.0),
      end: Alignment(0.707, -0.707),
      colors: [
    Color(0xffff9a9e),
    Color(0xfffad0c4),
    Color(0xfffad0c4)
  ]);

  //text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF6c757d);
  static const Color textWhite = Colors.white;

  //background colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBG = Color(0xFFF3F5FF);

  //background container colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static  Color darkContainer = MyColors.white.withOpacity(0.1);

//button colors
  static const Color buttonPrimary = Color(0xffaf0b18);
  static const Color buttonSecondary = Color(0xFF6c757d);
  static const Color buttonDisabled = Color(0xFFc4c4c4);

  //border colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  //eRRor colors
  static const Color error = Color(0xffff0016);
  static const Color success = Color(0xff388e3c);
  static const Color warning = Color(0xFFe87807);
  static const Color info = Color(0xFF1976D2);

  //neutral colors
  static const Color black = Color(0xff232323);
  static const Color darkerGrey = Color(0xff4f4f4f);
  static const Color darkGrey = Color(0xff939393);
  static const Color grey = Color(0xffe0e0e0);
  static const Color softGrey = Color(0xfff4f4f4);
  static const Color lightGrey = Color(0xfff9f9f9);
  static const Color white = Color(0xffffffff);





}