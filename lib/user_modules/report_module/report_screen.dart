import 'dart:ui';

import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../packages/location_geocoder/location_geocoder.dart';
import '../home_module/place_auto_complete.dart';
import '../home_module/place_auto_complete_response.dart';

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
          initState: (state) {
            controller.getCurrentLocation();
          },
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
                          controller: controller.searchLocationController,
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont500,
                            fontSize: getProportionalFontSize(16),
                            color: AppColors.blackColor,
                          ),
                          readOnly: true,
                          onTap: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PlaceAutoCompleteScreen(),
                                ));

                            if (result is GoogleMapPlaceModel) {
                              controller.searchLocationController.text = result.description ?? '';

                              if (controller.searchLocationController.text.isNotEmpty) {
                                var address =
                                    await LocatitonGeocoder(Constants.kGoogleApiKey, lang: 'en').findAddressesFromQuery(
                                  controller.searchLocationController.text,
                                );
                                // var initialLatLong = LatLng(
                                //     address.first.coordinates.latitude ?? 0, address.first.coordinates.longitude ?? 0);
                                controller.city = address.first.locality;
                                controller.latitude = address.first.coordinates.latitude;
                                controller.longitude = address.first.coordinates.longitude;
                              }
                            } else if (result is Address) {
                              var address = result as Address;
                              controller.searchLocationController.text = address.addressLine ?? '';
                              controller.city = address.locality;
                              controller.latitude = address.coordinates.latitude;
                              controller.longitude = address.coordinates.longitude;
                            }
                            controller.update();
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),

                            ///TODO text change
                            hintText: AppLocalizations.of(context)!.searchLocation,
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
                      ),
                      // Expanded(
                      //   child: TextFormField(
                      //     style: TextStyle(
                      //       fontFamily: AppFonts.sansFont500,
                      //       fontSize: getProportionalFontSize(16),
                      //       color: AppColors.blackColor,
                      //     ),
                      //     autovalidateMode: AutovalidateMode.onUserInteraction,
                      //     decoration: InputDecoration(
                      //       border: UnderlineInputBorder(),
                      //
                      //       ///TODO
                      //       hintText: AppLocalizations.of(context)!.searchLocation,
                      //       hintStyle: TextStyle(
                      //         fontFamily: AppFonts.sansFont400,
                      //         fontSize: getProportionalFontSize(14),
                      //         color: AppColors.textFieldGreyColor,
                      //       ),
                      //       errorStyle: TextStyle(
                      //         fontSize: getProportionalFontSize(12),
                      //         fontFamily: AppFonts.sansFont400,
                      //         color: AppColors.redDefault,
                      //       ),
                      //     ),
                      //   ),
                      // )
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
                      if (controller.searchLocationController.text.isNotEmpty &&
                          controller.latitude != null &&
                          controller.longitude != null &&
                          controller.city != null) {
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
                                child: GetBuilder<ReportController>(
                                  builder: (controller) {
                                    return Container(
                                      width: SizeConfig.deviceWidth! * .85,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: getProportionateScreenWidth(16),
                                        vertical: getProportionateScreenHeight(16),
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
                                          Text(
                                            AppLocalizations.of(context)!.confirmationMessage,
                                            style: TextStyle(
                                                fontFamily: AppFonts.sansFont700,
                                                fontSize: getProportionalFontSize(22),
                                                color: AppColors.primaryColor),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: getProportionateScreenHeight(10),
                                          ),
                                          Text(
                                            "You are about to send an SOS. Are you sure you want to proceed?",
                                            style: TextStyle(
                                                fontFamily: AppFonts.sansFont500,
                                                fontSize: getProportionalFontSize(16),
                                                color: AppColors.blackColor),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: getProportionateScreenHeight(24),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: CommonButton(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: getProportionateScreenWidth(24),
                                                    vertical: getProportionateScreenHeight(18),
                                                  ),
                                                  text: AppLocalizations.of(context)!.yes,
                                                  onPressed: () async {
                                                    Get.back();
                                                    controller.sosEmergencySuccess(context);
                                                  },
                                                  radius: 50,
                                                ),
                                              ),
                                              SizedBox(
                                                width: getProportionateScreenWidth(18),
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  behavior: HitTestBehavior.opaque,
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: getProportionateScreenWidth(24),
                                                      vertical: getProportionateScreenHeight(17),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(
                                                        getProportionateScreenWidth(50),
                                                      ),
                                                      border: Border.all(color: AppColors.blackColor, width: 1),
                                                    ),
                                                    child: Text(
                                                      AppLocalizations.of(context)!.no,
                                                      textAlign: TextAlign.center,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: getProportionalFontSize(16),
                                                        fontFamily: AppFonts.sansFont600,
                                                        color: AppColors.primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        Utils.showAlertDialog(
                          context: navState.currentContext!,
                          bar: true,
                          title: "Location required",
                          description: "To send SOS, we require the location. Select location options.",
                          buttons: [
                            TextButton(
                              onPressed: () {
                                controller.addLocationManually(context);
                              },
                              child: Text('Add manually'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Get.back();
                                await controller.getCurrentLocation();

                                Get.back();
                              },
                              child: Text('My Location'),
                            ),
                          ],
                        );
                      }
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
                            controller.reportTypeValue = controller.reportType.first;
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
                          text: AppLocalizations.of(context)!.submit,
                          radius: 50,
                          onPressed: () {
                            controller.reportTypeValue = controller.reportType.last;
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
