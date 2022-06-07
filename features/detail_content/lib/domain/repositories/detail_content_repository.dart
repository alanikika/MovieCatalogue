import 'package:detail_content/domain/entities/detail_entity.dart';

abstract class DetailContentRepository {
  Future<DetailEntity> getMovieReview({required int page, required int movieId});
  Future<DetailEntity> getTvReview({required int page, required int tvId});
}