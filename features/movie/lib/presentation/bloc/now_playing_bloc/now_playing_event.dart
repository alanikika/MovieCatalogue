import 'package:equatable/equatable.dart';

const String movieEvent = "NOW PLAYING EVENT =>";

abstract class NowPlayingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadNowPlaying extends NowPlayingEvent {
  final bool isInitial;

  LoadNowPlaying({this.isInitial = false});

  @override
  String toString() => "$movieEvent LoadNowPlaying";
}