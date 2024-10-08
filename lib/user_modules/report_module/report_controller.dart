import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:distress_app/packages/location_geocoder/location_geocoder.dart';
import 'package:distress_app/user_modules/home_module/place_auto_complete_response.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as Location;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../home_module/place_auto_complete.dart';

class ReportController extends GetxController {
  ///TODO Static/Dynamic
  List<String> reportType = [
    'Police Report',
    'Missing Person',
  ];

  String reportTypeValue = 'Missing Person';

  bool alertFriendsValue = false;
  bool reportAnonymouslyValue = false;

  bool speakToProfessional = false;
  final record = AudioRecorder();
  bool isRecording = false;
  Timer? timer;
  int recordTime = 0;

  List<File> pickedFiles = [];

  TextEditingController informationController = TextEditingController();

  GlobalKey<FormState> reportFormKey = GlobalKey<FormState>();

  @override
  void onReady() {
    super.onReady();
  }

  void switchAddFriendsValue(bool value) {
    alertFriendsValue = value;
    update();
  }

  void switchReportAnonymouslyValue(bool value) {
    reportAnonymouslyValue = value;
    update();
  }

  void checkSpeakToProfessional(bool value) {
    speakToProfessional = value;
    update();
  }

  Future<void> pickFiles() async {
    if (Platform.isIOS) {
      ImagePicker imagePicker = ImagePicker();
      List<XFile> result = await imagePicker.pickMultipleMedia();

      if (result.isNotEmpty) {
        List<File> files = result.map((file) => File(file.path)).toList();
        pickedFiles.addAll(files);
      } else {
        // Utils.showToast("message")
        // User canceled the picker
      }
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: [
          //image
          'jpeg',
          'jpg',
          'png',
          'heic',

          //video
          'avi',
          'mkv',
          'mov',
          'mp4',
          'mpeg',
          'webm',
          'wmv',

          //audio
          'mp3',
          'm4a',
          'aac',
        ],
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        pickedFiles.addAll(files);
      } else {
        // Utils.showToast("message")
        // User canceled the picker
      }
    }
    update();
  }

  String informationText = '';

  void submitReport() async {
    LoadingDialog.showLoader();
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "type": reportTypeValue,
        "alert_friends": alertFriendsValue == true ? 1 : 0,
        "report_annonymously": reportAnonymouslyValue == true ? 1 : 0,
        "speak_to_professional": speakToProfessional == true ? 1 : 0,
        "information": informationText,
        "city": submitCity,
        "location": submitSearchLocationController.text,
        "latitude": submitLatitude,
        "longitude": submitLongitude,
      });

      if (pickedFiles.isNotEmpty) {
        for (int i = 0; i < pickedFiles.length; i++) {
          formData.files.add(
            MapEntry('file[${i}]', await Dio.MultipartFile.fromFile(pickedFiles[i].path, filename: pickedFiles[i].path.split('/').last)),
          );
        }
      }
      var response = await ApiProvider().postAPICall(
        Endpoints.sendNonEmergency,
        formData,
        onSendProgress: (count, total) {},
      );
      LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        Utils.showToast(response['message'] ?? 'Report submitted successfully.');
        Get.back();
        clearData();
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

  void clearData() {
    informationController.clear();
    informationText = '';
    pickedFiles.clear();
    alertFriendsValue = false;
    reportAnonymouslyValue = false;
    speakToProfessional = false;
    reportTypeValue = reportType.first;
    submitLatitude = null;
    submitLongitude = null;
    submitSearchLocationController.clear();
    submitCity = null;
  }

  bool dialogIsOpen = false;

  TextEditingController searchLocationController = TextEditingController();
  double? latitude;
  double? longitude;
  String? city;

  TextEditingController submitSearchLocationController = TextEditingController();
  double? submitLatitude;
  double? submitLongitude;
  String? submitCity;

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
        Get.find<HomeController>().getUserSosEmergencyCase(showLoader: false, search: '');
        // Get.find<HomeController>().sendSms(message: 'SOS at ${_address?.featureName}, ${_address?.postalCode}');
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
                        Row(
                          children: [
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
                                      50,
                                    ),
                                    border: Border.all(color: AppColors.blackColor, width: 1),
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.undo,
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
                            SizedBox(
                              width: getProportionateScreenWidth(18),
                            ),
                            Expanded(
                              child: CommonButton(
                                text: AppLocalizations.of(context)!.sendNow,
                                onPressed: () {
                                  Get.back();
                                  sendSOSEmergency(context);
                                },
                                radius: 50,
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
                        AppLocalizations.of(context)!.emergencyRequestSent,
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
                        AppLocalizations.of(context)!.yourSOSHasBeenSent,
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

  Address? _address;

  Future<void> getCurrentLocation() async {
    FocusManager.instance.primaryFocus?.unfocus();
    Position currentPosition = await determineCurrentPosition();

    print("${currentPosition.latitude} ${currentPosition.longitude}");
    var address = await LocatitonGeocoder(Constants.kGoogleApiKey, lang: 'en').findAddressesFromCoordinates(
      Coordinates(currentPosition.latitude, currentPosition.longitude),
    );
    _address = address.first;
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
          description: AppLocalizations.of(Get.context!)!.theLocationServiceIsRequired,
          buttons: [
            TextButton(
              onPressed: () async {
                Get.back();
              },
              child: Text(
                AppLocalizations.of(Get.context!)!.noEmergenciesAtTheMoment,
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
        title: AppLocalizations.of(Get.context!)!.permissionRequired,
        description: AppLocalizations.of(Get.context!)!.locationPermissionRequiredSOS,
        buttons: [
          TextButton(
            onPressed: () async {
              Get.back();
            },
            child: Text('Cancel'),
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

  startRecording() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.microphone,
    ].request();

    bool permissionsGranted = permissions[Permission.microphone]!.isGranted;

    if (permissionsGranted) {
      Directory directory = await getTemporaryDirectory();

      String imagePath = '';
      if ((await directory.exists())) {
        imagePath = File("${directory.path}/Rec_${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.m4a").path;
      } else {
        await directory.create(recursive: true);
        imagePath = File("${directory.path}/Rec_${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.m4a").path;
      }

      print(imagePath);

      const config = RecordConfig();

      await record.start(config, path: imagePath);
      isRecording = true;
      startTimer();
      update();
    } else {
      Utils.showAlertDialog(
        context: navState.currentContext!,
        bar: true,
        title: AppLocalizations.of(Get.context!)!.permissionRequired,
        description: AppLocalizations.of(Get.context!)!.micPermissionRequired,
        buttons: [
          TextButton(
            onPressed: () {
              Get.back();
              openAppSettings();
            },
            child: Text(
              AppLocalizations.of(Get.context!)!.openSetting,
            ),
          ),
        ],
      );
    }
  }

  void stopRecording() async {
    String? path = await record.stop();
    isRecording = false;
    stopTimer();
    if (path != null && path.isNotEmpty) {
      pickedFiles.add(File(path));
    }
    update();
    print('Output path $path');
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      recordTime++;
      update();
    });
  }

  void stopTimer() {
    timer?.cancel();
    recordTime = 0;
    update();
  }

  String getFormattedTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }
}
