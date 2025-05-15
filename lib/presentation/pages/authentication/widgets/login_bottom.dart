import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/bloc/button/button_state.dart';
import 'package:task/common/bloc/button/button_state_cubit.dart';
import 'package:task/data/model/login_params.dart';
import 'package:task/domain/usecases/login_usecase.dart';
import 'package:task/service_locator.dart';

import '../../../../common/bloc/login/login_state_cubit.dart';
import '../../../../common/bloc/sign_up_bloc/sign_in_bloc.dart';
import '../../../../core/constants/teststyling.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/toast_messagner.dart';

class LoginBottomSection extends StatelessWidget {
  const LoginBottomSection({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _usernameController = usernameController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => getIt<LoginCubit>()),
        BlocProvider(create: (_) => sl<LoginCubit>()),
        BlocProvider(create: (_) => sl<ButtonStateCubit>()),
      ],
      child: BlocListener<ButtonStateCubit, ButtonState>(
        listener: (context, state) {
          if (state is ButtonSuccessState) {
            Navigator.pushReplacementNamed(
              context,
              RouteNames.homeScreen,
            );
          }
          if (state is ButtonfailureState) {
            ToastMessenger.showErrorToast(
                context: context, message: state.errorMessage);
          }
        },
        child: BlocBuilder<ButtonStateCubit, ButtonState>(
          builder: (context, state) {
            if (state is ButtonLoadingState) {
              return _loading();
            } else {
              return _initial(
                () {
                  print(context.read<LoginCubit>().state.rememberMe);
                  if (_formKey.currentState!.validate()) {
                    context.read<ButtonStateCubit>().execute(
                          rememberMe:
                              context.watch<LoginCubit>().state.rememberMe,
                          usecases: sl<LoginUsecase>(),
                          params: LoginParams(
                            userName: _usernameController.text,
                            password: _passwordController.text,
                            usedsalt: "34343",
                            lang: "en",
                          ),
                        );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _loading() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF00BCD4)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        alignment: Alignment.center,
        child: const SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _initial(void Function()? onPressed) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.grey.withOpacity(0.0),
        elevation: 4,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF00BCD4)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          child: Text(
            'LOGIN',
            style: AppStyling.headingStyleWhiteF14W600(
                fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
