import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieStarted extends HomeEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => "Nav Bar Event: Movie Started";
}

class PageTapped extends HomeEvent {

  final int index;

  PageTapped({required this.index});

  @override
  List<Object> get props => [index];

  @override
  String toString() => "Nav Bar Event: Page Tapped Index $index";
}