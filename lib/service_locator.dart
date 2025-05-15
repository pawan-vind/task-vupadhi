import 'package:get_it/get_it.dart';
import 'package:task/core/network/dio_client.dart';
import 'package:task/data/repositery/auth.dart';
import 'package:task/data/source/api_services.dart';
import 'package:task/domain/repositries/auth.dart';
import 'package:task/domain/usecases/login_usecase.dart';

import 'common/bloc/button/button_state_cubit.dart';
import 'common/bloc/login/login_state_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<ApiServices>(ApiServicesImpl());
  sl.registerSingleton<AuthRespository>(AuthRepositoryImpl());
  sl.registerSingleton<LoginUsecase>(LoginUsecase());
  sl.registerFactory<ButtonStateCubit>(() => ButtonStateCubit());
  sl.registerFactory<LoginCubit>(() => LoginCubit());
}
