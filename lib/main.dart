import 'package:flutter/material.dart';
import 'package:task/di/di.dart';
import 'package:task/core/routes/app_router.dart';

import 'core/constants/app_colors.dart';
import 'core/routes/app_routes.dart';
import 'data/repositery/dio_and_api_repository/api_services.dart';
import 'data/repositery/shared_preferences/shared_preferences_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ApiServices.initialize();
  await SharedPreferencesRepo.initialize();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        // scaffoldBackgroundColor: AppColors.primaryBgColor,
        useMaterial3: true,
      ),
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
