class LoginState {
  final bool rememberMe;
  final bool obscurePassword;

  const LoginState({
    this.rememberMe = false,
    this.obscurePassword = true,
  });

  LoginState copyWith({
    bool? rememberMe,
    bool? obscurePassword,
  }) {
    return LoginState(
      rememberMe: rememberMe ?? this.rememberMe,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }
}
