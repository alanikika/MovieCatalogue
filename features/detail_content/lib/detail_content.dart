library detail_content;

import 'package:detail_content/domain/entities/detail_entity.dart';
import 'package:dio/dio.dart';
import 'package:detail_content/data/remote_data_source/detail_content_remote_data_source.dart';
import 'package:detail_content/data/repositories/detail_content_repository_impl.dart';
import 'package:detail_content/domain/repositories/detail_content_repository.dart';
import 'package:detail_content/domain/usecases/detail_usecase.dart';
import 'package:detail_content/presentation/bloc/bloc.dart';
import 'package:detail_content/presentation/ui/detail_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:shared/shared.dart';

class DetailModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((_) => DetailContentUseCaseImpl(
        detailContentRepository: Modular.get<DetailContentRepository>())),
    Bind((_) => DetailContentRepositoryImpl(
        detailContentDataSource:
        Modular.get<DetailContentRemoteDataSource>())),
    Bind((_) => DetailShowDatSourceImpl(dio: Modular.get<Dio>())),
    Bind((_) => DetailBloc(
        detailContentUseCase: Modular.get<DetailContentUseCase>())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      Modular.get<Routes>().detail,
      child: (context, arg) => DetailScreen(
        movieArgument: arg.data is Movie ? arg.data : null,
        tvArgument: arg.data is Results ? arg.data : null,
      ),
    ),
  ];
}