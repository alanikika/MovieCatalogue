import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tv/data/models/tv_response.dart';
import 'package:core/core.dart';

abstract class TvDataSource {
  Future<TvResponse> getOnTheAir(int page);
  Future<TvResponse> getPopular(int page);
}

class TvDataSourceImpl extends TvDataSource {
  final Dio dio;

  TvDataSourceImpl({required this.dio});

  @override
  Future<TvResponse> getOnTheAir(int page,
      [String apiKey = ApiConstants.apiKey]) async {
    try {
      debugPrint("----------- Start TV data Source On The air ---------------");
      final response = await dio.get(
        "tv/on_the_air",
        queryParameters: {
          "api_key": apiKey,
          "page": page,
        },
      );
      debugPrint("----------- END TV data Source On The air ---------------");
      debugPrint(response.data.toString());
      return TvResponse.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("======= ERROR: ${e.error}");
      return e.error;
    }
  }

  @override
  Future<TvResponse> getPopular(int page,
      [String apiKey = ApiConstants.apiKey]) async {
    try {
      final response = await dio.get(
        "tv/popular",
        queryParameters: {
          "api_key": apiKey,
          "page": page,
        },
      );
      return TvResponse.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }
}