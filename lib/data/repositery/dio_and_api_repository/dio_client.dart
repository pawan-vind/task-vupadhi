import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/app_function.dart';
import 'api_endpoints.dart';
import 'dio_network_exceptions_manager.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient({String? authToken}) {
    try {
      _dio
        ..options.baseUrl = AppApiEndpoints.baseUrl
        ..options.connectTimeout = const Duration(minutes: 1)
        ..options.receiveTimeout = const Duration(minutes: 1)
        ..httpClientAdapter
        ..options.responseType = ResponseType.json;
    } catch (e) {
      AppFunctions.printError(
        methodName: "DioClient > Dio Options",
        error: e,
      );
    }

    try {
      _dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
    } catch (e) {
      AppFunctions.printError(
        methodName: "DioClient > Dio Options Headers",
        error: e,
      );
    }

    if (kDebugMode) {
      try {
        _dio.interceptors.add(
          LogInterceptor(
            responseBody: true,
            error: true,
            requestHeader: true,
            responseHeader: true,
            request: true,
            requestBody: true,
          ),
        );
      } catch (e) {
        AppFunctions.printError(
          methodName: "DioClient > Dio Interceptors",
          error: e,
        );
      }
    }
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    debugPrint("GET URL -- $uri");
    if (queryParameters != null) {
      debugPrint("GET QUERY PARAMETERS -- $queryParameters");
    }
    if (options != null) {
      debugPrint("GET OPTIONS -- $options");
    }
    if (cancelToken != null) {
      debugPrint("GET CANCEL -- $cancelToken");
    }
    if (onReceiveProgress != null) {
      debugPrint("GET ON RECEIVE PROGRESS -- $onReceiveProgress");
    }
    try {
      Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (e is DioException) {
        throw DioNetworkExceptionsManager.getDioException(e).toString();
      } else {
        rethrow;
      }
    }
  }
  Future<dynamic> delete(
  String uri, {
  Map<String, dynamic>? queryParameters,
  Options? options,
  CancelToken? cancelToken,
}) async {
  debugPrint("DELETE URL -- $uri");
  if (queryParameters != null) {
    debugPrint("DELETE QUERY PARAMETERS -- $queryParameters");
  }
  if (options != null) {
    debugPrint("DELETE OPTIONS -- $options");
  }
  if (cancelToken != null) {
    debugPrint("DELETE CANCEL -- $cancelToken");
  }
  try {
    Response response = await _dio.delete(
      uri,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  } on SocketException catch (e) {
    throw SocketException(e.toString());
  } on FormatException catch (_) {
    throw const FormatException("Unable to process the data");
  } catch (e) {
    if (e is DioException) {
      throw DioNetworkExceptionsManager.getDioException(e).toString();
    } else {
      rethrow;
    }
  }
}


  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    debugPrint("POST URL -- $uri");
    debugPrint("POST HEADER --- ${_dio.options.headers}");
    debugPrint("POST DATA --- $data");
    if (queryParameters != null) {
      debugPrint("GET QUERY PARAMETERS -- $queryParameters");
    }
    if (options != null) {
      debugPrint("GET OPTIONS -- $options");
    }
    if (cancelToken != null) {
      debugPrint("GET CANCEL -- $cancelToken");
    }
    if (onSendProgress != null) {
      debugPrint("GET ON SEND PROGRESS -- $onSendProgress");
    }
    if (onReceiveProgress != null) {
      debugPrint("GET ON RECEIVE PROGRESS -- $onReceiveProgress");
    }

    try {
      Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      debugPrint("POST RESPONSE CODE -- ${response.statusCode}");
      debugPrint("POST RESPONSE -- $response");
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (e is DioException) {
        throw DioNetworkExceptionsManager.getDioException(e).toString();
      } else {
        rethrow;
      }
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (e is DioException) {
        throw DioNetworkExceptionsManager.getDioException(e).toString();
      } else {
        rethrow;
      }
    }
  }
}
