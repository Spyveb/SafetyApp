import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TrainingTopicDetailScreen extends GetView<TrainingController> {
  const TrainingTopicDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return GetBuilder<TrainingController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: themeProvider.backgroundColor,
          appBar: AppBar(
            leadingWidth: getProportionateScreenWidth(34),
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                size: 24,
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
                  mainAxisSize: MainAxisSize.max,
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
                            "${controller.articleDetails.title}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: getProportionalFontSize(11),
                              color: themeProvider.textThemeColor,
                              fontFamily: AppFonts.sansFont700,
                            ),
                          ),
                          Text(
                            "${controller.articleDetails.subTitle}",
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
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(12),
                horizontal: getProportionateScreenWidth(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(data: controller.articleDetails.description),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
