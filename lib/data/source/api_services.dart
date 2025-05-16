import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../service_locator.dart';
import '../model/login_params.dart';
import '../../core/constants/api_endpoints.dart';
import '../../core/network/dio_client.dart';

abstract class ApiServices {
  Future<Either> login(LoginParams loginReq);
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
