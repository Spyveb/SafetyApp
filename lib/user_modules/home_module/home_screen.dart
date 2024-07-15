import 'dart:ui';

import 'package:distress_app/imports.dart';
import 'package:distress_app/packages/location_geocoder/location_geocoder.dart';
import 'package:distress_app/user_modules/home_module/place_auto_complete.dart';
import 'package:distress_app/user_modules/home_module/place_auto_complete_response.dart';
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
          initState: (state) {
            controller.getCurrentLocation();
            controller.getUserName();
          },
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
                            "${AppLocalizations.of(context)!.welcome}, ${controller.firstName}",
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
                                child: GetBuilder<HomeController>(
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
