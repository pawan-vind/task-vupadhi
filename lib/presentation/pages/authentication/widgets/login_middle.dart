import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task/common/bloc/login/login_state.dart';
import 'package:task/common/bloc/login/login_state_cubit.dart';
import 'package:task/core/constants/app_colors.dart';

import '../../../../common/bloc/button/button_state.dart';
import '../../../../common/bloc/button/button_state_cubit.dart';
import '../../../../core/constants/teststyling.dart';
import '../../../../common/bloc/sign_up_bloc/sign_in_bloc.dart';
import '../../../../common/bloc/sign_up_bloc/sign_in_state.dart';

class LoginMiddleSection extends StatelessWidget {
  const LoginMiddleSection({
    super.key,
    required TextEditingController usernameController,
    required TextEditingController passwordController,
  })  : _usernameController = usernameController,
        _passwordController = passwordController;

  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/icons/person.svg",
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                hintText: 'Enter User Id',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                prefixIcon: Container(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    "assets/icons/Password.svg",
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    state.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 20,
                  ),
                  onPressed: () {
                    context
                        .read<SignInBloc>()
                        .add(TogglePasswordVisibilityEvent());
                  },
                ),
                hintText: 'Enter Password',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: state.rememberMe,
                    onChanged: (value) {
                      context.read<LoginCubit>().toggleRememberMe(value);
                    },
                    activeColor: AppColors.white,
                    activeTrackColor: AppColors.blue,
                    inactiveThumbColor: AppColors.grey,
                    inactiveTrackColor: AppColors.white,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
                Text(
                  'Remember Me',
                  style: AppStyling.textStyleBlackF12W500(
                      fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
