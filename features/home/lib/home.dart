library home;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:home/presentation/bloc/bloc.dart';
import 'package:home/presentation/menu_screen.dart';
import 'package:shared/common/routes.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
    Bind((_) => HomeBloc(PageLoading())),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      Modular.get<Routes>().menu,
      child: (context, args) => const MenuScreen(),
    ),
  ];
}
