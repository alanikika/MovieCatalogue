import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class CardTv extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final String? releaseDate;
  final String? rating;
  final VoidCallback? onTap;

  const CardTv({Key? key,
    this.imageUrl,
    this.title,
    this.releaseDate,
    this.rating,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: Dimens.width(context) / 2.7,
        margin: EdgeInsets.symmetric(
          horizontal: Dimens.standard_16(context),
          vertical: Dimens.standard_8(context),
        ),
        padding: EdgeInsets.all(Dimens.standard_8(context)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  Dimens.standard_12(context),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl!.imageOriginal,
                height: Dimens.width(context) / 2.6,
                width: Dimens.width(context) / 3.8,
                fit: BoxFit.cover,
                placeholder: (context, url) => const LoadingCircular(),
                errorWidget: (context, url, error) => const ErrorImage(),
              ),
            ),
            SizedBox(
              width: Dimens.standard_16(context),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title ?? "-",
                    style: Styles.sfDisplayRegular.copyWith(
                      color: CustomColors.primaryBlack,
                      fontSize: Dimens.standard_16(context),
                      fontWeight: FontWeight.w600,
                      letterSpacing: .15,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: Dimens.standard_8(context),
                  ),
                  Text(
                    releaseDate ?? "-",
                    style: Styles.sfDisplayRegular.copyWith(
                      color: CustomColors.colorGrey,
                      fontSize: Dimens.standard_12(context),
                      fontWeight: FontWeight.w500,
                      letterSpacing: .15,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: Dimens.standard_24(context),
                          ),
                          SizedBox(
                            width: Dimens.standard_8(context),
                          ),
                          Text(
                            rating ?? "-",
                            style: Styles.sfDisplayRegular.copyWith(
                              color: CustomColors.primaryBlack.withOpacity(.6),
                              fontSize: Dimens.standard_16(context),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
