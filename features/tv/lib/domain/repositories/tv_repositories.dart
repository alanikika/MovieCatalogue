import 'package:tv/domain/entities/tv_entity.dart';

abstract class TvRepository {
  Future<TvEntity> getOnTheAir(int page);
  Future<TvEntity> getPopular(int page);
}
