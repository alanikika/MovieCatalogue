import 'package:movie/data/models/movie_response.dart';
import 'package:movie/data/remote_data_sources/movie_data_source.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/repositories/movie_repositories.dart';

class MovieRepositoriesImpl extends MovieRepositories {
  final MovieDataSource movieDataSource;

  MovieRepositoriesImpl({required this.movieDataSource});

  @override
  Future<MovieEntity> getNowPlaying(int page) async {
    MovieResponse response = await movieDataSource.getNowPlaying(page);
    MovieEntity data = MovieEntity.fromJson(response.toJson());
    return data;

  }

  @override
  Future<MovieEntity> getPopular(int page) async {
    MovieResponse response = await movieDataSource.getPopular(page);
    MovieEntity data = MovieEntity.fromJson(response.toJson());
    return data;
  }

  @override
  Future<MovieEntity> getUpComing(int page) async {
    MovieResponse response = await movieDataSource.getUpComing(page);
    MovieEntity data = MovieEntity.fromJson(response.toJson());
    return data;
  }
}