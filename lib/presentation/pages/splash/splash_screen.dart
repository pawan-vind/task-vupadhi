import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task/core/constants/images.dart';
import 'package:task/data/repositery/shared_preferences/shared_preferences_keys.dart';

import '../../../common/bloc/button/button_state.dart';
import '../../../common/bloc/button/button_state_cubit.dart';
import '../../../common/bloc/login/login_state_cubit.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/encript_utils.dart';
import '../../../core/utils/hash_utils.dart';
import '../../../core/utils/toast_messagner.dart';
import '../../../data/model/login_params.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_repo.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LoginCubit>()),
        BlocProvider(create: (_) => sl<ButtonStateCubit>()),
      ],
      child: Builder(
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final encryptedToken =
                SharedPreferencesRepo.getData(key: SpKeys.token);

            if (encryptedToken.isNotEmpty) {
              try {
                final decrypted = EncryptionUtils.decrypt(encryptedToken);
                final data = jsonDecode(decrypted);

                final username = data['username'];
                final password = data['password'];
                final salt = data['salt'];

                final finalPassword =
                    HashUtils.generateFinalPassword(password, salt);

                context.read<ButtonStateCubit>().execute(
                      rememberMe: true,
                      usecases: sl<LoginUsecase>(),
                      params: LoginParams(
                        userName: username,
                        password: finalPassword,
                        usedsalt: salt,
                        lang: "en",
                      ),
                    );
              } catch (e) {
                Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
              }
            } else {
              Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
            }
          });

          return BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonSuccessState) {
                Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
              } else if (state is ButtonfailureState) {
                ToastMessenger.showErrorToast(
                  context: context,
                  message: state.errorMessage,
                );
                Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: Center(
                child: SvgPicture.asset(
                  AppAssetImages.appLogo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
