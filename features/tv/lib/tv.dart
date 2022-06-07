library tv;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/shared.dart';
import 'package:tv/presentation/ui/tv_list_screen.dart';

class TvModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      Modular.get<Routes>().tv,
      child: (context, args) => const TvScreen(),
    ),
  ];
}