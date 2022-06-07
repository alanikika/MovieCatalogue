import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/shared.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
    );
  }
}
