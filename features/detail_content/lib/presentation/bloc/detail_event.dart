import 'package:equatable/equatable.dart';

const String detailEvent = "DETAIL SHOW EVENT =>";

abstract class DetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMovieDetail extends DetailEvent {
  final bool isInitial;
  final int id;

  LoadMovieDetail({this.isInitial = false, required this.id});

  @override
  String toString() => "$detailEvent LoadNowPlaying {id: $id}";
}

class LoadTvDetail extends DetailEvent {
  final bool isInitial;
  final int id;

  LoadTvDetail({this.isInitial = false, required this.id});

  @override
  String toString() => "$detailEvent LoadNowPlaying {id: $id}";
}