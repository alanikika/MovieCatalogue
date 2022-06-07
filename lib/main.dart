import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:bloc/bloc.dart';
import 'package:movie_catalogue/app_module.dart';
import 'package:movie_catalogue/app_widget.dart';
import 'package:movie_catalogue/bloc/bloc_observer.dart';
import 'package:shared/shared.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  // Modular.init(SharedModule());

  runApp(ModularApp(module: AppModule(), child: const MyApp()));
}