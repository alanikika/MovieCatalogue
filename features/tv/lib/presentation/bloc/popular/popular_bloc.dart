import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:tv/domain/entities/tv_entity.dart';
import 'package:tv/domain/usecases/tv_usecases.dart';
import 'package:tv/presentation/bloc/popular/bloc.dart';

class PopularTvBloc extends Bloc<PopularEvent, PopularState> {
  final TvUseCase tvUseCase;

  PopularTvBloc({required this.tvUseCase}) : super(PopularInitial());

  @override
  Stream<PopularState> mapEventToState(PopularEvent event) async* {
    final currentState = state;
    if (event is LoadPopular) {
      try {
        TvEntity _tvEntity = TvEntity();
        if (event.isInitial) {
          yield PopularLoading();
          if(currentState is !LoadPopular) {
            _tvEntity = await tvUseCase.getPopular(page: 1);
          }
        } else if (currentState is PopularHasData &&
            !_popularAirHasReachedMax(currentState)) {
          _tvEntity =
          await tvUseCase.getPopular(page: currentState.currentPage + 1);
        }
        if (_tvEntity.results!.isNotEmpty) {
          PopularHasData? hasData;
          if (!event.isInitial) hasData = state as PopularHasData;

          yield PopularHasData(
            currentPage: _tvEntity.page!,
            maxPage: _tvEntity.totalPages,
            data: event.isInitial
                ? _tvEntity.results!
                : hasData!.data + _tvEntity.results!,
            hasReachedMax:
            _tvEntity.page == _tvEntity.totalPages ? true : false,
          );
        } else {
          yield PopularNoData(message: Strings.noData);
        }
      } on IOException {
        yield PopularNoInternetConnection(message: Strings.noConnection);
      } on TimeoutException {
        yield PopularNoInternetConnection(message: Strings.noConnection);
      } catch (e) {
        yield PopularError(message: e.toString());
      }
    }
  }

  bool _popularAirHasReachedMax(PopularState state) =>
      state is PopularHasData && state.hasReachedMax!;
}
