import 'package:flutter/material.dart';
import 'package:shared/common/custom_colors.dart';
import 'package:shared/common/dimens.dart';
import 'package:shared/common/image_path.dart';
import 'package:shared/common/styles.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? label;
  final Color? labelColor;
  final int? elevation;
  final bool? isCenterTitle;
  final bool? isLeading;
  final List<String>? tabBarTitle;
  final TabController? controller;

  CustomAppBar({Key? key,
    this.label,
    this.labelColor = CustomColors.primaryColor,
    this.elevation = 0,
    this.isCenterTitle = true,
    this.isLeading = false,
    this.tabBarTitle,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.primaryWhite,
      elevation: 2,
      leading: isLeading!
          ? IconButton(
              icon: Image.asset(
                ImagePath.back,
                color: CustomColors.primaryColor,
                width: Dimens.standard_8(context),
                height: Dimens.standard_16(context),
              ),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      title: label != null
          ? Text(
              label!,
              style: Styles.sfDisplayRegular.copyWith(
                color: labelColor,
                fontSize: Dimens.standard_16(context),
                fontWeight: FontWeight.w400,
              ),
            )
          : const SizedBox(),
      centerTitle: isCenterTitle,
      bottom: tabBarTitle != null
          ? TabBar(
              controller: controller,
              unselectedLabelColor: CustomColors.primaryBlack.withOpacity(0.4),
              indicatorColor: CustomColors.primaryColor,
              labelColor: CustomColors.primaryColor,
              labelStyle: Styles.sfDisplayRegular.copyWith(
                  letterSpacing: .25,
                  fontWeight: FontWeight.w800,
                  fontSize: Dimens.standard_16(context)),
              unselectedLabelStyle: Styles.sfDisplayRegular.copyWith(
                letterSpacing: .25,
                fontSize: Dimens.standard_16(context),
              ),
              indicatorPadding: EdgeInsets.symmetric(
                horizontal: Dimens.standard_56(context),
              ),
              indicatorWeight: Dimens.standard_4(context),
              tabs: [
                for (int i = 0; i < tabBarTitle!.length; i++)
                  Tab(
                    child: Center(
                      child: Text(tabBarTitle![i],
                          style: Styles.sfDisplayRegular.copyWith(
                            fontSize: Dimens.standard_16(context),
                          )),
                    ),
                  )
              ],
            )
          : null,
    );
  }

  @override
  Size get preferredSize {
    if (tabBarTitle == null) {
      return const Size.fromHeight(kToolbarHeight);
    } else {
      return const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
    }
  }
}
