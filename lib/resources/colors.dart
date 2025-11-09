import 'package:flutter/material.dart';

class AppColors {


  Color get primaryColor => Color(0xFFFF5722);
  Color get accentColor => Colors.yellow.shade400;
  Color get backgroundColor => Colors.white;
  Color get greenPrimaryColor => Color(0xFF60F437);
  Color get yelloPrimaryColor => Color(0xFFFFD54F);










  static int getColorHexFromStr(String colorStr) {
    colorStr = "FF$colorStr";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  static Color getColor(String colorStr) {
    colorStr = colorStr.replaceAll('#', '');
    if (colorStr.length == 6) {
      colorStr = 'FF$colorStr'; // Add alpha value if not provided
    }
    return Color(int.parse(colorStr, radix: 16));
  }

  static final AppColors _appColors = AppColors._internal();
  factory AppColors() {
    return _appColors;
  }
  AppColors._internal();
}

AppColors appColors = AppColors();