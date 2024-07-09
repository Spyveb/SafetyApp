import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/modules/training_module/training_controller.dart';
import 'package:distress_app/providers/theme_provider.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TrainingTopicDetailScreen extends GetView<TrainingController> {
  const TrainingTopicDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        // leadingWidth: getProportionateScreenWidth(60),
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
        clipBehavior: Clip.none,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: getProportionateScreenWidth(36),
                  height: getProportionateScreenHeight(36),
                  margin: EdgeInsets.only(
                    right: getProportionateScreenWidth(4),
                    // left: getProportionateScreenWidth(4),
                    top: getProportionateScreenHeight(10),
                    bottom: getProportionateScreenHeight(12),
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
                        maxLines: 2,
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
                children: [],
              ),
            );
          },
        ),
      ),
    );
  }
}
