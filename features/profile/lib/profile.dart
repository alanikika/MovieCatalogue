library profile;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:profile/presentation/ui/profile_screen.dart';
import 'package:shared/shared.dart';

class ProfileModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute(
      Modular.get<Routes>().profile,
      child: (context, args) => const ProfileScreen(),
    ),
  ];
}
