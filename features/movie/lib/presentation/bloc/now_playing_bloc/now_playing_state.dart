import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_entity.dart';

const String nowPlayingState = "NOW PLAYING STATE =>";

abstract class NowPlayingState extends Equatable {
  @override
  List<Object> get props => [];
}

class NowPlayingInitial extends NowPlayingState {
  @override
  String toString() => "$nowPlayingState Initial";
}

class NowPlayingLoading extends NowPlayingState {
  @override
  String toString() => "$nowPlayingState Loading";
}

class NowPlayingHasData extends NowPlayingState {
  final int currentPage;
  final int? maxPage;
  final List<Movie> data;
  final bool? hasReachedMax;

  NowPlayingHasData({
    required this.currentPage,
    required this.maxPage,
    required this.data,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [data];

  @override
  String toString() => "$nowPlayingState HasData";
}

class NowPlayingNoData extends NowPlayingState {
  final String message;

  NowPlayingNoData({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$nowPlayingState NoData";
}

class NowPlayingNoInternetConnection extends NowPlayingState {
  final String message;

  NowPlayingNoInternetConnection({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$nowPlayingState NoInternetConnection";
}

class NowPlayingError extends NowPlayingState {
  final String message;

  NowPlayingError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$nowPlayingState Error";
}
