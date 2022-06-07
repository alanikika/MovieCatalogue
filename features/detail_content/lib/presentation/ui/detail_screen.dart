import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:detail_content/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:movie/domain/entities/movie_entity.dart';
import 'package:shared/shared.dart';
import 'package:tv/domain/entities/tv_entity.dart';

class DetailScreen extends StatefulWidget {
  final Movie? movieArgument;
  final Results? tvArgument;

  const DetailScreen({Key? key, this.movieArgument, this.tvArgument})
      : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Movie? movieArgument = Movie();
  Results? tvArgument = Results();

  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();
    movieArgument = widget.movieArgument;
    tvArgument = widget.tvArgument;
    debugPrint("------- ${movieArgument!.toJson().toString()}");

    if (movieArgument != null) {
      Modular.get<DetailBloc>().add(
        LoadMovieDetail(isInitial: true, id: movieArgument!.id!),
      );
    } else {
      Modular.get<DetailBloc>().add(
        LoadTvDetail(isInitial: true, id: tvArgument!.id!),
      );
    }

    _refreshCompleter = Completer<void>();
  }

  Future<void> _onRefresh() {
    if (movieArgument != null) {
      Modular.get<DetailBloc>().add(
        LoadMovieDetail(isInitial: true, id: movieArgument!.id!),
      );
    } else {
      Modular.get<DetailBloc>().add(
        LoadTvDetail(isInitial: true, id: tvArgument!.id!),
      );
    }
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryWhite,
      body: SafeArea(
        child: LiquidPullToRefresh(
          onRefresh: _onRefresh,
          showChildOpacityTransition: false,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: Dimens.height(context) / 3,
                  floating: true,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: CachedNetworkImage(
                      imageUrl: movieArgument != null
                          ? movieArgument!.backdropPath!.imageOriginal
                          : tvArgument!.backdropPath!.imageOriginal,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const LoadingCircular(),
                      errorWidget: (context, url, error) => const ErrorImage(),
                    ),
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(Dimens.standard_16(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          movieArgument != null
                              ? movieArgument!.adult!
                                  ? Strings.adult
                                  : "-"
                              : "-",
                          style: Styles.sfDisplayRegular.copyWith(
                            color: CustomColors.primaryBlack,
                            fontSize: Dimens.standard_14(context),
                            fontWeight: FontWeight.w500,
                            letterSpacing: .25,
                          ),
                        ),
                        SizedBox(
                          width: Dimens.standard_24(context),
                        ),
                        Text(
                          movieArgument != null
                              ? movieArgument!.releaseDate!.split("-")[0]
                              : tvArgument!.firstAirDate!.split("-")[0],
                          style: Styles.sfDisplayRegular.copyWith(
                            color: CustomColors.primaryBlack,
                            fontSize: Dimens.standard_14(context),
                            fontWeight: FontWeight.w500,
                            letterSpacing: .25,
                          ),
                        ),
                        SizedBox(
                          width: Dimens.standard_24(context),
                        ),
                        Icon(
                          Icons.star,
                          color: CustomColors.colorAmber,
                          size: Dimens.standard_18(context),
                        ),
                        SizedBox(
                          width: Dimens.standard_8(context),
                        ),
                        Text(
                          movieArgument != null
                              ? movieArgument!.voteAverage!.toString()
                              : tvArgument!.voteAverage!.toString(),
                          style: Styles.sfDisplayRegular.copyWith(
                            color: CustomColors.primaryBlack,
                            fontSize: Dimens.standard_14(context),
                            fontWeight: FontWeight.w500,
                            letterSpacing: .25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimens.standard_24(context),
                    ),
                    Text(
                      movieArgument != null
                          ? movieArgument!.title!
                          : tvArgument!.name!,
                      style: Styles.sfDisplayRegular.copyWith(
                        color: CustomColors.primaryBlack,
                        fontSize: Dimens.standard_16(context),
                        fontWeight: FontWeight.w700,
                        letterSpacing: .25,
                      ),
                    ),
                    SizedBox(
                      height: Dimens.standard_16(context),
                    ),
                    Text(
                      movieArgument != null
                          ? movieArgument!.overview!
                          : tvArgument!.overview!,
                      style: Styles.sfDisplayRegular.copyWith(
                        color: CustomColors.primaryBlack.withOpacity(.7),
                        fontSize: Dimens.standard_12(context),
                        fontWeight: FontWeight.w500,
                        letterSpacing: .15,
                      ),
                    ),
                    SizedBox(
                      height: Dimens.standard_24(context),
                    ),
                    _buildReviews(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviews(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          Strings.reviews,
          style: Styles.sfDisplayRegular.copyWith(
            color: CustomColors.primaryBlack,
            fontSize: Dimens.standard_16(context),
            fontWeight: FontWeight.w700,
            letterSpacing: .25,
          ),
        ),
        SizedBox(
          height: Dimens.standard_16(context),
        ),
        BlocBuilder<DetailBloc, DetailState>(
          builder: (context, state) {
            if (state is DetailLoading) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return const LoadingCircular();
            } else if (state is DetailHasData) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _itemReview(
                    context,
                    state.data[index].author!,
                    state.data[index].content!,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: CustomColors.primaryBlack.withOpacity(.24),
                    thickness: 2.0,
                  );
                },
              );
            } else if (state is DetailNoData) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return const NoData(
                label: Strings.noReview,
              );
            } else if (state is DetailNoInternetConnection ||
                state is DetailError) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
              return const NoInternet();
            }
            return const SizedBox();
          },
        )
      ],
    );
  }

  Widget _itemReview(BuildContext context, String author, String content) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimens.standard_8(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            author,
            style: Styles.sfDisplayItalic.copyWith(
              color: CustomColors.primaryBlack.withOpacity(.75),
              fontSize: Dimens.standard_12(context),
              fontWeight: FontWeight.w600,
              letterSpacing: .25,
            ),
          ),
          SizedBox(
            height: Dimens.standard_16(context),
          ),
          Text(
            content,
            style: Styles.sfDisplayRegular.copyWith(
              color: CustomColors.primaryBlack.withOpacity(.50),
              fontSize: Dimens.standard_12(context),
              fontWeight: FontWeight.w500,
              letterSpacing: .25,
            ),
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
