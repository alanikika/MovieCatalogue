library movie;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:movie/presentation/ui/movie_list_screen.dart';
import 'package:shared/shared.dart';

class MovieModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.get<Routes>().movie,
          child: (context, args) => const MovieListScreen(),
        ),
      ];
}
