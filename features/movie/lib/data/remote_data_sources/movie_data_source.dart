import 'package:dio/dio.dart';
import 'package:movie/data/models/movie_response.dart';
import 'package:core/core.dart';

abstract class MovieDataSource {
  Future<MovieResponse> getNowPlaying(int page);
  Future<MovieResponse> getUpComing(int page);
  Future<MovieResponse> getPopular(int page);
}

class MovieDataSourceImpl extends MovieDataSource {
  final Dio dio;

  MovieDataSourceImpl({required this.dio});

  @override
  Future<MovieResponse> getNowPlaying(int page,
      [String apiKey = ApiConstants.apiKey]) async {
    try {
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


  @override
  Future<MovieResponse> getPopular(int page,
      [String apiKey = ApiConstants.apiKey]) async {
    try {
      final response = await dio.get(
        "movie/popular",
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

  @override
  Future<MovieResponse> getUpComing(int page,
      [String apiKey = ApiConstants.apiKey]) async {
    try {
      final response = await dio.get(
        "movie/upcoming",
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
