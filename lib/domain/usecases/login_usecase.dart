import 'package:dartz/dartz.dart';
import 'package:task/core/usecases/usercaes.dart';
import 'package:task/data/model/login_params.dart';
import 'package:task/domain/repositries/auth.dart';
import 'package:task/service_locator.dart';

class LoginUsecase implements UseCaes<Either, LoginParams> {
  @override
  Future<Either> call({dynamic Param, dynamic param}) async {
    return sl<AuthRespository>().login(param);
  }
}
