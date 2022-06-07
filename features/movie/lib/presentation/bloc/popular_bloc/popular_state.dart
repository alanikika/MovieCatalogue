import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_entity.dart';

const String popularState = "POPULAR STATE =>";

abstract class PopularState extends Equatable {
  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {
  @override
  String toString() => "$popularState Initial";
}

class PopularLoading extends PopularState {
  @override
  String toString() => "$popularState Loading";
}

class PopularHasData extends PopularState {
  final int currentPage;
  final int? maxPage;
  final List<Movie> data;
  final bool? hasReachedMax;

  PopularHasData({
    required this.currentPage,
    required this.maxPage,
    required this.data,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [data];

  @override
  String toString() => "$popularState HasData";
}

class PopularNoData extends PopularState {
  final String message;

  PopularNoData({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$popularState NoData";
}

class PopularNoInternetConnection extends PopularState {
  final String message;

  PopularNoInternetConnection({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$popularState NoInternetConnection";
}

class PopularError extends PopularState {
  final String message;

  PopularError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$popularState Error";
}
