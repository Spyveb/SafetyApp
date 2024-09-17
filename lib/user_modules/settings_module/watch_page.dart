import 'dart:ui';

import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:qr_mobile_vision/qr_mobile_vision.dart';

class WatchPage extends GetView<SettingsController> {
  const WatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
    );
    return GetBuilder<SettingsController>(
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          controller.checkWatchData();
          controller.initPlatformState();
        });
      },
      dispose: (state) {
        QrMobileVision.stop();
        controller.scannedQrCode = null;
      },
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.transparent,
            title: Text(
              'My Watch',
              style: TextStyle(
                fontSize: getProportionalFontSize(22),
                color: themeProvider.textThemeColor,
                fontFamily: AppFonts.sansFont600,
              ),
            ),
          ),
          body: SafeArea(
            child: BackgroundWidget(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    controller.watchHasUserData
                        ? Column(
                            children: [
                              SizedBox(
                                height: getProportionateScreenHeight(48),
                              ),
                              SvgPicture.asset(
                                AppImages.watchConnected,
                                height: getProportionateScreenHeight(100),
                                width: getProportionateScreenWidth(100),
                              ),
                              Text(
                                "Connected",
                                style: TextStyle(
                                  fontFamily: AppFonts.sansFont500,
                                  fontSize: getProportionalFontSize(16),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(16),
                              ),
                              TextButton(
                                onPressed: () async {
                                  // if (controller.supported && controller.paired && controller.reachable) {
                                  //   print("object");
                                  // }

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
                                          child: GetBuilder<SettingsController>(
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
                                                      "Are you sure you want to remove the watch?",
                                                      style: TextStyle(
                                                          fontFamily: AppFonts.sansFont500, fontSize: getProportionalFontSize(16), color: AppColors.blackColor),
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
                                                              if (await controller.watch.isReachable) {
                                                                controller.watch.sendMessage({"remove_device": true});
                                                              }
                                                              await StorageService().writeSecureData(Constants.watchHasData, null);
                                                              controller.checkWatchData();
                                                              controller.initPlatformState();
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
                                },
                                child: Text(
                                  "Remove Device",
                                  style: TextStyle(
                                    fontFamily: AppFonts.sansFont500,
                                    fontSize: getProportionalFontSize(14),
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                controller.supported
                                    ? controller.paired && controller.reachable
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: getProportionateScreenHeight(64),
                                              ),
                                              Container(
                                                height: getProportionateScreenHeight(250),
                                                width: getProportionateScreenWidth(250),
                                                child: controller.scannedQrCode != null && controller.scannedQrCode!.isNotEmpty
                                                    ? Center(
                                                        child: CircularProgressIndicator(),
                                                      )
                                                    : QrCamera(
                                                        qrCodeCallback: (value) {
                                                          print(value);
                                                          controller.scannedQrCode = value;
                                                          controller.update();
                                                          controller.sendMessage(data: {'qr_data': controller.scannedQrCode});
                                                        },
                                                      ),
                                              ),
                                              SizedBox(
                                                height: getProportionateScreenHeight(18),
                                              ),
                                              Text(
                                                "Scan QR code in the 'Distress Watch App'",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: AppFonts.sansFont400,
                                                  fontSize: getProportionalFontSize(14),
                                                ),
                                              ),
                                              instructionView(),
                                            ],
                                          )
                                        : instructionView()
                                    : Text(
                                        "Watch OS does not support'",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppFonts.sansFont400,
                                          fontSize: getProportionalFontSize(14),
                                        ),
                                      ),
                                Spacer(),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    controller.initPlatformState();
                                  },
                                  label: Text(
                                    "Refresh",
                                    style: TextStyle(
                                      fontFamily: AppFonts.sansFont500,
                                      fontSize: getProportionalFontSize(14),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.refresh,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenHeight(8),
                                    horizontal: getProportionateScreenWidth(16),
                                  ),
                                  child: Text(
                                    "Please do not close this page while connecting the watch.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppFonts.sansFont400,
                                      fontSize: getProportionalFontSize(14),
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
          ),
        );
      },
    );
  }

  Container instructionView() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(16),
        horizontal: getProportionateScreenWidth(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instruction :",
            style: TextStyle(
              fontFamily: AppFonts.sansFont500,
              fontSize: getProportionalFontSize(16),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(8),
          ),
          Text(
            "1. Make sure your watch app is connected and paired with your phone",
            style: TextStyle(
              fontFamily: AppFonts.sansFont400,
              fontSize: getProportionalFontSize(14),
            ),
          ),
          Text(
            "2. Make sure 'Distress Watch App' is open",
            style: TextStyle(
              fontFamily: AppFonts.sansFont400,
              fontSize: getProportionalFontSize(14),
            ),
          ),
          // Text(
          //   "2. Make sure 'Safety Watch App' is open",
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}
