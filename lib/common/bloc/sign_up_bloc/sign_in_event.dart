part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();
  @override
  List<Object?> get props => [];
}

class UserSignInEvent extends SignInEvent {
  final String name;
  final String password;
  final void Function()? onSuccess;
  final void Function()? onError;
  const UserSignInEvent(this.name, this.password, this.onSuccess, this.onError);
}

class ToggleRememberMeEvent extends SignInEvent {
  final bool value;

  const ToggleRememberMeEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class TogglePasswordVisibilityEvent extends SignInEvent {}

