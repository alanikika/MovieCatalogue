import 'dart:async';
import 'dart:io';

import 'package:detail_content/domain/entities/detail_entity.dart';
import 'package:detail_content/domain/usecases/detail_usecase.dart';
import 'package:detail_content/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final DetailContentUseCase detailContentUseCase;

  DetailBloc({required this.detailContentUseCase}) : super(DetailInitial());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    final currentState = state;

    if (event is LoadMovieDetail) {
      try {
        DetailEntity _reviewEntity = DetailEntity();
        if (event.isInitial) {
          yield DetailLoading();
          _reviewEntity = await detailContentUseCase.getMovieReview(
              page: 1, movieId: event.id);
        } else if (currentState is DetailHasData &&
            !_detailHasReachedMax(currentState)) {
          _reviewEntity = await detailContentUseCase.getMovieReview(
            page: currentState.currentPage + 1,
            movieId: event.id,
          );
        }

        if (_reviewEntity.results!.isNotEmpty) {
          DetailHasData? hasData;
          if (!event.isInitial) hasData = state as DetailHasData;

          yield DetailHasData(
            currentPage: _reviewEntity.page!,
            maxPage: _reviewEntity.totalPages!,
            data: event.isInitial
                ? _reviewEntity.results!
                : hasData!.data + _reviewEntity.results!,
            hasReachedMax: _reviewEntity.page == _reviewEntity.totalPages
                ? true
                : false,
          );
        } else {
          yield DetailNoData(message: Strings.noData);
        }
      } on IOException {
        yield DetailNoInternetConnection(message: Strings.noConnection);
      } on TimeoutException {
        yield DetailNoInternetConnection(message: Strings.noConnection);
      } catch (e) {
        debugPrint("error: ${e.toString()}");
        yield DetailError(message: e.toString());
      }
    }

    if (event is LoadTvDetail) {
      try {
        DetailEntity _reviewEntity = DetailEntity();
        if (event.isInitial) {
          yield DetailLoading();
          _reviewEntity =
          await detailContentUseCase.getTvReview(page: 1, movieId: event.id);
        } else if (currentState is DetailHasData &&
            !_detailHasReachedMax(currentState)) {
          _reviewEntity = await detailContentUseCase.getMovieReview(
            page: currentState.currentPage + 1,
            movieId: event.id,
          );
        }

        if (_reviewEntity.results!.isNotEmpty) {
          DetailHasData? hasData;
          if (!event.isInitial) hasData = state as DetailHasData;

          yield DetailHasData(
            currentPage: _reviewEntity.page!,
            maxPage: _reviewEntity.totalPages!,
            data: event.isInitial
                ? _reviewEntity.results!
                : hasData!.data + _reviewEntity.results!,
            hasReachedMax: _reviewEntity.page == _reviewEntity.totalPages
                ? true
                : false,
          );
        } else {
          yield DetailNoData(message: Strings.noData);
        }
      } on IOException {
        yield DetailNoInternetConnection(message: Strings.noConnection);
      } on TimeoutException {
        yield DetailNoInternetConnection(message: Strings.noConnection);
      } catch (e) {
        debugPrint("error: ${e.toString()}");
        yield DetailError(message: e.toString());
      }
    }
  }

  bool _detailHasReachedMax(DetailState state) =>
      state is DetailHasData && state.hasReachedMax;
}
