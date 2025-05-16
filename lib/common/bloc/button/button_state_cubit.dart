import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/common/bloc/button/button_state.dart';
import 'package:task/core/usecases/usercaes.dart';

import '../../../core/utils/app_function.dart';
import '../../../core/utils/encript_utils.dart';
import '../../../core/utils/hash_utils.dart';
import '../../../data/model/login_params.dart';
import '../../model/user_model.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_keys.dart';
import '../../../data/repositery/shared_preferences/shared_preferences_repo.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  void execute({
    required LoginParams params,
    required bool rememberMe,
    required UseCaes usecases,
  }) async {
    if (!isClosed) emit(ButtonLoadingState());

    try {
      final salt = HashUtils.generateSalt();
      final finalPassword =
          HashUtils.generateFinalPassword(params.password, salt);

      final Either result = await usecases.call(
        param: LoginParams(
          userName: params.userName,
          password: finalPassword,
          usedsalt: salt,
          lang: "en",
        ),
      );

      result.fold(
        (error) {
          if (!isClosed) {
            emit(ButtonfailureState(errorMessage: error.toString()));
          }
        },
        (response) async {
          if (response['status'] == "success") {
            final user = UserModel.fromMap(response['data']);

            SharedPreferencesRepo.setUserData(
              key: SpKeys.userData,
              value: jsonEncode(user.data),
            );

            if (rememberMe) {
              final rememberSalt = HashUtils.generateSalt();

              final tokenPayload = jsonEncode({
                "username": params.userName,
                "password": params.password,
                "salt": rememberSalt,
              });

              final encryptedToken = EncryptionUtils.encrypt(tokenPayload);

              SharedPreferencesRepo.setData(
                key: SpKeys.token,
                value: encryptedToken,
              );
            }

            if (!isClosed) emit(ButtonSuccessState());
          } else {
            if (!isClosed) {
              emit(ButtonfailureState(errorMessage: "Invalid credentials"));
            }
          }
        },
      );
    } catch (e) {
      emit(ButtonfailureState(errorMessage: e.toString()));
      AppFunctions.printError(
        methodName: "ButtonStateCubit > execute",
        error: e,
      );
    }
  }
}
