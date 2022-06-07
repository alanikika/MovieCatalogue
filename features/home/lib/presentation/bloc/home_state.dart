import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrentIndexChanged extends HomeState {
  final int currentIndex;

  CurrentIndexChanged({required this.currentIndex});

  @override
  List<Object> get props => [currentIndex];

  @override
  String toString() =>
      'Nav Bar State => CurrentIndexChange: Current index $currentIndex';
}

class PageLoading extends HomeState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Nav Bar State => PageLoading";
}

class MoviePageLoaded extends HomeState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Nav Bar State => MoviePageLoaded";
}

class TvPageLoaded extends HomeState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Nav Bar State => TvPageLoaded";
}

class ProfilePageLoaded extends HomeState {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Nav Bar State => ProfilePageLoaded";
}
