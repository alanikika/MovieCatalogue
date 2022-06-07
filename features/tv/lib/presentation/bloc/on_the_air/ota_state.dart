import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv_entity.dart';

const String otaState = "ON THE AIR STATE =>";

abstract class OnTheAirState extends Equatable {
  @override
  List<Object> get props => [];
}

class OnTheAirInitial extends OnTheAirState {
  @override
  String toString() => "$otaState Initial";
}

class OnTheAirLoading extends OnTheAirState {
  @override
  String toString() => "$otaState Loading";
}

class OnTheAirHasData extends OnTheAirState {
  final int currentPage;
  final int? maxPage;
  final List<Results> data;
  final bool? hasReachedMax;

  OnTheAirHasData({
    required this.currentPage,
    required this.maxPage,
    required this.data,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [data];

  @override
  String toString() => "$otaState HasData";
}

class OnTheAirNoData extends OnTheAirState {
  final String message;

  OnTheAirNoData({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$otaState NoData";
}

class OnTheAirNoInternetConnection extends OnTheAirState {
  final String message;

  OnTheAirNoInternetConnection({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$otaState NoInternetConnection";
}

class OnTheAirError extends OnTheAirState {
  final String message;

  OnTheAirError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$otaState Error";
}
