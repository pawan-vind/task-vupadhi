import 'package:flutter/material.dart';
import 'package:task/core/constants/app_colors.dart';

class AppStyling {
  AppStyling();

  static TextStyle headingStyleWhiteF14W600(
      {FontStyle? fontStyle,
      double? fontSize,
      double? height,
      Color? color,
      FontWeight? fontWeight}) {
    return TextStyle(
      height: height,
      fontSize: fontSize ?? 14,
      color: color ?? AppColors.white,
      fontWeight: fontWeight ?? FontWeight.w600,
    );
  }

  static TextStyle headingStylePurpleF20Bold(
      {FontStyle? fontStyle,
      double? fontSize,
      Color? color,
      FontWeight? fontWeight}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      color: color ?? AppColors.textColor,
      fontWeight: fontWeight ?? FontWeight.bold,
    );
  }

  static TextStyle textStyleBlackF12W500(
      {FontStyle? fontStyle,
      double? fontSize,
      double? height,
      Color? color,
      TextDecoration? textDecoration,
      Color? textDecorationColor,
      double? textDecorationThickness,
      FontWeight? fontWeight}) {
    return TextStyle(
      height: height,
      fontSize: fontSize ?? 12,
      color: color ?? AppColors.black,
      fontWeight: fontWeight ?? FontWeight.w500,
      decoration: textDecoration,
      decorationColor: textDecorationColor,
      decorationThickness: textDecorationThickness ?? 2,
    );
  }
}
