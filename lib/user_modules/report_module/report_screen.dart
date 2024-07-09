import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ReportScreen extends GetView<ReportController> {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: SafeArea(
        child: GetBuilder<ReportController>(
          init: ReportController(),
          builder: (controller) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(4),
                horizontal: getProportionateScreenWidth(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(24),
                      vertical: getProportionateScreenHeight(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.report,
                          style: TextStyle(
                            fontSize: getProportionalFontSize(32),
                            color: themeProvider.textThemeColor,
                            fontFamily: AppFonts.sansFont600,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.reportYourCase,
                          style: TextStyle(
                            fontSize: getProportionalFontSize(16),
                            color: themeProvider.lightTextThemeColor,
                            fontFamily: AppFonts.sansFont400,
                          ),
                        ),
                      ],
                    ),
                  ),
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

                            ///TODO
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
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.emergencyServices,
                      style: TextStyle(
                        fontSize: getProportionalFontSize(16),
                        fontFamily: AppFonts.sansFont700,
                        color: themeProvider.textThemeColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SUBMIT_REPORT);
                    },
                    child: Container(
                      width: SizeConfig.deviceWidth,
                      height: getProportionateScreenHeight(320),
                      margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                        vertical: getProportionateScreenHeight(8),
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: AppColors.redDefault, shape: BoxShape.circle),
                      child: Text(
                        AppLocalizations.of(context)!.pressButtonToSendSOS,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(16),
                          fontFamily: AppFonts.sansFont400,
                          color: themeProvider.textThemeColor,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.or,
                      style: TextStyle(
                        fontSize: getProportionalFontSize(16),
                        fontFamily: AppFonts.sansFont500,
                        color: themeProvider.textThemeColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(16),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(16),
                      horizontal: getProportionateScreenWidth(16),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(.30),
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: getProportionateScreenHeight(50),
                          width: getProportionateScreenWidth(50),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.policeReport),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(14),
                        ),
                        Text(
                          "Police Report",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: getProportionalFontSize(16),
                            fontFamily: AppFonts.sansFont400,
                            color: themeProvider.textThemeColor,
                          ),
                        ),
                        Spacer(),
                        CommonButton(
                          width: getProportionateScreenWidth(70),
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(8),
                            vertical: getProportionateScreenHeight(8),
                          ),
                          radius: 50,
                          onPressed: () {
                            Get.toNamed(Routes.SUBMIT_REPORT);
                          },
                          text: AppLocalizations.of(context)!.submit,
                          textStyle: TextStyle(
                            fontSize: getProportionalFontSize(12),
                            fontFamily: AppFonts.sansFont700,
                            color: AppColors.whiteColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(22),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(16),
                      horizontal: getProportionateScreenWidth(16),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(.30),
                      borderRadius: BorderRadius.circular(
                        getProportionateScreenWidth(15),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: getProportionateScreenHeight(50),
                          width: getProportionateScreenWidth(50),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.policeReport),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(14),
                        ),
                        Text(
                          "Report Missing Person",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: getProportionalFontSize(16),
                            fontFamily: AppFonts.sansFont400,
                            color: themeProvider.textThemeColor,
                          ),
                        ),
                        Spacer(),
                        CommonButton(
                          width: getProportionateScreenWidth(70),
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(8),
                            vertical: getProportionateScreenHeight(8),
                          ),
                          text: "Submit",
                          radius: 50,
                          onPressed: () {
                            Get.toNamed(Routes.SUBMIT_REPORT);
                          },
                          textStyle: TextStyle(
                            fontSize: getProportionalFontSize(12),
                            fontFamily: AppFonts.sansFont700,
                            color: AppColors.whiteColor,
                          ),
                        )
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
