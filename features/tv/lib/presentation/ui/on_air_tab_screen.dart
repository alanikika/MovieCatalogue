
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared/shared.dart';
import 'package:tv/presentation/bloc/on_the_air/bloc.dart';

class OnAirTabScreen extends StatefulWidget {
  const OnAirTabScreen({Key? key}) : super(key: key);

  @override
  _OnAirTabScreenState createState() => _OnAirTabScreenState();
}

class _OnAirTabScreenState extends State<OnAirTabScreen>
    with AutomaticKeepAliveClientMixin<OnAirTabScreen> {
  final _scrollController = ScrollController();
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    if (Modular.get<OnTheAirBloc>().state is! OnTheAirHasData) {
      Modular.get<OnTheAirBloc>().add(LoadOnTheAir(isInitial: true));
    }

    _scrollController.addListener(_onScroll);
    _refreshCompleter = Completer<void>();
    super.initState();
  }

  Future<void> _onRefresh() {
    Modular.get<OnTheAirBloc>().add(LoadOnTheAir(isInitial: true));
    return _refreshCompleter!.future;
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryWhite,
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        showChildOpacityTransition: false,
        child: BlocBuilder<OnTheAirBloc, OnTheAirState>(
          builder: (context, state) {
            if (state is OnTheAirLoading) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return const LoadingCircular();
            } else if (state is OnTheAirNoData) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return const NoData(
                label: Strings.noData,
              );
            } else if (state is OnTheAirError ||
                state is OnTheAirNoInternetConnection) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return const Center(child: NoInternet());
            } else if (state is OnTheAirHasData) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.hasReachedMax!
                    ? state.data.length
                    : state.data.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.data.length
                      ? const LoadingCircular()
                      : CardTv(
                    title: state.data[index].name,
                    releaseDate: state.data[index].firstAirDate,
                    imageUrl: state.data[index].backdropPath,
                    rating: state.data[index].voteAverage.toString(),
                    onTap: () {
                      Modular.to.pushNamed(
                        Modular.get<Routes>().detailModule,
                        arguments: state.data[index],
                      );
                    },
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) Modular.get<OnTheAirBloc>().add(LoadOnTheAir());
  }

  bool get _isBottom {
    return _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
  }

  @override
  bool get wantKeepAlive => true;
}
