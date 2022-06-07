import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:tv/domain/entities/tv_entity.dart';
import 'package:tv/domain/usecases/tv_usecases.dart';
import 'package:tv/presentation/bloc/on_the_air/bloc.dart';

class OnTheAirBloc extends Bloc<OnTheAirEvent, OnTheAirState> {
  final TvUseCase tvUseCase;

  OnTheAirBloc({required this.tvUseCase}) : super(OnTheAirInitial());

  @override
  Stream<OnTheAirState> mapEventToState(OnTheAirEvent event) async* {
    final currentState = state;
    if (event is LoadOnTheAir) {
      try {
        TvEntity _tvEntity = TvEntity();
        if (event.isInitial) {
          yield OnTheAirLoading();
          _tvEntity = await tvUseCase.getOnTheAir(page: 1);
        } else if (currentState is OnTheAirHasData &&
            !_onTheAirHasReachedMax(currentState)) {
          _tvEntity =
          await tvUseCase.getOnTheAir(page: currentState.currentPage + 1);
        }
        if (_tvEntity.results!.isNotEmpty) {
          OnTheAirHasData? hasData;
          if (!event.isInitial) hasData = state as OnTheAirHasData;

          yield OnTheAirHasData(
            currentPage: _tvEntity.page!,
            maxPage: _tvEntity.totalPages,
            data: event.isInitial
                ? _tvEntity.results!
                : hasData!.data + _tvEntity.results!,
            hasReachedMax:
            _tvEntity.page == _tvEntity.totalPages ? true : false,
          );
        } else {
          yield OnTheAirNoData(message: Strings.noData);
        }
      } on IOException {
        yield OnTheAirNoInternetConnection(message: Strings.noConnection);
      } on TimeoutException {
        yield OnTheAirNoInternetConnection(message: Strings.noConnection);
      } catch (e) {
        yield OnTheAirError(message: e.toString());
      }
    }
  }

  bool _onTheAirHasReachedMax(OnTheAirState state) =>
      state is OnTheAirHasData && state.hasReachedMax!;
}
