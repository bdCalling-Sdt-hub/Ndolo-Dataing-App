import 'dart:ui';
import 'package:flutter/cupertino.dart';

class AppColors{
  static Color primaryColor=const Color(0xFF430750);
  static Color secondaryColor=const Color(0xFFEF308D);
  static Color backgroundColor=const Color(0xFFFFFFFF);
  static Color cardColor = const Color(0xFFFDEAF4);
  static Color cardLightColor = const Color(0xFFFDE0EE);
  static Color borderColor = const Color(0xFF430750);
  static Color textColor = const Color(0xFF000000);
  static Color subTextColor = const Color(0xFFE8E8E8);
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color hintColor = const Color(0xFFB5B5B5);
  static Color greyColor = const Color(0xFFB5B5B5);
  static Color fillColor = const Color(0xFFE8EBF0);
  static Color dividerColor = const Color(0xFF555555);
  static Color shadowColor = const Color(0xFF2B2A2A);
  static Color bottomBarColor = const Color(0xFF343434);

  static BoxShadow shadow=BoxShadow(
    blurRadius: 4,
    spreadRadius: 0,
    color: shadowColor,
    offset: const Offset(0, 2),
  );
}