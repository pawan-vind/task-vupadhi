import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../service_locator.dart';
import '../model/login_params.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/network/dio_client.dart';

abstract class ApiServices {
  Future<Either> login(LoginParams loginReq);
  // static late DioClient dio;
  // static initialize() async {
  //   try {
  //     dio = DioClient();
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  // static Future<Map<String, dynamic>> login(
  //     {required Map<String, dynamic> data}) async {
  //   try {
  //     var response = await dio.post(AppApiEndpoints.login, data: data);
  //     if (response != null) {
  //       return response;
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //     rethrow;
  //   }
  //   return {};
  // }
}

class ApiServicesImpl extends ApiServices {
  @override
  Future<Either> login(LoginParams loginReq) async {
    try {
      var response = await sl<DioClient>()
          .post(AppApiEndpoints.login, data: loginReq.toMap());
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['errMsg'] ?? 'Something went wrong');
    }
  }
}
