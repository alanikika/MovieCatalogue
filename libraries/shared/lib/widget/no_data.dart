import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NoData extends StatelessWidget {

  final String label;

  const NoData({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            Modular.get<ImagePath>().noData,
            width: Dimens.width(context) / 2,
            height: Dimens.width(context) / 2,
          ),
        ),
        Text(
          label,
          style: Styles.sfDisplayRegular.copyWith(
            color: CustomColors.primaryBlack,
            fontWeight: FontWeight.w600,
            fontSize: Dimens.standard_14(context),
            letterSpacing: .25,
          ),
        ),
      ],
    );
  }
}
