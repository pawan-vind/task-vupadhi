import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_function.dart';
import '../../../common/model/user_model.dart';

class SharedPreferencesRepo {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      AppFunctions.printError(
        methodName: "SharedPreferencesRepo > initialize",
        error: e,
      );
    }
  }

  static String getData({required String key}) {
    try {
      return _prefs.getString(key) ?? "";
    } catch (e) {
      AppFunctions.printError(
        methodName: "SharedPreferencesRepo > getData [ Key : $key ]",
        error: e,
      );
      return "";
    }
  }

  static void setData({
    required String key,
    required String value,
  }) {
    try {
      _prefs.setString(key, value);
    } catch (e) {
      AppFunctions.printError(
        methodName: "SharedPreferencesRepo > setData [ Key : $key ]",
        error: e,
      );
    }
  }

  static void setUserData({
    required String key,
    required dynamic value, 
  }) {
    try {
      String jsonString = (value is String) ? value : jsonEncode(value);
      _prefs.setString(key, jsonString);
    } catch (e) {
      AppFunctions.printError(
        methodName: "SharedPreferencesRepo > setData [ Key : $key ]",
        error: e,
      );
    }
  }

  static UserModel? getUserData(String key) {
    try {
      String? userData = _prefs.getString(key);

      if (userData != null && userData.isNotEmpty) {
        Map<String, dynamic> decodedData = jsonDecode(userData);
        return UserModel.fromMap(decodedData); 
      }
    } catch (e) {
      AppFunctions.printError(
        methodName: "SharedPreferencesRepo > getUserData [ Key : $key ]",
        error: e,
      );
    }
    return null; 
  }

  static void resetData({
    required String key,
    String? value,
  }) {
    try {
      _prefs.setString(key, value ?? "");
    } catch (e) {
      AppFunctions.printError(
        methodName: "SharedPreferencesRepo > resetData [ Key : $key ]",
        error: e,
      );
    }
  }
}
