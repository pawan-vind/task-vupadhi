import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/constants/images.dart';
import '../../../core/routes/app_router.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_keys.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_repo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              child: Center(
                child: SvgPicture.asset(AppAssetImages.appLogo),
              ),
            ),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Home Screen',
                    style: TextStyle(
                      color: Color(0xFF0A1053),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      SharedPreferencesRepo.resetData(key: SpKeys.token);
                      Navigator.pushReplacementNamed(
                          context, RouteNames.loginScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 80),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7ED957), Color(0xFF56CCF2)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Text(
                        'LOG OUT',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
