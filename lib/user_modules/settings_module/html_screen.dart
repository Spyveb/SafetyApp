import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HTMLDataScreen extends GetView<SettingsController> {
  const HTMLDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: SafeArea(
        child: GetBuilder<SettingsController>(
          init: SettingsController(),
          builder: (controller) {
            return controller.title != null && controller.data != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(4),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              size: 24,
                              color: AppColors.blackColor,
                            ),
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(8),
                          ),
                          Expanded(
                            child: Text(
                              "${controller.title}",
                              style: TextStyle(
                                fontSize: getProportionalFontSize(24),
                                color: themeProvider.textThemeColor,
                                fontFamily: AppFonts.sansFont600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(4),
                            horizontal: getProportionateScreenWidth(18),
                          ),
                          child: Html(
                            data: controller.data,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox();
          },
        ),
      ),
    );
  }
}
