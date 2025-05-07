import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/app_function.dart';
import '../../../core/utils/encript_utils.dart';
import '../../../core/utils/hash_utils.dart';
import '../../../data/model/user_model.dart';
import '../../../data/repositery/dio_and_api_repository/api_services.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_keys.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_repo.dart';
import 'sign_in_state.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final ApiServices apiServices;
  SignInBloc(this.apiServices)
      : super(
          const SignInState(
            signInStatus: SignInStatus.initial,
          ),
        ) {
    on<UserSignInEvent>(_signInEvent);
    on<ToggleRememberMeEvent>(_toggleRememberMe);
    on<TogglePasswordVisibilityEvent>(_togglePasswordVisibility);
  }

  void _toggleRememberMe(ToggleRememberMeEvent event, Emitter emit) {
    emit(state.copyWith(rememberMe: event.value));
  }

  void _togglePasswordVisibility(
    TogglePasswordVisibilityEvent event, Emitter emit) {
  emit(state.copyWith(obscurePassword: !state.obscurePassword));
}

void _signInEvent(UserSignInEvent event, Emitter emit) async {
  // Emit the loading state when the API call starts
  emit(state.copyWith(signInRequestStatus: SignInRequestStatus.loading));

  try {
    final salt = HashUtils.generateSalt();
    final finalPassword = HashUtils.generateFinalPassword(event.password, salt);
    var data = {
      "userName": event.name,
      "password": finalPassword,
      "usedsalt": salt,
      "lang": "en"
    };

    var response = await ApiServices.login(data: data);

    if (response['status'] == "success") {
      UserModel user = const UserModel();
      user = UserModel.fromMap(response['data']);
      SharedPreferencesRepo.setUserData(
        key: SpKeys.userData,
        value: jsonEncode(user.data),
      );
      
      // If 'Remember Me' is true, store the encrypted token
      if (state.rememberMe) {
        final salt = HashUtils.generateSalt();

        final tokenPayload = jsonEncode({
          "username": event.name,
          "password": event.password,
          "salt": salt,
        });

        final encryptedToken = EncryptionUtils.encrypt(tokenPayload);

        SharedPreferencesRepo.setData(
          key: SpKeys.token,
          value: encryptedToken,
        );
      }

      // Emit done state after successful sign-in
      emit(state.copyWith(signInRequestStatus: SignInRequestStatus.done));
      
      // Call the success callback
      event.onSuccess!.call();
    } else {
      // Emit error state if login failed
      emit(state.copyWith(signInRequestStatus: SignInRequestStatus.error));
      event.onError!.call();
    }
  } catch (e) {
    // Emit error state if an exception is thrown
    emit(state.copyWith(signInRequestStatus: SignInRequestStatus.error));
    AppFunctions.printError(
      methodName: "SignUpBloc > _SignInBloc",
      error: e,
    );
  }
}

}
