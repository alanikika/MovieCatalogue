import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/shared.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          Modular.get<ImagePath>().offline,
          width: Dimens.width(context) / 2,
          height: Dimens.width(context) / 2,
        ),
        Text(
          Strings.noInternet,
          style: Styles.sfDisplayRegular.copyWith(
            color: CustomColors.primaryBlack,
            fontWeight: FontWeight.w600,
            fontSize: Dimens.standard_14(context),
            letterSpacing: .25,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
