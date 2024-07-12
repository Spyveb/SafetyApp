import 'dart:async';

import 'package:distress_app/imports.dart';
import 'package:distress_app/packages/advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PoliceDashBoardController extends GetxController with GetSingleTickerProviderStateMixin {
  bool canPop = false;
  DateTime? currentBackPressTime;
  AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();
  late AnimationController animationController;
  TextEditingController respondedEventController = TextEditingController();
  bool sosRequestAccept = false;

  Completer<GoogleMapController> googleMapControllerCompleter = Completer();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
    super.onInit();
  }

  showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.policeDarkBlueColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sosRequest,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont600,
                      fontSize: getProportionalFontSize(30),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.requester,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Anne Krane",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.location,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "1 Wanaheda Road, Windhoek",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.mobileNumber,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "08114317821",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.emergencyEvent,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Live emergency",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                            color: AppColors.redDefault,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.estimatedTimeOfArrival,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(16),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "3 minutes",
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              sosRequestAccept = true;
                              update();
                              Get.back();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.policeDarkBlueColor,
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(30),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(30),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.accept,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getProportionalFontSize(18),
                                    fontFamily: AppFonts.sansFont600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(30),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              showRequestDeclineDialog(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.redDefault,
                                borderRadius: BorderRadius.circular(
                                  getProportionateScreenWidth(30),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(30),
                                vertical: getProportionateScreenHeight(15),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context)!.decline,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: getProportionalFontSize(18),
                                    fontFamily: AppFonts.sansFont600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showEndSosDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.policeDarkBlueColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.whatHappenedThisEvent,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont600,
                      fontSize: getProportionalFontSize(16),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  TextFormField(
                    maxLines: null,
                    maxLength: 300,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(8),
                        vertical: getProportionateScreenHeight(8),
                      ),
                      constraints: BoxConstraints(
                        maxHeight: getProportionateScreenHeight(100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  GestureDetector(
                    onTap: () {
                      sosRequestAccept = false;
                      update();
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.redDefault,
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(30),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30),
                        vertical: getProportionateScreenHeight(15),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.submit,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionalFontSize(18),
                            fontFamily: AppFonts.sansFont600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showBackupRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.policeDarkBlueColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.backupRequestSent,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont600,
                      fontSize: getProportionalFontSize(24),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    AppLocalizations.of(context)!.aBackupSentYourDestination,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont500,
                      fontSize: getProportionalFontSize(16),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.policeDarkBlueColor,
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(30),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30),
                        vertical: getProportionateScreenHeight(15),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.ok,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionalFontSize(18),
                            fontFamily: AppFonts.sansFont600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showRequestDeclineDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: AppColors.policeDarkBlueColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sosRequest,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont600,
                      fontSize: getProportionalFontSize(24),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(15),
                  ),
                  Text(
                    "You have declined the SOS Request. The request will be sent to another officer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppFonts.sansFont500,
                      fontSize: getProportionalFontSize(16),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(25),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.policeDarkBlueColor,
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(30),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(30),
                        vertical: getProportionateScreenHeight(15),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.ok,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: getProportionalFontSize(18),
                            fontFamily: AppFonts.sansFont600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
