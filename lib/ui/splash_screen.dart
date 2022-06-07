import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Image.asset(
            Modular.get<ImagePath>().appIcon,
            width: Dimens.width(context) / 3,
            height: Dimens.width(context) / 3,
          ),
        ),
      ),
    );
  }

  //Set duration splash screen
  _startSplashScreen() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, _navigationPage);
  }

  //Navigate to next page
  void _navigationPage() {
    Modular.to.pushReplacementNamed(Modular.get<Routes>().homeModule);
  }
}
