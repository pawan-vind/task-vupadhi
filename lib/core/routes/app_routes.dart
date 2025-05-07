import 'package:flutter/material.dart';
import 'package:task/core/routes/app_router.dart';
import 'package:task/presentation/pages/authentication/login_screen.dart';

import '../../presentation/pages/home/home_screen.dart';
import '../../presentation/pages/splash/splash_screen.dart';
import '../../presentation/widgets/no_routes.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: settings,
        );
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );
      case RouteNames.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NoRoutesScreen(),
          settings: settings,
        );
    }
  }
}
