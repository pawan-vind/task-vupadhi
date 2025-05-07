// lib/core/di/di.dart

import 'package:get_it/get_it.dart';
import '../data/repositery/dio_and_api_repository/api_services.dart';
import '../data/repositery/dio_and_api_repository/dio_client.dart';
import '../data/repositery/shared_preferences/shared_preferences_repo.dart';
import '../presentation/bloc/sign_up_bloc/sign_in_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Repositories
  getIt.registerLazySingleton(() => SharedPreferencesRepo());

  // Dio and API Services
  getIt.registerLazySingleton(() => DioClient());
  getIt.registerLazySingleton(() => ApiServices());
  getIt.registerFactory(() => SignInBloc(getIt()));
}
