import 'package:detail_content/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:home/presentation/bloc/bloc.dart';
import 'package:movie/presentation/bloc/now_playing_bloc/bloc.dart';
import 'package:movie/presentation/bloc/popular_bloc/bloc.dart';
import 'package:movie/presentation/bloc/upcoming_bloc/bloc.dart';
import 'package:shared/shared.dart';
import 'package:tv/presentation/bloc/on_the_air/bloc.dart';
import 'package:tv/presentation/bloc/popular/bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Modular.get<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => Modular.get<NowPlayingBloc>(),
        ),
        BlocProvider(
          create: (context) => Modular.get<PopularBloc>(),
        ),
        BlocProvider(
          create: (context) => Modular.get<UpComingBloc>(),
        ),
        BlocProvider(
          create: (context) => Modular.get<OnTheAirBloc>(),
        ),
        BlocProvider(
          create: (context) => Modular.get<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (context) => Modular.get<DetailBloc>(),
        ),
      ],
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              Dimens().init(constraints, orientation);
              return GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: MaterialApp.router(
                  title: "FilmKu",
                  routeInformationParser: Modular.routeInformationParser,
                  routerDelegate: Modular.routerDelegate,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
