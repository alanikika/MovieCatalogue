import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/domain/usecases/movie_usecase.dart';
import 'package:movie/presentation/bloc/upcoming_bloc/bloc.dart';
import 'package:shared/shared.dart';

class UpComingBloc extends Bloc<UpComingEvent, UpComingState> {
  final MovieUseCase movieUseCase;

  UpComingBloc({required this.movieUseCase}) : super(UpComingInitial());

  @override
  Stream<UpComingState> mapEventToState(UpComingEvent event) async* {
    final currentState = state;

    if (event is LoadUpComing) {
      try {
        MovieEntity _upcomingEntity = MovieEntity();

        if (event.isInitial) {
          yield UpComingLoading();
          _upcomingEntity = await movieUseCase.getUpComing(page: 1);
        } else if (currentState is UpComingHasData &&
            !_upComingHasReachedMax(currentState)) {
          _upcomingEntity = await movieUseCase.getUpComing(
            page: currentState.currentPage + 1,
          );
        }

        if (_upcomingEntity.movie!.isNotEmpty) {
          UpComingHasData? hasData;
          if (!event.isInitial) hasData = state as UpComingHasData;

          yield UpComingHasData(
            currentPage: _upcomingEntity.page!,
            maxPage: _upcomingEntity.totalPages,
            data: event.isInitial
                ? _upcomingEntity.movie!
                : hasData!.data + _upcomingEntity.movie!,
            hasReachedMax:
                _upcomingEntity.page == _upcomingEntity.totalPages
                    ? true
                    : false,
          );
        } else {
          yield UpComingNoData(message: Strings.noData);
        }
      } on IOException {
        yield UpComingNoInternetConnection(message: Strings.noConnection);
      } on TimeoutException {
        yield UpComingNoInternetConnection(message: Strings.noConnection);
      } catch (e) {
        debugPrint("error: ${e.toString()}");
        yield UpComingError(message: e.toString());
      }
    }
  }

  bool _upComingHasReachedMax(UpComingState state) =>
      state is UpComingHasData && state.hasReachedMax!;
}
