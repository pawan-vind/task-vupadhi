import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/constants/images.dart';
import 'package:task/data/repositery/shared_preferences/shared_preferences_keys.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/encript_utils.dart';
import '../../../core/utils/hash_utils.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_repo.dart';
import '../../../common/bloc/sign_up_bloc/sign_in_bloc.dart';
import '../../../common/bloc/sign_up_bloc/sign_in_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SignInBloc _signInBloc;

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final encryptedToken = SharedPreferencesRepo.getData(key: SpKeys.token);

      if (encryptedToken.isNotEmpty) {
        try {
          final decrypted = EncryptionUtils.decrypt(encryptedToken);
          final data = jsonDecode(decrypted);

          final username = data['username'];
          final password = data['password'];
          final salt = data['salt'];

          final finalPassword = HashUtils.generateFinalPassword(password, salt);

          _signInBloc.add(UserSignInEvent(
            username,
            finalPassword,
            () {
              Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
            },
            () {
              Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
            },
          ));
        } catch (e) {
          print("Token decryption failed: $e");
          Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
        }
      } else {
        Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _signInBloc,
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: SvgPicture.asset(
                AppAssetImages.appLogo,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
