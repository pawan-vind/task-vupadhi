import 'package:equatable/equatable.dart';

enum SignInStatus {
  initial,
  userNameFilled,
  emailAndPasswordFilled,
}

enum SignInRequestStatus {
  initial,
  loading,
  done,
  error,
}

class SignInState extends Equatable {
  final SignInRequestStatus signInRequestStatus;
  final SignInStatus signInStatus;
  final bool rememberMe;
  final bool obscurePassword;

  const SignInState({
    this.signInRequestStatus = SignInRequestStatus.done,
    this.signInStatus = SignInStatus.initial,
    this.rememberMe = false,
    this.obscurePassword = true,
  });

  SignInState copyWith({
    SignInRequestStatus? signInRequestStatus,
    SignInStatus? signInStatus,
    bool? rememberMe,
    bool? obscurePassword,
  }) {
    return SignInState(
      signInRequestStatus: signInRequestStatus ?? this.signInRequestStatus,
      signInStatus: signInStatus ?? this.signInStatus,
      rememberMe: rememberMe ?? this.rememberMe,
      obscurePassword: obscurePassword ?? this.obscurePassword,
    );
  }

  @override
  List<Object?> get props => [
        signInRequestStatus,
        signInStatus,
        rememberMe,
        obscurePassword,
      ];
}
