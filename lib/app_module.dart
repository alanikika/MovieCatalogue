import 'package:flutter_modular/flutter_modular.dart';
import 'package:home/home.dart';
import 'package:movie_catalogue/ui/splash_screen.dart';
import 'package:shared/shared.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => Routes()),
    Bind.lazySingleton((i) => ImagePath()),
    Bind.lazySingleton((i) => CustomColors()),
    Bind.lazySingleton((i) => Strings()),
  ];

  @override
  List<Module> get imports => [
    SharedModule(),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      Modular.get<Routes>().splash,
      child: (context, args) => const SplashScreen(),
    ),
    ModuleRoute(
      Modular.get<Routes>().homeModule,
      module: HomeModule(),
    ),
  ];
}