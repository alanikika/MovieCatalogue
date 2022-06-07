import 'package:tv/domain/entities/tv_entity.dart';
import 'package:tv/domain/repositories/tv_repositories.dart';

abstract class TvUseCase {
  Future<TvEntity> getOnTheAir({required int page});
  Future<TvEntity> getPopular({required int page});
}

class TvUsecaseImpl extends TvUseCase {
  final TvRepository tvRepository;

  TvUsecaseImpl({required this.tvRepository});

  @override
  Future<TvEntity> getOnTheAir({required int page}) async {
    return await tvRepository.getOnTheAir(page);
  }

  @override
  Future<TvEntity> getPopular({required int page}) async {
    return await tvRepository.getPopular(page);
  }
}
