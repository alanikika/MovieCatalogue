import 'package:tv/data/models/tv_response.dart';
import 'package:tv/data/remote_data_source/tv_data_source.dart';
import 'package:tv/domain/entities/tv_entity.dart';
import 'package:tv/domain/repositories/tv_repositories.dart';

class TvRepositoryImpl extends TvRepository {

  final TvDataSource tvDataSource;

  TvRepositoryImpl({required this.tvDataSource});

  @override
  Future<TvEntity> getOnTheAir(int page) async {
    TvResponse response = await tvDataSource.getOnTheAir(page);
    return TvEntity.fromJson(response.toJson());
  }

  @override
  Future<TvEntity> getPopular(int page) async {
    TvResponse response = await tvDataSource.getPopular(page);
    return TvEntity.fromJson(response.toJson());
  }

}