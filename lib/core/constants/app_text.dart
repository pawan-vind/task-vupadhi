import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

class TextCustomWidgets {
  static Widget headingTextWidget({
    required String title,
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextAlign? textAlign,
  }) {
    return Text(
      title,
      style: TextStyle(
        color: color ?? AppColors.black,
        fontWeight: fontWeight ?? FontWeight.bold,
        fontSize: fontSize ?? 16,
      ),
      textAlign: textAlign,
    );
  }
}
