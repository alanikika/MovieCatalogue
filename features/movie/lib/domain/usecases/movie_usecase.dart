import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/repositories/movie_repositories.dart';

abstract class MovieUseCase {
  Future<MovieEntity> getNowPlaying({required int page});
  Future<MovieEntity> getUpComing({required int page});
  Future<MovieEntity> getPopular({required int page});
}

class MovieUseCaseImpl extends MovieUseCase {
  final MovieRepositories movieRepositories;

  MovieUseCaseImpl({required this.movieRepositories});

  @override
  Future<MovieEntity> getNowPlaying({required int page}) {
    return movieRepositories.getNowPlaying(page);
  }

  @override
  Future<MovieEntity> getPopular({required int page}) {
    return movieRepositories.getPopular(page);
  }

  @override
  Future<MovieEntity> getUpComing({required int page}) {
    return movieRepositories.getUpComing(page);
  }
}
