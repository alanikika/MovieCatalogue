
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared/shared.dart';
import 'package:tv/presentation/bloc/popular/bloc.dart';

class PopularTabScreen extends StatefulWidget {
  const PopularTabScreen({Key? key}) : super(key: key);

  @override
  _PopularTabScreenState createState() => _PopularTabScreenState();
}

class _PopularTabScreenState extends State<PopularTabScreen> {
  final _scrollController = ScrollController();
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();
    if (Modular.get<PopularTvBloc>().state is! PopularHasData) {
      Modular.get<PopularTvBloc>().add(LoadPopular(isInitial: true));
    }

    _scrollController.addListener(_onScroll);
    _refreshCompleter = Completer<void>();
  }

  Future<void> _onRefresh() {
    Modular.get<PopularTvBloc>().add(LoadPopular(isInitial: true));
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryWhite,
      body: LiquidPullToRefresh(
        onRefresh: _onRefresh,
        showChildOpacityTransition: false,
        child: BlocBuilder<PopularTvBloc, PopularState>(
          builder: (context, state) {
            if (state is PopularLoading) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return const LoadingCircular();
            } else if (state is PopularNoData) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return const NoData(
                label: Strings.noData,
              );
            } else if (state is PopularError ||
                state is PopularNoInternetConnection) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return const Center(child: NoInternet());
            } else if (state is PopularHasData) {
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
                      // Modular.to.pushNamed(
                      //   Modular.get<Routes>().detailShow,
                      //   arguments: state.data[index],
                      // );
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
    if (_isBottom) Modular.get<PopularTvBloc>().add(LoadPopular());
  }

  bool get _isBottom {
    return _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
  }
}
