import '../shared_preferences/shared_preferences_keys.dart';
import '../shared_preferences/shared_preferences_repo.dart';
import 'api_endpoints.dart';
import 'dio_client.dart';

class ApiServices {
  static late DioClient dio;
  static initialize() async {
    try {
      dio = DioClient();
    } catch (error) {
      print(error.toString());
    }
  }


  static Future<Map<String, dynamic>> login(
      {required Map<String, dynamic> data}) async {
    try {
      var response = await dio.post(AppApiEndpoints.login, data: data);
      if (response != null) {
        return response;
      }
    } catch (error) {
      print(error.toString());
      rethrow;
    }
    return {};
  }
}
