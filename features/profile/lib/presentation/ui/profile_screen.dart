
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        left: false,
        right: false,
        child: SizedBox(
          width: Dimens.width(context),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.standard_16(context),
                  vertical: Dimens.standard_32(context),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(Dimens.standard_4(context)),
                      decoration: const BoxDecoration(
                        color: CustomColors.primaryWhite,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: Dimens.standard_48(context),
                        backgroundColor: CustomColors.primaryWhite,
                        backgroundImage: AssetImage(
                          Modular.get<ImagePath>().me,
                        ),
                      ),
                    ),
                    Container(
                      width: Dimens.standard_4(context),
                      height: Dimens.standard_48(context),
                      margin: EdgeInsets.symmetric(
                        horizontal: Dimens.standard_16(context),
                      ),
                      decoration: BoxDecoration(
                        color: CustomColors.primaryWhite.withOpacity(.6),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.me,
                            style: Styles.sfDisplayRegular.copyWith(
                              color: CustomColors.colorAmber,
                              fontSize: Dimens.standard_24(context),
                              fontWeight: FontWeight.w600,
                              letterSpacing: .25,
                            ),
                          ),
                          Text(
                            Strings.flutterDev,
                            style: Styles.sfDisplayRegular.copyWith(
                              color: CustomColors.primaryWhite,
                              fontSize: Dimens.standard_16(context),
                              fontWeight: FontWeight.w600,
                              letterSpacing: .15,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors.primaryWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimens.standard_24(context)),
                      topRight: Radius.circular(Dimens.standard_24(context)),
                    ),
                  ),
                  padding: EdgeInsets.all(
                    Dimens.standard_16(context),
                  ),
                  child: Column(
                    children: [
                      _buildSocialMedia(
                        context,
                        colorBackground: CustomColors.primaryGreen,
                        iconPath: Modular.get<ImagePath>().github,
                        iconColor: CustomColors.primaryGreen,
                        label: Strings.github,
                        onTap: () async {
                          await _launchSocialMedia(
                              "https://github.com/alanikika");
                        },
                      ),
                      _buildSocialMedia(
                        context,
                        colorBackground: CustomColors.primaryColor,
                        iconPath: Modular.get<ImagePath>().linkedin,
                        iconColor: CustomColors.primaryColor,
                        label: Strings.linkedin,
                        onTap: () async {
                          await _launchSocialMedia(
                              "https://id.linkedin.com/in/alanikika-pratyaksa-58b02194");
                        },
                      ),
                      _buildSocialMedia(
                        context,
                        colorBackground: CustomColors.primaryBlack,
                        iconPath: Modular.get<ImagePath>().medium,
                        iconColor: CustomColors.primaryBlack,
                        label: Strings.medium,
                        onTap: () async {
                          await _launchSocialMedia(
                              "https://medium.com/@alanikika26");
                        },
                      ),
                      _buildSocialMedia(
                        context,
                        colorBackground: CustomColors.colorOrangeDark,
                        iconPath: Modular.get<ImagePath>().twitter,
                        iconColor: CustomColors.colorOrangeDark,
                        label: Strings.twitter,
                        onTap: () async {
                          await _launchSocialMedia(
                              "https://twitter.com/kikapratyaksa");
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchSocialMedia(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  Widget _buildSocialMedia(
      BuildContext context, {
        required Color colorBackground,
        required String iconPath,
        required Color iconColor,
        required String label,
        required VoidCallback onTap,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Dimens.standard_8(context)),
      child: Row(
        children: [
          Container(
            width: Dimens.standard_48(context),
            height: Dimens.standard_48(context),
            padding: EdgeInsets.all(Dimens.standard_16(context)),
            decoration: BoxDecoration(
              color: colorBackground.withOpacity(.25),
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              iconPath,
              color: iconColor.withOpacity(.8),
            ),
          ),
          SizedBox(
            width: Dimens.standard_24(context),
          ),
          Expanded(
            child: Text(
              label,
              style: Styles.sfDisplayRegular.copyWith(
                color: CustomColors.primaryBlack,
                fontSize: Dimens.standard_18(context),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: Dimens.standard_48(context),
              height: Dimens.standard_48(context),
              padding: EdgeInsets.all(Dimens.standard_16(context)),
              decoration: BoxDecoration(
                color: CustomColors.primaryBlack.withOpacity(.10),
                borderRadius: BorderRadius.circular(
                  Dimens.standard_8(context),
                ),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: Dimens.standard_16(context),
                color: CustomColors.primaryBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
