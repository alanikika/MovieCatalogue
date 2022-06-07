import 'package:movie/domain/entities/movie_entity.dart';

abstract class MovieRepositories {
  Future<MovieEntity> getNowPlaying(int page);
  Future<MovieEntity> getUpComing(int page);
  Future<MovieEntity> getPopular(int page);
}