library home;

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:home/presentation/bloc/bloc.dart';
import 'package:home/presentation/menu_screen.dart';
import 'package:movie/data/remote_data_sources/movie_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repositories.dart';
import 'package:movie/domain/usecases/movie_usecase.dart';
import 'package:movie/presentation/bloc/now_playing_bloc/bloc.dart';
import 'package:movie/presentation/bloc/popular_bloc/bloc.dart';
import 'package:shared/common/routes.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((_) => HomeBloc(PageLoading())),
    Bind((_) => MovieUseCaseImpl(
        movieRepositories: Modular.get<MovieRepositories>())),
    Bind((_) => MovieRepositoriesImpl(
        movieDataSource: Modular.get<MovieDataSource>())),
    Bind((_) => MovieDataSourceImpl(dio: Modular.get<Dio>())),
    Bind((_) => NowPlayingBloc(movieUseCase: Modular.get<MovieUseCase>())),
    Bind((_) => PopularBloc(movieUseCase: Modular.get<MovieUseCase>())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      Modular.get<Routes>().menu,
      child: (context, args) => const MenuScreen(),
    ),
  ];
}
