import 'package:flutter/material.dart';

class TextStyleTheme {

  static TextStyle customTextStyle(
      Color color, double size, FontWeight fontWeight, double spacing) {
    return TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: TextDecoration. none, letterSpacing: spacing);
  }
}