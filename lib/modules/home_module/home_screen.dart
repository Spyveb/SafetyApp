import 'dart:async';
import 'dart:ui';

import 'package:distress_app/componants/common_button.dart';
import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/helpers/utils.dart';
import 'package:distress_app/localization/app_localizations.dart';
import 'package:distress_app/modules/home_module/home_controller.dart';
import 'package:distress_app/providers/theme_provider.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:distress_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: SafeArea(
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(12),
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: themeProvider.textColor,
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(12),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.profile,
                            style: TextStyle(
                              fontSize: getProportionalFontSize(32),
                              color: themeProvider.textThemeColor,
                              fontFamily: AppFonts.sansFont600,
                            ),
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.welcome}, Edward",
                            style: TextStyle(
                              fontSize: getProportionalFontSize(16),
                              color: themeProvider.lightTextThemeColor,
                              fontFamily: AppFonts.sansFont400,
                            ),
                          ),
                        ],
                      ),
                      // Spacer(),
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Image.asset(
                      //     AppImages.hotspot,
                      //     width: getProportionateScreenWidth(50),
                      //     height: getProportionateScreenHeight(50),
                      //   ),
                      // )
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(12),
                      horizontal: getProportionateScreenWidth(8),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor.withOpacity(.3),
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              AppImages.tip,
                              height: getProportionateScreenHeight(40),
                              width: getProportionateScreenWidth(30),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(8),
                            ),
                            Text(
                              AppLocalizations.of(context)!.tipOfTheDay,
                              style: TextStyle(
                                fontSize: getProportionalFontSize(16),
                                color: themeProvider.textThemeColor,
                                fontFamily: AppFonts.sansFont700,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(4),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(6),
                          ),
                          child: Text(
                            Constants.LoremIpsum,
                            style: TextStyle(
                              fontSize: getProportionalFontSize(12),
                              color: themeProvider.textThemeColor,
                              fontFamily: AppFonts.sansFont700,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CommonButton(
                            width: getProportionateScreenWidth(80),
                            text: AppLocalizations.of(context)!.next,
                            radius: 30,
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(4),
                              horizontal: getProportionateScreenWidth(16),
                            ),
                            onPressed: () {
                              // var _isDarkThemeSelected = true;
                              // final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                              // themeProvider.setTheme(ThemeData.light(), notify: true);
                              // controller.update();
                            },
                            textStyle: TextStyle(
                              fontSize: getProportionalFontSize(12),
                              fontFamily: AppFonts.sansFont700,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(12),
                  ),
                  Divider(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppImages.locationPin,
                        height: getProportionateScreenHeight(62),
                        width: getProportionateScreenWidth(62),
                      ),
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont500,
                            fontSize: getProportionalFontSize(16),
                            color: AppColors.blackColor,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),

                            ///TODO text change
                            hintText: "Search location",
                            hintStyle: TextStyle(
                              fontFamily: AppFonts.sansFont400,
                              fontSize: getProportionalFontSize(14),
                              color: AppColors.textFieldGreyColor,
                            ),
                            errorStyle: TextStyle(
                              fontSize: getProportionalFontSize(12),
                              fontFamily: AppFonts.sansFont400,
                              color: AppColors.redDefault,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Text(
                    AppLocalizations.of(context)!.emergencyServices,
                    style: TextStyle(
                      fontSize: getProportionalFontSize(24),
                      fontFamily: AppFonts.sansFont700,
                      color: themeProvider.textThemeColor,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(8),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.dialogIsOpen = true;
                      controller.update();
                      Timer timer = Timer(Duration(seconds: 5), () {
                        if (controller.dialogIsOpen) {
                          Get.back();
                        }
                      });
                      Utils.showCustomDialog(
                          context: context,
                          child: Center(
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(32),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 1.5,
                                  sigmaY: 1.5,
                                ),
                                child: GetBuilder<HomeController>(
                                  builder: (controller) {
                                    return Container(
                                      width: SizeConfig.deviceWidth! * .9,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getProportionateScreenWidth(8),
                                        vertical: getProportionateScreenHeight(18),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          getProportionateScreenWidth(32),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            height: getProportionateScreenHeight(171),
                                            width: getProportionateScreenWidth(151),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(AppImages.time),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!.thankYouForReporting,
                                            style: TextStyle(
                                              fontFamily: AppFonts.sansFont600,
                                              fontSize: getProportionalFontSize(20),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: getProportionateScreenHeight(10),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!.youCanUndoThisReportWithin5Seconds,
                                            style: TextStyle(
                                              fontFamily: AppFonts.sansFont400,
                                              fontSize: getProportionalFontSize(16),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: getProportionateScreenHeight(28),
                                          ),
                                          CommonButton(
                                            width: getProportionateScreenWidth(196),
                                            text: AppLocalizations.of(context)!.undo,
                                            onPressed: () {
                                              Get.back();
                                            },
                                            radius: 50,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          onPop: () {
                            timer.cancel();
                            controller.dialogIsOpen = false;
                            controller.update();
                          },
                          barrierDismissible: false);
                    },
                    child: Container(
                      width: SizeConfig.deviceWidth,
                      height: getProportionateScreenHeight(280),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: AppColors.redDefault, shape: BoxShape.circle),
                      child: Text(
                        AppLocalizations.of(context)!.pressButtonToSendSOS,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.interFont700,
                          color: themeProvider.textThemeColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
