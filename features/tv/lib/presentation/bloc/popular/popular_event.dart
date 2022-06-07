import 'package:equatable/equatable.dart';

const String popularEvent = "ON THE AIR EVENT =>";

abstract class PopularEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadPopular extends PopularEvent {
  final bool isInitial;

  LoadPopular({this.isInitial = false});

  @override
  String toString() => "$popularEvent LoadOnTheAir";
}