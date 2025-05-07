import 'package:dio/dio.dart';
import 'dart:io';

import '../../model/response_common_model.dart';

class DioNetworkExceptionsManager {
  static String getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          if (error.response != null && error.response?.data != null) {
            try {
              Map<String, dynamic> errorData = error.response!.data;
              if (errorData.containsKey("message")) {
                return errorData["message"]; 
              }
            } catch (_) {
            }
          }

          switch (error.type) {
            case DioExceptionType.cancel:
              return 'Request is cancelled';
            case DioExceptionType.connectionTimeout:
              return 'Request timed out, please try again';
            case DioExceptionType.unknown:
              return 'Please connect to the internet';
            case DioExceptionType.receiveTimeout:
            case DioExceptionType.sendTimeout:
              return 'Request Timeout';
            default:
              {
                String errorMessage = '';

                ResponseCommonModel responseCommonModel =
                    ResponseCommonModel.fromJson(error.response?.data ?? {});
                if (responseCommonModel.exceptionMessage != null &&
                    responseCommonModel.exceptionMessage!.isNotEmpty) {
                  return responseCommonModel.exceptionMessage!;
                }

                if (error.response != null) {
                  switch (error.response!.statusCode) {
                    case 400:
                      errorMessage = 'Bad request: Invalid input';
                      break;
                    case 401:
                      errorMessage = 'Unauthorized: Invalid credentials';
                      break;
                    case 403:
                      errorMessage = 'Forbidden: Access denied';
                      break;
                    case 404:
                      errorMessage = 'Not found';
                      break;
                    case 409:
                      errorMessage = 'Conflict: Resource already exists';
                      break;
                    case 408:
                      errorMessage = 'Request Timeout';
                      break;
                    case 500:
                      errorMessage = 'Internal server error';
                      break;
                    case 503:
                      errorMessage = 'Service is temporarily unavailable';
                      break;
                    default:
                      errorMessage = 'Unexpected error occurred';
                  }
                  return errorMessage;
                }
                return 'An unknown error occurred';
              }
          }
        } else if (error is SocketException) {
          return 'Please check your internet connection';
        } else {
          return 'Something went wrong, please try again';
        }
      } on FormatException {
        return 'Format Exception';
      } catch (_) {
        return 'Something went wrong';
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return 'Unable to process the request';
      } else {
        return error.error ?? 'Something went wrong';
      }
    }
  }
}
