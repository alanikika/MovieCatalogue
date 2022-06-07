import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_entity.dart';

const String upComingState = "UP COMING STATE =>";

abstract class UpComingState extends Equatable {
  @override
  List<Object> get props => [];
}

class UpComingInitial extends UpComingState {
  @override
  String toString() => "$upComingState Initial";
}

class UpComingLoading extends UpComingState {
  @override
  String toString() => "$upComingState Loading";
}

class UpComingHasData extends UpComingState {
  final int currentPage;
  final int? maxPage;
  final List<Movie> data;
  final bool? hasReachedMax;

  UpComingHasData({
    required this.currentPage,
    required this.maxPage,
    required this.data,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [data];

  @override
  String toString() => "$upComingState HasData";
}

class UpComingNoData extends UpComingState {
  final String message;

  UpComingNoData({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$upComingState NoData";
}

class UpComingNoInternetConnection extends UpComingState {
  final String message;

  UpComingNoInternetConnection({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$upComingState NoInternetConnection";
}

class UpComingError extends UpComingState {
  final String message;

  UpComingError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$upComingState Error";
}
