
import 'package:detail_content/domain/entities/detail_entity.dart';
import 'package:detail_content/domain/repositories/detail_content_repository.dart';

abstract class DetailContentUseCase {
  Future<DetailEntity> getMovieReview({required int page, required int movieId});
  Future<DetailEntity> getTvReview({required int page, required int movieId});
}

class DetailContentUseCaseImpl extends DetailContentUseCase {
  final DetailContentRepository detailContentRepository;

  DetailContentUseCaseImpl({required this.detailContentRepository});

  @override
  Future<DetailEntity> getMovieReview({required int page, required int movieId}) async {
    return await detailContentRepository.getMovieReview(page: page, movieId: movieId);
  }

  @override
  Future<DetailEntity> getTvReview({required int page, required int movieId}) async {
    return await detailContentRepository.getTvReview(page: page, tvId: movieId);
  }
}
