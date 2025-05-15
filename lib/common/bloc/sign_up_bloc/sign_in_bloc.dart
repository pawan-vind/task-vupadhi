import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/domain/usecases/login_usecase.dart';

import '../../../core/utils/app_function.dart';
import '../../../core/utils/encript_utils.dart';
import '../../../core/utils/hash_utils.dart';
import '../../../data/model/login_params.dart';
import '../../../data/model/user_model.dart';
import '../../../data/source/api_services.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_keys.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_repo.dart';
import 'sign_in_state.dart';
part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
final LoginUsecase loginUsecase;
  SignInBloc(this.loginUsecase)
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
  emit(state.copyWith(signInRequestStatus: SignInRequestStatus.loading));

  try {
    final salt = HashUtils.generateSalt();
    final finalPassword = HashUtils.generateFinalPassword(event.password, salt);

    final response = await loginUsecase.call(
      param: LoginParams(
        userName: event.name,
        password: finalPassword,
        usedsalt: salt,
        lang: "en",
      ),
    );

    print("fffffffffff");
    print(response);

    // if (response['status'] == "success") {
    //   UserModel user = UserModel.fromMap(response['data']);

    //   SharedPreferencesRepo.setUserData(
    //     key: SpKeys.userData,
    //     value: jsonEncode(user.data),
    //   );

    //   if (state.rememberMe) {
    //     final salt = HashUtils.generateSalt();

    //     final tokenPayload = jsonEncode({
    //       "username": event.name,
    //       "password": event.password,
    //       "salt": salt,
    //     });

    //     final encryptedToken = EncryptionUtils.encrypt(tokenPayload);

    //     SharedPreferencesRepo.setData(
    //       key: SpKeys.token,
    //       value: encryptedToken,
    //     );
    //   }

    //   emit(state.copyWith(signInRequestStatus: SignInRequestStatus.done));
    //   event.onSuccess?.call();
    // } else {
    //   emit(state.copyWith(signInRequestStatus: SignInRequestStatus.error));
    //   event.onError?.call();
    // }
  } catch (e) {
    emit(state.copyWith(signInRequestStatus: SignInRequestStatus.error));
    AppFunctions.printError(methodName: "SignInBloc > _signInEvent", error: e);
    event.onError?.call();
  }
}


}
