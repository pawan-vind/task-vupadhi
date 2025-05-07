import 'package:flutter/material.dart';

class AppFunctions {
  static void printError(
      {required String methodName, required Object error, bool? isNotCrucial}) {
    try {
      debugPrint(
        "${isNotCrucial == true ? '!' : '!!!'} Error in $methodName => ${error.toString()}",
      );
    } catch (e) {
      debugPrint(
        "${isNotCrucial == true ? '!' : '!!!'} Error in $methodName => Could not parse the \$errorString",
      );
    }
  }
}
