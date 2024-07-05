import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/modules/training_module/training_controller.dart';
import 'package:distress_app/providers/theme_provider.dart';
import 'package:distress_app/routes/app_pages.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TrainingTopicScreen extends GetView<TrainingController> {
  const TrainingTopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        leadingWidth: getProportionateScreenWidth(56),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 32,
            color: AppColors.blackColor,
          ),
        ),
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: getProportionateScreenWidth(40),
              height: getProportionateScreenHeight(40),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.violence),
                ),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(8),
            ),
            Text(
              "Violence",
              style: TextStyle(
                fontSize: getProportionalFontSize(32),
                color: themeProvider.textThemeColor,
                fontFamily: AppFonts.sansFont600,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: GetBuilder<TrainingController>(
          builder: (controller) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(12),
                horizontal: getProportionateScreenWidth(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    style: TextStyle(
                      color: themeProvider.textThemeColor,
                      fontFamily: AppFonts.interFont700,
                      fontSize: getProportionalFontSize(13),
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(50),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Color(0xFFD0D0D0),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(50),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(50),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(50),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(24),
                        vertical: getProportionateScreenHeight(8),
                      ),
                      hintText: "Search something.....",
                      hintStyle: TextStyle(
                        color: themeProvider.textThemeColor,
                        fontFamily: AppFonts.interFont700,
                        fontSize: getProportionalFontSize(12),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        size: 24,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.TRAINING_TOPIC_DETAILS);
                    },
                    child: Column(
                      children: [
                        Divider(
                          height: 1,
                          color: AppColors.blackColor,
                        ),
                        Row(
                          children: [
                            Container(
                              width: getProportionateScreenWidth(36),
                              height: getProportionateScreenHeight(36),
                              margin: EdgeInsets.only(
                                right: getProportionateScreenWidth(4),
                                left: getProportionateScreenWidth(10),
                                top: getProportionateScreenHeight(10),
                                bottom: getProportionateScreenHeight(10),
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImages.notes),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Learn about Gender Based Violence",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: getProportionalFontSize(11),
                                      color: themeProvider.textThemeColor,
                                      fontFamily: AppFonts.sansFont700,
                                    ),
                                  ),
                                  Text(
                                    "This article describes gender based violence and the tips to prevent it. ",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: getProportionalFontSize(11),
                                      color: themeProvider.textThemeColor,
                                      fontFamily: AppFonts.sansFont400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 1,
                          color: AppColors.blackColor,
                        ),
                      ],
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
