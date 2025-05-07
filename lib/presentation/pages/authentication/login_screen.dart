import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/core/constants/app_colors.dart';
import 'package:task/core/constants/images.dart';
import 'package:task/presentation/bloc/sign_up_bloc/sign_in_bloc.dart';
import 'package:task/presentation/bloc/sign_up_bloc/sign_in_state.dart';

import '../../../di/di.dart';
import '../../../core/routes/app_router.dart';
import '../../../core/utils/toast_messagner.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100),
          child: BlocProvider(
            create: (context) => getIt<SignInBloc>(),
            child: BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SvgPicture.asset(AppAssetImages.appLogo),
                      const SizedBox(height: 20),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Username Field
                      TextFormField(
                        controller: _usernameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: '28906825',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: state.obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(state.obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              context
                                  .read<SignInBloc>()
                                  .add(TogglePasswordVisibilityEvent());
                            },
                          ),
                          hintText: '**********',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Remember Me Switch
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 30,
                            child: Switch(
                              value: state.rememberMe,
                              onChanged: (value) {
                                context
                                    .read<SignInBloc>()
                                    .add(ToggleRememberMeEvent(value));
                              },
                            ),
                          ),
                          const Text('Remember Me'),
                        ],
                      ),
                      const SizedBox(height: 24),

                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<SignInBloc>().add(
                                  UserSignInEvent(
                                    _usernameController.text,
                                    _passwordController.text,
                                    () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        RouteNames.homeScreen,
                                      );
                                    },
                                    () {
                                      ToastMessenger.showErrorToast(
                                        context: context,
                                        message: "Something Went Wrong",
                                      );
                                    },
                                  ),
                                );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4CAF50), Color(0xFF00BCD4)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: state.signInRequestStatus ==
                                    SignInRequestStatus.loading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                : const Text(
                                    'LOGIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
