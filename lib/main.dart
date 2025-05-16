import 'package:flutter/material.dart';
import 'package:task/core/routes/app_router.dart';
import 'package:task/service_locator.dart';

import 'core/constants/app_colors.dart';
import 'core/routes/app_routes.dart';
import 'data/repositery/shared_preferences/shared_preferences_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  await SharedPreferencesRepo.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
