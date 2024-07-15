import 'dart:async';
import 'dart:ui';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:distress_app/packages/location_geocoder/location_geocoder.dart';
import 'package:distress_app/user_modules/home_module/place_auto_complete.dart';
import 'package:distress_app/user_modules/home_module/place_auto_complete_response.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  bool dialogIsOpen = false;

  TextEditingController searchLocationController = TextEditingController();
  double? latitude;
  double? longitude;
  String? city;

  @override
  void onReady() {
    super.onReady();
  }

  void sendSOSEmergency(context) async {
    LoadingDialog.showLoader();
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "city": city,
        "location": searchLocationController.text,
        "latitude": latitude,
        "longitude": longitude,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.sendSOSEmergency,
        formData,
        onSendProgress: (count, total) {},
      );
      LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        sosEmergencyRequestSuccess(context);
        Utils.showToast(response['message'] ?? 'SOS emergency case created successfully.');
      } else {
        Utils.showToast(response['message'] ?? "You can't create new report. Your one emergency report case is open.");
      }
      update();
    } on Dio.DioException catch (e) {
      LoadingDialog.hideLoader();
      Utils.showToast(e.message ?? "Something went wrong");
      update();
      debugPrint(e.toString());
    } catch (e) {
      LoadingDialog.hideLoader();
      Utils.showToast("Something went wrong");
      update();
      debugPrint(e.toString());
    }
  }

  sosEmergencySuccess(BuildContext context) {
    dialogIsOpen = true;
    update();
    Timer timer = Timer(Duration(seconds: 5), () {
      if (dialogIsOpen) {
        Get.back();
        sendSOSEmergency(context);
      }
    });

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
                    width: SizeConfig.deviceWidth! * .9,
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(8),
                      vertical: getProportionateScreenHeight(18),
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
                        Container(
                          height: getProportionateScreenHeight(171),
                          width: getProportionateScreenWidth(151),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImages.time),
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.thankYouForReporting,
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont600,
                            fontSize: getProportionalFontSize(20),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text(
                          AppLocalizations.of(context)!.youCanUndoThisReportWithin5Seconds,
                          style: TextStyle(
                            fontFamily: AppFonts.sansFont400,
                            fontSize: getProportionalFontSize(16),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(28),
                        ),
                        CommonButton(
                          width: getProportionateScreenWidth(196),
                          text: AppLocalizations.of(context)!.undo,
                          onPressed: () {
                            Get.back();
                          },
                          radius: 50,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        onPop: () {
          timer.cancel();
          dialogIsOpen = false;
          update();
        },
        barrierDismissible: false);
  }

  sosEmergencyRequestSuccess(BuildContext context) {
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
                  width: SizeConfig.deviceWidth! * .9,
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(8),
                    vertical: getProportionateScreenHeight(18),
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
                      Container(
                        height: getProportionateScreenHeight(172),
                        width: getProportionateScreenWidth(220),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.hotspot),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text(
                        "EMERGENCY REQUEST SENT",
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(20),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text(
                        "Your SOS message has been sent. Help is on the way. Stay safe and keep your phone nearby.",
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont400,
                          fontSize: getProportionalFontSize(16),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(28),
                      ),
                      CommonButton(
                        width: getProportionateScreenWidth(196),
                        text: AppLocalizations.of(context)!.done,
                        onPressed: () {
                          Get.back();
                        },
                        radius: 50,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> getCurrentLocation() async {
    FocusManager.instance.primaryFocus?.unfocus();
    Position currentPosition = await determineCurrentPosition();

    print("${currentPosition.latitude} ${currentPosition.longitude}");
    var address = await LocatitonGeocoder(Constants.kGoogleApiKey, lang: 'en').findAddressesFromCoordinates(
      Coordinates(currentPosition.latitude, currentPosition.longitude),
    );

    searchLocationController.text = address.first.addressLine ?? '';
    latitude = address.first.coordinates.latitude;
    longitude = address.first.coordinates.longitude;
    city = address.first.locality;
    update();
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
        description: "To send SOS of your current location, we require the location permission.",
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

  Future<void> addLocationManually(BuildContext context) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PlaceAutoCompleteScreen(),
        ));

    if (result is GoogleMapPlaceModel) {
      searchLocationController.text = result.description ?? '';

      if (searchLocationController.text.isNotEmpty) {
        var address = await LocatitonGeocoder(Constants.kGoogleApiKey, lang: 'en').findAddressesFromQuery(
          searchLocationController.text,
        );
        // var initialLatLong = LatLng(
        //     address.first.coordinates.latitude ?? 0, address.first.coordinates.longitude ?? 0);
        city = address.first.locality;
        latitude = address.first.coordinates.latitude;
        longitude = address.first.coordinates.longitude;
      }
      Get.back();
      update();
    }
  }

  String firstName = '';
  Future<void> getUserName() async {
    firstName = await StorageService().readSecureData(Constants.firstName) ?? '';
    update();
  }
}
