import 'dart:async';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:distress_app/infrastructure/models/police_dashboard_model.dart';
import 'package:distress_app/packages/advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Location;

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
    saveFCMToken();
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
      Utils.showToast('Location services are disabled. Please enable location service to receive SOS request');
      bool enabled = await Location.Location().requestService();
      if (enabled == true) {
        getCurrentLocation();
      } else {
        return Future.error('Location services are disabled.');
      }
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Utils.showToast('Location permission is disabled. Please enable location permission to receive SOS request');
        Utils.showAlertDialog(
          context: navState.currentContext!,
          bar: true,
          title: AppLocalizations.of(Get.context!)!.alert,
          description: AppLocalizations.of(Get.context!)!.theLocationServiceIsRequiredToReceiveSOS,
          buttons: [
            TextButton(
              onPressed: () async {
                Get.back();
              },
              child: Text(
                AppLocalizations.of(Get.context!)!.pauseNewRequestsForNow,
              ),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                getCurrentLocation();
              },
              child: Text(
                AppLocalizations.of(Get.context!)!.retry,
              ),
            ),
          ],
        );
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Utils.showAlertDialog(
        context: navState.currentContext!,
        bar: true,
        title: AppLocalizations.of(navState.currentContext!)!.permissionRequired,
        description: AppLocalizations.of(navState.currentContext!)!.toAccessYourCurrentLocation,
        buttons: [
          TextButton(
            onPressed: () async {
              Get.back();
            },
            child: Text(
              AppLocalizations.of(navState.currentContext!)!.cancel,
            ),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              await Geolocator.openAppSettings();
              Future.delayed(const Duration(seconds: 1)).then((value) {
                getCurrentLocation();
              });
            },
            child: Text(
              AppLocalizations.of(Get.context!)!.openSetting,
            ),
          ),
        ],
      );
      // return Future.error('Location permissions are permanently denied, we cannot request permissions.');
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
