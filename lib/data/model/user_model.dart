import 'dart:convert';
import 'package:equatable/equatable.dart';

UserModel userModelFromJson(String str) => UserModel.fromMap(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toMap());

class UserModel extends Equatable {
  final String? status;
  final AppError? error;
  final Data? data;

  const UserModel({
    this.status,
    this.error,
    this.data,
  });

  static const empty = UserModel(
    status: '',
    error: AppError.empty,
    data: Data.empty,
  );

  UserModel copyWith({
    String? status,
    AppError? error,
    Data? data,
  }) =>
      UserModel(
        status: status ?? this.status,
        error: error ?? this.error,
        data: data ?? this.data,
      );

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        status: map["status"],
        error: map["error"] == null ? null : AppError.fromMap(map["error"]),
        data: map["data"] == null ? null : Data.fromMap(map["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "error": error?.toMap(),
        "data": data?.toMap(),
      };

  @override
  List<Object?> get props => [status, error, data];
}

class Data extends Equatable {
  final int? nUserId;
  final int? nUserType;
  final int? bResetPassword;
  final int? userParentId;
  final String? status;
  final String? isValid;
  final String? errMsg;

  const Data({
    this.nUserId,
    this.nUserType,
    this.bResetPassword,
    this.userParentId,
    this.status,
    this.isValid,
    this.errMsg,
  });

  static const empty = Data(
    nUserId: 0,
    nUserType: 0,
    bResetPassword: 0,
    userParentId: 0,
    status: '',
    isValid: '',
    errMsg: '',
  );

  Data copyWith({
    int? nUserId,
    int? nUserType,
    int? bResetPassword,
    int? userParentId,
    String? status,
    String? isValid,
    String? errMsg,
  }) =>
      Data(
        nUserId: nUserId ?? this.nUserId,
        nUserType: nUserType ?? this.nUserType,
        bResetPassword: bResetPassword ?? this.bResetPassword,
        userParentId: userParentId ?? this.userParentId,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        errMsg: errMsg ?? this.errMsg,
      );

  factory Data.fromMap(Map<String, dynamic> map) => Data(
        nUserId: map["nUserID"],
        nUserType: map["nUserType"],
        bResetPassword: map["bResetPassword"],
        userParentId: map["userParentID"],
        status: map["status"],
        isValid: map["isValid"],
        errMsg: map["errMsg"],
      );

  Map<String, dynamic> toMap() => {
        "nUserID": nUserId,
        "nUserType": nUserType,
        "bResetPassword": bResetPassword,
        "userParentID": userParentId,
        "status": status,
        "isValid": isValid,
        "errMsg": errMsg,
      };

  @override
  List<Object?> get props => [
        nUserId,
        nUserType,
        bResetPassword,
        userParentId,
        status,
        isValid,
        errMsg,
      ];
}

class AppError extends Equatable {
  const AppError();

  static const empty = AppError();

  AppError copyWith() => const AppError();

  factory AppError.fromMap(Map<String, dynamic> map) => const AppError();

  Map<String, dynamic> toMap() => {};

  @override
  List<Object?> get props => [];
}
