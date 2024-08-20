import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:distress_app/infrastructure/models/police_dashboard_model.dart';
import 'package:distress_app/packages/advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../packages/location_geocoder/location_geocoder.dart';

class PoliceDashBoardController extends GetxController with GetSingleTickerProviderStateMixin {
  bool canPop = false;
  DateTime? currentBackPressTime;
  AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();
  late AnimationController animationController;
  TextEditingController respondedEventController = TextEditingController();
  bool sosRequestAccept = false;
  PoliceDashboardModel policeDashboardModel = PoliceDashboardModel();

  Completer<GoogleMapController> googleMapControllerCompleter = Completer();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    getPoliceDashboard();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );

    getCurrentLocation();
    super.onInit();
  }

  void getPoliceDashboard() async {
    // LoadingDialog.showLoader();

    try {
      var response = await ApiProvider().getAPICall(
        Endpoints.getPoliceDashboard,
        passToken: true,
      );
      // LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null) {
          policeDashboardModel = PoliceDashboardModel.fromJson(response['data']);
        }
      }
      update();
    } on Dio.DioException catch (e) {
      // LoadingDialog.hideLoader();
      Utils.showToast(e.message ?? "Something went wrong");
      Get.back();
      update();
      debugPrint(e.toString());
    } catch (e) {
      // LoadingDialog.hideLoader();
      Utils.showToast("Something went wrong");
      Get.back();

      update();
      debugPrint(e.toString());
    }
  }

  Future<Position> determineCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Utils.showAlertDialog(
        context: navState.currentContext!,
        bar: true,
        title: "Permission required",
        description: "To access your current location, we require the location permission.",
        buttons: [
          TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: Text('Open setting'),
          ),
        ],
      );
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  Future<void> getCurrentLocation() async {
    FocusManager.instance.primaryFocus?.unfocus();
    Position currentPosition = await determineCurrentPosition();

    print("${currentPosition.latitude} ${currentPosition.longitude}");
    var address = await LocatitonGeocoder(Constants.kGoogleApiKey, lang: 'en').findAddressesFromCoordinates(
      Coordinates(currentPosition.latitude, currentPosition.longitude),
    );

    var location = address.first.addressLine ?? '';
    var latitude = address.first.coordinates.latitude;
    var longitude = address.first.coordinates.longitude;
    var city = address.first.locality ?? "";
    if (latitude != null && longitude != null) {
      updateAddress(city, location, latitude, longitude);
    }

    update();
  }

  void updateAddress(String city, String location, double latitude, double longitude) async {
    // LoadingDialog.showLoader();
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "city": city,
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.saveAddress,
        formData,
        onSendProgress: (count, total) {},
      );
      // LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {}
    } on Dio.DioException catch (e) {
      // LoadingDialog.hideLoader();
      // Utils.showToast(e.message ?? "Something went wrong");
      // update();
      debugPrint(e.toString());
    } catch (e) {
      // LoadingDialog.hideLoader();
      // Utils.showToast("Something went wrong");
      // update();
      debugPrint(e.toString());
    }
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

  String firstName = '';
  String profileImage = '';
  String status = 'Unavailable';

  Future<void> getUserName() async {
    firstName = await StorageService().readSecureData(Constants.firstName) ?? '';
    profileImage = await StorageService().readSecureData(Constants.profileImage) ?? '';
    status = await StorageService().readSecureData(Constants.availability) ?? 'Unavailable';

    Get.find<PoliceSettingController>().availability = status == 'Available';
    // Get.find<PoliceSettingController>().getUserProfile(showLoader: false);
    update();
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
                    AppLocalizations.of(context)!.youHaveDeclinedSosRequest,
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

  void saveFCMToken() async {
    String? accessToken = await StorageService().readSecureData(Constants.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      // LoadingDialog.showLoader();
      try {
        Dio.FormData formData = Dio.FormData.fromMap({
          "fcm_token": FirebaseMessages().fcmToken,
        });
        var response = await ApiProvider().postAPICall(
          Endpoints.saveFCMToken,
          formData,
          onSendProgress: (count, total) {},
        );
        // LoadingDialog.hideLoader();
      } on Dio.DioException catch (e) {
        debugPrint(e.toString());
        // LoadingDialog.hideLoader();
      } catch (e) {
        debugPrint(e.toString());
        // LoadingDialog.hideLoader();
      }
    }
  }
}
