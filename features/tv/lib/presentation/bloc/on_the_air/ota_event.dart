import 'package:equatable/equatable.dart';

const String otaEvent = "ON THE AIR EVENT =>";

abstract class OnTheAirEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadOnTheAir extends OnTheAirEvent {
  final bool isInitial;

  LoadOnTheAir({this.isInitial = false});

  @override
  String toString() => "$otaEvent LoadOnTheAir";
}