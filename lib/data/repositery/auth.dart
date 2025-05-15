import 'package:dartz/dartz.dart';
import 'package:task/data/source/api_services.dart';
import 'package:task/domain/repositries/auth.dart';

import '../../service_locator.dart';
import '../model/login_params.dart';

class AuthRepositoryImpl extends AuthRespository {
  @override
  Future<Either> login(LoginParams loginReq) {
    return sl<ApiServices>().login(loginReq);
  }
}
