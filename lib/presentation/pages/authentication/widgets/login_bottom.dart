import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/teststyling.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/utils/toast_messagner.dart';
import '../../../../di/di.dart';
import '../../../bloc/sign_up_bloc/sign_in_bloc.dart';
import '../../../bloc/sign_up_bloc/sign_in_state.dart';

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
    return BlocProvider(
        create: (context) => getIt<SignInBloc>(),
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
          return FilledButton(
            onPressed: () {
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
                child: state.signInRequestStatus == SignInRequestStatus.loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'LOGIN',
                        style: AppStyling.headingStyleWhiteF14W600(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
              ),
            ),
          );
        }));
  }
}
