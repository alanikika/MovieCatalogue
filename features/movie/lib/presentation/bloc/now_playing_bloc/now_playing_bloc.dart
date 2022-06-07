import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/usecases/movie_usecase.dart';
import 'package:movie/presentation/bloc/now_playing_bloc/bloc.dart';
import 'package:shared/shared.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final MovieUseCase movieUseCase;

  NowPlayingBloc({required this.movieUseCase}) : super(NowPlayingInitial());

  @override
  Stream<NowPlayingState> mapEventToState(NowPlayingEvent event) async* {
    final currentState = state;

    if (event is LoadNowPlaying) {
      try {
        MovieEntity _movieResponse = MovieEntity();

        if (event.isInitial) {
          yield NowPlayingLoading();
          _movieResponse = await movieUseCase.getNowPlaying(page: 1);
        } else if (currentState is NowPlayingHasData &&
            !_nowPlayingHasReachedMax(currentState)) {
          _movieResponse = await movieUseCase.getNowPlaying(
            page: currentState.currentPage + 1,
          );
        }

        if (_movieResponse.movie!.isNotEmpty) {
          NowPlayingHasData? hasData;
          if (!event.isInitial) hasData = state as NowPlayingHasData;

          yield NowPlayingHasData(
            currentPage: _movieResponse.page!,
            maxPage: _movieResponse.totalPages,
            data: event.isInitial
                ? _movieResponse.movie!
                : hasData!.data + _movieResponse.movie!,
            hasReachedMax:
                _movieResponse.page == _movieResponse.totalPages ? true : false,
          );
        } else {
          yield NowPlayingNoData(message: Strings.noData);
        }
      } on IOException {
        yield NowPlayingNoInternetConnection(message: Strings.noConnection);
      } on TimeoutException {
        yield NowPlayingNoInternetConnection(message: Strings.noConnection);
      } catch (e) {
        debugPrint("error: ${e.toString()}");
        yield NowPlayingError(message: e.toString());
      }
    }
  }

  bool _nowPlayingHasReachedMax(NowPlayingState state) =>
      state is NowPlayingHasData && state.hasReachedMax!;
}
