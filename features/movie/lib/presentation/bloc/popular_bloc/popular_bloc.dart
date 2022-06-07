import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/usecases/movie_usecase.dart';
import 'package:movie/presentation/bloc/popular_bloc/bloc.dart';
import 'package:shared/shared.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final MovieUseCase movieUseCase;

  PopularBloc({required this.movieUseCase}) : super(PopularInitial());

  @override
  Stream<PopularState> mapEventToState(PopularEvent event) async* {
    final currentState = state;

    if (event is LoadPopular) {
      try {
        MovieEntity _popularEntity = MovieEntity();

        if (event.isInitial) {
          yield PopularLoading();
          _popularEntity = await movieUseCase.getPopular(page: 1);
        } else if (currentState is PopularHasData &&
            !_popularHasReachedMax(currentState)) {
          _popularEntity = await movieUseCase.getPopular(
            page: currentState.currentPage + 1,
          );
        }

        if (_popularEntity.movie!.isNotEmpty) {
          PopularHasData? hasData;
          if (!event.isInitial) hasData = state as PopularHasData;

          yield PopularHasData(
            currentPage: _popularEntity.page!,
            maxPage: _popularEntity.totalPages!,
            data: event.isInitial
                ? _popularEntity.movie!
                : hasData!.data + _popularEntity.movie!,
            hasReachedMax:
                _popularEntity.page == _popularEntity.totalPages ? true : false,
          );
        } else {
          yield PopularNoData(message: Strings.noData);
        }
      } on IOException {
        yield PopularNoInternetConnection(message: Strings.noConnection);
      } on TimeoutException {
        yield PopularNoInternetConnection(message: Strings.noConnection);
      } catch (e) {
        debugPrint("error: ${e.toString()}");
        yield PopularError(message: e.toString());
      }
    }
  }

  bool _popularHasReachedMax(PopularState state) =>
      state is PopularHasData && state.hasReachedMax!;
}
