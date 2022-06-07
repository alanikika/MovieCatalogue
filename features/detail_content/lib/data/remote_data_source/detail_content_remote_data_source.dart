import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:detail_content/data/models/detail_response.dart';

abstract class DetailContentRemoteDataSource {
  Future<DetailResponse> getMovieReview(int page, int movieId);
  Future<DetailResponse> getTvReview(int page, int tvId);
}


class DetailShowDatSourceImpl extends DetailContentRemoteDataSource {
  final Dio dio;

  DetailShowDatSourceImpl({required this.dio});

  @override
  Future<DetailResponse> getMovieReview(int page, int movieId,
      [String apiKey = ApiConstants.apiKey]) async {
    try {
      final response = await dio.get(
        "movie/$movieId/reviews",
        queryParameters: {
          "api_key": apiKey,
          "page": page,
        },
      );
      return DetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }

  @override
  Future<DetailResponse> getTvReview(int page, int tvId,
      [String apiKey = ApiConstants.apiKey]) async {
    try {
      final response = await dio.get(
        "tv/$tvId/reviews",
        queryParameters: {
          "api_key": apiKey,
          "page": page,
        },
      );
      return DetailResponse.fromJson(response.data);
    } on DioError catch (e) {
      return e.error;
    }
  }
}
