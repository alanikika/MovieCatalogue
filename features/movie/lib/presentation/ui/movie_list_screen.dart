import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:movie/presentation/bloc/now_playing_bloc/bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:movie/presentation/bloc/popular_bloc/bloc.dart';
import 'package:shared/shared.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final ScrollController _nowPlayingScrollController = ScrollController();
  final ScrollController _popularScrollController = ScrollController();
  // ScrollController _upComingScrollController = ScrollController();
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _init();
    _refreshCompleter = Completer<void>();
  }

  _init() {
    if (Modular.get<NowPlayingBloc>().state is! NowPlayingHasData) {
      Modular.get<NowPlayingBloc>().add(LoadNowPlaying(isInitial: true));
      debugPrint("======= init movie list screen");
    }
    if (Modular.get<PopularBloc>().state is! PopularHasData) {
      Modular.get<PopularBloc>().add(LoadPopular(isInitial: true));
    }
    // if (Modular.get<UpComingBloc>().state is! UpComingHasData) {
    //   Modular.get<UpComingBloc>().add(LoadUpComing(isInitial: true));
    // }

    _nowPlayingScrollController.addListener(_onScrollNowPlaying);
    _popularScrollController.addListener(_onScrollPopular);
    // _upComingScrollController.addListener(_onScrollUpComing);
  }

  Future<void> _onRefresh() {
    Modular.get<NowPlayingBloc>().add(LoadNowPlaying(isInitial: true));
    // Modular.get<PopularBloc>().add(LoadPopular(isInitial: true));
    // Modular.get<UpComingBloc>().add(LoadUpComing(isInitial: true));
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      child: Scaffold(
        backgroundColor: CustomColors.primaryWhite,
        appBar: CustomAppBar(
          isCenterTitle: true,
          label: Strings.appName,
        ),
        body: LiquidPullToRefresh(
          onRefresh: _onRefresh,
          showChildOpacityTransition: false,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                _buildNowPlaying(),
                SizedBox(
                  height: Dimens.standard_24(context),
                ),
                _buildPopular(),
                // SizedBox(
                //   height: Dimens.standard_24(context),
                // ),
                // _buildUpComing(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNowPlaying() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.standard_16(context),
          ),
          child: Text(
            Strings.nowPlaying,
            style: Styles.sfDisplayRegular.copyWith(
              color: CustomColors.primaryBlack,
              fontSize: Dimens.standard_16(context),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: Dimens.standard_16(context),
        ),
        SizedBox(
          width: Dimens.width(context),
          height: Dimens.width(context) / 1.8,
          child: BlocBuilder<NowPlayingBloc, NowPlayingState>(
            builder: (context, state) {
              if (state is NowPlayingHasData) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                List<Movie> movies = state.data;
                return ListView.builder(
                  controller: _nowPlayingScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.hasReachedMax!
                      ? state.data.length
                      : state.data.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.data.length
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CardMovie(
                            title: movies[index].title!,
                            url: movies[index].backdropPath,
                            onTap: () {
                              // Modular.to.pushNamed(
                              //   Modular.get<Routes>().detailShow,
                              //   arguments: movies[index],
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
      ],
    );
  }

  Widget _buildPopular() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.standard_16(context),
          ),
          child: Text(
            Strings.popular,
            style: Styles.sfDisplayRegular.copyWith(
              color: CustomColors.primaryBlack,
              fontSize: Dimens.standard_16(context),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: Dimens.standard_16(context),
        ),
        Container(
          width: Dimens.width(context),
          height: Dimens.width(context) / 1.8,
          child: BlocBuilder<PopularBloc, PopularState>(
            builder: (context, state) {
              if (state is PopularHasData) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
                List<Movie> movies = state.data;
                return ListView.builder(
                  controller: _popularScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.hasReachedMax!
                      ? state.data.length
                      : state.data.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.data.length
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CardMovie(
                            title: movies[index].title ?? "-",
                            url: movies[index].backdropPath,
                            onTap: () {
                              // Modular.to.pushNamed(
                              //   Modular.get<Routes>().detailShow,
                              //   arguments: movies[index],
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
      ],
    );
  }

  // Widget _buildUpComing() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Container(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: Dimens.standard_16(context),
  //         ),
  //         child: Text(
  //           Strings.upComing,
  //           style: Styles.sfDisplayRegular.copyWith(
  //             color: CustomColors.primaryBlack,
  //             fontSize: Dimens.standard_16(context),
  //             fontWeight: FontWeight.w700,
  //           ),
  //           textAlign: TextAlign.start,
  //         ),
  //       ),
  //       SizedBox(
  //         height: Dimens.standard_16(context),
  //       ),
  //       Container(
  //         width: Dimens.width(context),
  //         height: Dimens.width(context) / 1.8,
  //         child: BlocBuilder<UpComingBloc, UpComingState>(
  //           builder: (context, state) {
  //             if (state is UpComingHasData) {
  //               _refreshCompleter?.complete();
  //               _refreshCompleter = Completer();
  //               List<Movie> movies = state.data;
  //               return ListView.builder(
  //                 controller: _upComingScrollController,
  //                 scrollDirection: Axis.horizontal,
  //                 itemCount: state.hasReachedMax
  //                     ? state.data.length
  //                     : state.data.length + 1,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return index >= state.data.length
  //                       ? Center(
  //                     child: CircularProgressIndicator(),
  //                   )
  //                       : CardMovie(
  //                     title: movies[index].title,
  //                     url: movies[index].backdropPath,
  //                     onTap: () {
  //                       Modular.to.pushNamed(
  //                         Modular.get<Routes>().detailShow,
  //                         arguments: movies[index],
  //                       );
  //                     },
  //                   );
  //                 },
  //               );
  //             }
  //             return Container();
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  _onScrollNowPlaying() {
    if (_isRightNowPlaying) Modular.get<NowPlayingBloc>().add(LoadNowPlaying());
  }

  bool get _isRightNowPlaying {
    return _nowPlayingScrollController.position.pixels ==
        _nowPlayingScrollController.position.maxScrollExtent;
  }

  _onScrollPopular() {
    if (_isRightPopular) Modular.get<PopularBloc>().add(LoadPopular());
  }

  bool get _isRightPopular {
    return _popularScrollController.position.pixels ==
        _popularScrollController.position.maxScrollExtent;
  }
  //
  // _onScrollUpComing() {
  //   if (_isRightUpComing) Modular.get<UpComingBloc>().add(LoadUpComing());
  // }
  //
  // bool get _isRightUpComing {
  //   return _popularScrollController.position.pixels ==
  //       _popularScrollController.position.maxScrollExtent;
  // }
}
