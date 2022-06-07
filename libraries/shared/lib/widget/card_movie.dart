import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardMovie extends StatelessWidget {
  final String? url;
  final String title;
  final VoidCallback onTap;

  const CardMovie(
      {Key? key, this.url, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Dimens.width(context) / 2.5,
        margin: EdgeInsets.symmetric(
          horizontal: Dimens.standard_8(context),
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Dimens.standard_12(context),
            ),
          ),
          child: Stack(
            children: [
              // Image
              // ClipRRect(
              //   borderRadius: BorderRadius.all(
              //       Radius.circular(Dimens.standard_12(context))),
              //   child: CachedNetworkImage(
              //     imageUrl: url.imageOriginal,
              //     height: Dimens.width(context) / 1.8,
              //     width: Dimens.width(context) / 2.5,
              //     fit: BoxFit.cover,
              //     placeholder: (context, url) => const LoadingCircular(),
              //     errorWidget: (context, url, error) => const ErrorImage(),
              //   ),
              // ),
              const Text("=== IMAGE ===="),

              // Background
              Container(
                height: Dimens.width(context) / 1.8,
                width: Dimens.width(context) / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimens.standard_12(context))),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.98],
                    colors: [
                      Colors.transparent,
                      CustomColors.primaryBlack,
                    ],
                  ),
                ),
              ),
              Positioned(
                left: Dimens.standard_8(context),
                right: Dimens.standard_8(context),
                bottom: Dimens.standard_8(context),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: Styles.sfDisplayRegular.copyWith(
                        color: CustomColors.primaryWhite,
                        fontSize: Dimens.standard_16(context),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
