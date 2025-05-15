import 'package:dartz/dartz.dart';

import '../../data/model/login_params.dart';

abstract class AuthRespository{
  Future<Either> login(LoginParams loginReq);
}