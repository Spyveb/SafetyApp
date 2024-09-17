import 'package:cached_network_image/cached_network_image.dart';
import 'package:distress_app/imports.dart';
import 'package:distress_app/infrastructure/models/article_model.dart';
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
        // leadingWidth: getProportionateScreenWidth(56),
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: getProportionateScreenWidth(40),
              height: getProportionateScreenHeight(40),
              decoration: BoxDecoration(
                color: AppColors.greyColor,
                shape: BoxShape.circle,
                image: DecorationImage(
                  // image: AssetImage(AppImages.violence),
                  image: CachedNetworkImageProvider(
                    controller.categoryModel != null && controller.categoryModel!.image != null ? controller.categoryModel!.image! : '',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(8),
            ),
            Text(
              "${controller.categoryModel != null && controller.categoryModel!.name != null ? controller.categoryModel!.name : ''}",
              style: TextStyle(
                fontSize: getProportionalFontSize(24),
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
            return BackgroundWidget(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(12),
                  horizontal: getProportionateScreenWidth(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        if (controller.categoryModel?.id != null) {
                          controller.getCategoryDetails(categoryId: controller.categoryModel!.id!, search: value, showLoader: false);
                        }
                      },
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
                        hintText: "${AppLocalizations.of(context)!.searchSomething}.....",
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
                    controller.articleList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.articleList.length,
                              itemBuilder: (context, index) {
                                ArticleModel article = controller.articleList[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller.goToArticleDetails(
                                      article,
                                    );
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    children: [
                                      Divider(
                                        height: index == 0 ? 1 : .4,
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
                                                // image: AssetImage(AppImages.violence),
                                                image: CachedNetworkImageProvider(
                                                  article.image ?? '',
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  article.title ?? '',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: getProportionalFontSize(11),
                                                    color: themeProvider.textThemeColor,
                                                    fontFamily: AppFonts.sansFont700,
                                                  ),
                                                ),
                                                Text(
                                                  article.subTitle ?? '',
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
                                        height: index == controller.articleList.length ? 1 : .4,
                                        color: AppColors.blackColor,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
