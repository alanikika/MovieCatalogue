import 'package:equatable/equatable.dart';

const String upComingEvent = "UP COMING EVENT =>";

class UpComingEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadUpComing extends UpComingEvent {
  final bool isInitial;

  LoadUpComing({this.isInitial = false});

  @override
  String toString() => "$upComingEvent UpComingEvent";
}
