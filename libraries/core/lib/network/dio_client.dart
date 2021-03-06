import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioClient {
  final String apiBaseUrl;

  DioClient({required this.apiBaseUrl});

  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    Dio dio = Dio(options);
    // dio.interceptors.addAll(<Interceptor>[_loggingInterceptor()]);

    return dio;
  }

  Interceptor _loggingInterceptor() {
    return InterceptorsWrapper(onRequest:
        (RequestOptions? options, RequestInterceptorHandler? handler) {
      // Do something before request is sent
      debugPrint("\n"
          "Request ${options?.uri} \n"
          "-- headers --\n"
          "${options?.headers.toString()} \n"
          "");
    }, onResponse: (Response response, ResponseInterceptorHandler? handler) {
      // Do something with response data
      if (response.statusCode == 200) {
        debugPrint("\n"
            "Response ${response.requestOptions.uri} \n"
            "-- headers --\n"
            "${response.headers.toString()} \n"
            "-- payload --\n"
            "${jsonEncode(response.data)} \n"
            "");
      } else {
        debugPrint("Dio Response Status --> ${response.statusCode}");
      }
    }, onError: (DioError? e, ErrorInterceptorHandler? errorHandler) {
      // Do something with response error
      debugPrint("Dio Response Error --> $e");
    });
  }
}
