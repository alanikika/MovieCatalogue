import 'package:detail_content/data/models/detail_response.dart';
import 'package:detail_content/data/remote_data_source/detail_content_remote_data_source.dart';
import 'package:detail_content/domain/entities/detail_entity.dart';
import 'package:detail_content/domain/repositories/detail_content_repository.dart';

class DetailContentRepositoryImpl extends DetailContentRepository {

  final DetailContentRemoteDataSource detailContentDataSource;

  DetailContentRepositoryImpl({required this.detailContentDataSource});

  @override
  Future<DetailEntity> getMovieReview({required int page, required int movieId}) async {
    DetailResponse response = await detailContentDataSource.getMovieReview(page, movieId);
    return DetailEntity.fromJson(response.toJson());
  }

  @override
  Future<DetailEntity> getTvReview({required int page, required int tvId}) async {
    DetailResponse response = await detailContentDataSource.getTvReview(page, tvId);
    return DetailEntity.fromJson(response.toJson());
  }

}