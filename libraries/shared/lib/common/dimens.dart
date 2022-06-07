import 'package:flutter/material.dart';

class Dimens {
  //Base size device
  ///Height = 812
  ///Width = 375

  static double _screenWidth = 0;
  static double _screenHeight = 0;

  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if(orientation == Orientation.portrait){
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450.0) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }
  }

  static double screenHeight = _screenHeight;

  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static standard_0(BuildContext context) {
    return 0.0;
  }

  static standard_1(BuildContext context) {
    return Dimens.width(context) / 375;
  }

  static standard_3(BuildContext context) {
    return Dimens.width(context) / 125;
  }

  static standard_4(BuildContext context) {
    return Dimens.width(context) / 93.75;
  }

  static standard_8(BuildContext context) {
    return Dimens.width(context) / 46.87;
  }

  static standard_12(BuildContext context) {
    return Dimens.width(context) / 31.25;
  }

  static standard_14(BuildContext context) {
    return Dimens.width(context) / 26.78;
  }

  static standard_16(BuildContext context) {
    return Dimens.width(context) / 23.43;
  }

  static standard_18(BuildContext context) {
    return Dimens.width(context) / 20.83;
  }

  static standard_24(BuildContext context) {
    return Dimens.width(context) / 15.62;
  }

  static standard_32(BuildContext context) {
    return Dimens.width(context) / 11.71;
  }

  static standard_40(BuildContext context) {
    return Dimens.width(context) / 9.37;
  }

  static standard_48(BuildContext context) {
    return Dimens.width(context) / 7.81;
  }

  static standard_56(BuildContext context) {
    return Dimens.width(context) / 6.69;
  }

  static standard_58(BuildContext context) {
    return Dimens.width(context) / 6.46;
  }

  static standard_64(BuildContext context) {
    return Dimens.width(context) / 5.81;
  }

  static standard_80(BuildContext context) {
    return Dimens.width(context) / 4.68;
  }
}