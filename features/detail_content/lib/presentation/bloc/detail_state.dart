import 'package:detail_content/domain/entities/detail_entity.dart';
import 'package:equatable/equatable.dart';

const String detailState = "DETAIL STATE =>";

abstract class DetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {
  @override
  String toString() => "$detailState Initial";
}

class DetailLoading extends DetailState {
  @override
  String toString() => "$detailState Loading";
}

class DetailHasData extends DetailState {
  final int currentPage;
  final int maxPage;
  final List<Results> data;
  final bool hasReachedMax;

  DetailHasData({
    required this.currentPage,
    required this.maxPage,
    required this.data,
    required this.hasReachedMax,
  });

  @override
  List<Object> get props => [data];

  @override
  String toString() => "$detailState HasData";
}

class DetailNoData extends DetailState {
  final String message;

  DetailNoData({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$detailState NoData";
}

class DetailNoInternetConnection extends DetailState {
  final String message;

  DetailNoInternetConnection({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$detailState NoInternetConnection";
}

class DetailError extends DetailState {
  final String message;

  DetailError({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => "$detailState Error";
}
