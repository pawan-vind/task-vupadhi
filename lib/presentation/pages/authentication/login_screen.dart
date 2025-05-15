import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/bloc/button/button_state_cubit.dart';
import 'package:task/core/constants/app_colors.dart';

import '../../../common/bloc/login/login_state_cubit.dart';
import '../../../service_locator.dart';
import 'widgets/login_bottom.dart';
import 'widgets/login_middle.dart';
import 'widgets/login_top.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => getIt<LoginCubit>()),
        BlocProvider(create: (_) => sl<LoginCubit>()),
        BlocProvider(create: (_) => sl<ButtonStateCubit>()),
        BlocProvider(create: (_) => sl<LoginCubit>()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  LogInTopSection(),
                  const SizedBox(height: 30),
                  LoginMiddleSection(
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                  ),
                  const SizedBox(height: 24),
                  LoginBottomSection(
                    formKey: _formKey,
                    usernameController: _usernameController,
                    passwordController: _passwordController,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
