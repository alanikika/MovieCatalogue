import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:core/core.dart';

abstract class MovieDataSource {
  Future<MovieResponse> getNowPlaying(int page);
}

class MovieDataSourceImpl extends MovieDataSource {
  final Dio dio;

  MovieDataSourceImpl({required this.dio});

  @override
  Future<MovieResponse> getNowPlaying(int page,
      [String apiKey = ApiConstants.apiKey]) async {
    try {
      debugPrint("hit api");
      final response = await dio.get(
        "movie/now_playing",
        queryParameters: {
          "api_key": apiKey,
          "page": page,
        },
      );
      return MovieResponse.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }
}
