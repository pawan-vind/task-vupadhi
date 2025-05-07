import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class ToastMessenger {
  static void showToast({
    required BuildContext context,
    required String message,
    Color backgroundColor = AppColors.black,
    Color textColor = AppColors.white,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(
          milliseconds: 1000,
        ),
      ),
    );
  }

  static void showErrorToast({
    required BuildContext context,
    required String message,
    Color backgroundColor = AppColors.red,
    Color textColor = AppColors.white,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(
          milliseconds: 1000,
        ),
      ),
    );
  }

  static void showSuccessToast({
    required BuildContext context,
    required String message,
    Color backgroundColor = AppColors.green,
    Color textColor = AppColors.white,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(
          milliseconds: 1000,
        ),
      ),
    );
  }
}
