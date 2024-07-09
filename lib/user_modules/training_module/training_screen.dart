import 'package:distress_app/componants/common_button.dart';
import 'package:distress_app/componants/custom_top_bar.dart';
import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/localization/app_localizations.dart';
import 'package:distress_app/modules/training_module/training_controller.dart';
import 'package:distress_app/providers/theme_provider.dart';
import 'package:distress_app/routes/app_pages.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:distress_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TrainingScreen extends GetView<TrainingController> {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: SafeArea(
        child: GetBuilder<TrainingController>(
          init: TrainingController(),
          builder: (controller) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(12),
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            AppLocalizations.of(context)!.trainings,
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
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.timeline,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(12),
                          color: themeProvider.textThemeColor,
                          fontFamily: AppFonts.interFont500,
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(12),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(22),
                    ),
                    width: SizeConfig.deviceWidth! * .65,
                    child: CustomTopBar(
                      onTabSelect: (value) {
                        // controller.changeTabIndex(value);
                      },
                      currentIndex: controller.tabIndex,
                      items: [
                        AppLocalizations.of(context)!.education,
                        AppLocalizations.of(context)!.training,
                      ],
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.educationList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Get.toNamed(Routes.TRAINING_TOPIC);
                        },
                        child: Column(
                          children: [
                            Divider(
                              height: index == 0 ? 1 : .5,
                              color: AppColors.blackColor,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: getProportionateScreenWidth(40),
                                  height: getProportionateScreenHeight(40),
                                  margin: EdgeInsets.only(
                                    right: getProportionateScreenWidth(8),
                                    left: getProportionateScreenWidth(4),
                                    top: getProportionateScreenHeight(4),
                                    bottom: getProportionateScreenHeight(8),
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(AppImages.violence),
                                    ),
                                  ),
                                ),
                                Text(
                                  "${controller.educationList[index]}",
                                  style: TextStyle(
                                    fontSize: getProportionalFontSize(16),
                                    color: themeProvider.textThemeColor,
                                    fontFamily: AppFonts.sansFont700,
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 24,
                                    color: AppColors.blackColor,
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              height: index == 4 ? 1 : .5,
                              color: AppColors.blackColor,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
