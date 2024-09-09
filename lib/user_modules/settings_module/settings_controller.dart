import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

class SettingsController extends GetxController {
  bool reportAnonymously = false;

  void switchReportAnonymously(bool value) {
    reportAnonymously = value;
    update();

    saveSettings();
  }

  GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController changeConfirmPasswordController = TextEditingController();

  bool newPasswordObscure = true;
  bool confirmPasswordObscure = true;
  bool currentPasswordObscure = true;

  List<LanguageModel> languages = [
    LanguageModel(languageName: "English", languageCode: "en", imageUrl: AppImages.usLanguage),
    LanguageModel(languageName: "Dutch", languageCode: "de", imageUrl: AppImages.germanyLanguage),
    LanguageModel(languageName: "French", languageCode: "fr", imageUrl: AppImages.frenchLanguage),
    LanguageModel(languageName: "Afrikaans", languageCode: "af", imageUrl: AppImages.namibiaLanguage),
  ];

  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  @override
  void onReady() {
    getCurrentLanguage();
    super.onReady();
  }

  Locale? locale;

  void getCurrentLanguage() async {
    String? lang = await StorageService().readSecureData(Constants.language);

    if (lang != null) {
      if (lang == Constants.afLanguage) {
        locale = Locale(Constants.afLanguage, "NA");
      } else if (lang == Constants.deLanguage) {
        locale = Locale(Constants.deLanguage, "DE");
      } else if (lang == Constants.enLanguage) {
        locale = Locale(Constants.enLanguage, "US");
      } else if (lang == Constants.frLanguage) {
        locale = Locale(Constants.frLanguage, "FR");
      }
    } else {
      locale = Locale(Constants.enLanguage, "US");
    }

    update();
  }

  Future<void> updateLanguage(LanguageModel languageModel, BuildContext context) async {
    if (languageModel.languageCode == Constants.afLanguage) {
      locale = Locale(Constants.afLanguage, "NA");
    } else if (languageModel.languageCode == Constants.deLanguage) {
      locale = Locale(Constants.deLanguage, "DE");
    } else if (languageModel.languageCode == Constants.enLanguage) {
      locale = Locale(Constants.enLanguage, "US");
    } else if (languageModel.languageCode == Constants.frLanguage) {
      locale = Locale(Constants.frLanguage, "FR");
    }
    MyApp.setLocale(
      context,
      locale ?? Locale(Constants.enLanguage, 'US'),
    );
    await StorageService().writeSecureData(Constants.language, locale != null ? locale!.languageCode : Constants.enLanguage);
    update();
  }

  void selectContact() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      Contact? contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        contactNameController.text = contact.displayName;
        // contactNumberController.text = contact.phones.map((e) => e.number).toString();
        contactNumberController.text = contact.phones.first.number.toString();
        update();
      }
    }
  }

  //Edit profile

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isObscure = true;
  bool isObscureConfirm = true;
  CountryCode selectedCountryCode = CountryCode(dialCode: '+93');

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? selectedImage;
  String? profileImage;

  void getUserProfile({bool? showLoader = true}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.getProfile,
        null,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null) {
          if (response['data']['user'] != null) {
            UserModel userModel = UserModel.fromJson(response['data']['user']);
            await assignUserData(userModel);
          }
        }
      }
      update();
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      update();
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      update();
      debugPrint(e.toString());
    }
  }

  Future<void> assignUserData(UserModel userModel) async {
    profileImage = null;
    selectedImage = null;
    firstNameController.text = userModel.firstName ?? '';
    lastNameController.text = userModel.lastName ?? '';
    emailController.text = userModel.email ?? '';

    phoneNumberController.text = userModel.mobileNumber ?? '';
    selectedCountryCode = CountryCode(dialCode: userModel.mobileCode ?? '+93');
    birthDateController.text = Utils.displayDateFormat(userModel.dob ?? '');
    userNameController.text = userModel.username ?? '';
    profileImage = userModel.profileImage;
    reportAnonymously = userModel.reportAnnonymously == 1;
    update();
  }

  Future<void> saveUserData(UserModel userModel) async {
    await StorageService().writeSecureData(Constants.userId, userModel.id.toString());
    await StorageService().writeSecureData(Constants.userName, userModel.username ?? "");
    await StorageService().writeSecureData(Constants.firstName, userModel.firstName ?? "");
    await StorageService().writeSecureData(Constants.lastName, userModel.lastName ?? "");
    await StorageService().writeSecureData(Constants.profileImage, userModel.profileImage ?? "");
    await StorageService().writeSecureData(Constants.email, userModel.email ?? "");
  }

  void updateUserProfile() async {
    LoadingDialog.showLoader();

    Dio.FormData formData = Dio.FormData.fromMap({
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "mobile_code": selectedCountryCode.dialCode,
      "mobile_number": phoneNumberController.text,
      "dob": Utils.sendDateFormat(birthDateController.text),
      "username": userNameController.text,
    });

    if (selectedImage != null) {
      formData.files.add(
        MapEntry(
          'profile_image',
          await Dio.MultipartFile.fromFile(selectedImage!.path),
        ),
      );
    }
    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.updateProfile,
        formData,
        onSendProgress: (count, total) {},
      );

      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null) {
          if (response['data']['user'] != null) {
            UserModel userModel = UserModel.fromJson(response['data']['user']);
            await saveUserData(userModel);
            LoadingDialog.hideLoader();
            Utils.showToast(response['message'] ?? "User profile updated successfully.");
            Get.back();
            getUserProfile(showLoader: false);
          }
        }
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

  void deleteAccount() async {
    LoadingDialog.showLoader();
    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.deleteAccount,
        null,
        onSendProgress: (count, total) {},
      );

      if (response['success'] != null && response['success'] == true) {
        Utils.showToast(response['message'] ?? "Account deleted successfully.");
        await StorageService().deleteAllSecureData();
        Get.offAllNamed(Routes.SIGN_IN);
      }
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

  changePassword() async {
    LoadingDialog.showLoader();
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "old_password": currentPasswordController.text,
        "password": newPasswordController.text,
      });
      var response = await ApiProvider().postAPICall(
        Endpoints.changePassword,
        formData,
        passToken: true,
        onSendProgress: (count, total) {},
      );

      if (response['success'] != null && response['success'] == true) {
        LoadingDialog.hideLoader();

        Utils.showToast(response['message'] ?? "Password change successfully");
        Get.back();
        currentPasswordController.clear();
        changeConfirmPasswordController.clear();
        newPasswordController.clear();
      } else {
        LoadingDialog.hideLoader();
        Utils.showToast(response['message'] ?? "Change Password Failed");
      }
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

  // Emergency Contacts

  List<EmergencyContactModel> emergencyContactList = [];

  EmergencyContactModel? editContactModel;

  void getEmergencyContactList({bool? showLoader = true}) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.emergencyContactList,
        null,
        onSendProgress: (count, total) {},
      );

      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      if (response['success'] != null && response['success'] == true) {
        emergencyContactList.clear();
        if (response['data'] != null) {
          List list = response['data'];
          if (list.isNotEmpty) {
            for (var contact in list) {
              emergencyContactList.add(
                EmergencyContactModel.fromJson(contact),
              );
            }
          }
        }
      }
      update();
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      update();
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      update();
      debugPrint(e.toString());
    }
  }

  void addEmergencyContact(BuildContext context) async {
    LoadingDialog.showLoader();

    Dio.FormData formData = Dio.FormData.fromMap({
      "name": contactNameController.text,
      "mobile_number": contactNumberController.text,
    });

    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.emergencyContactCreate,
        formData,
        onSendProgress: (count, total) {},
      );
      LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        // Utils.showToast(response['message'] ?? "Emergency contact created successfully.");
        getEmergencyContactList(showLoader: false);

        Utils.showCustomDialog(
          context: context,
          barrierDismissible: false,
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
                child: Container(
                  width: SizeConfig.deviceWidth! * .85,
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(16),
                    vertical: getProportionateScreenHeight(60),
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
                        height: getProportionateScreenHeight(141),
                        width: getProportionateScreenWidth(141),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.registrationSuccess),
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.emergencyContactsAdded,
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
                        AppLocalizations.of(context)!.allEmergencyContacts,
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
                          Get.back();
                        },
                        radius: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        Get.find<HomeController>().getEmergencyContactList(showLoader: false);
      }
      clearData();
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

  void updateEmergencyContact({required int editId}) async {
    LoadingDialog.showLoader();

    Dio.FormData formData = Dio.FormData.fromMap({
      "id": editId,
      "name": contactNameController.text,
      "mobile_number": contactNumberController.text,
    });

    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.emergencyContactUpdate,
        formData,
        onSendProgress: (count, total) {},
      );
      LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        Utils.showToast(response['message'] ?? "Emergency contact updated successfully.");
        getEmergencyContactList(showLoader: false);
        Get.back();
        Get.find<HomeController>().getEmergencyContactList(showLoader: false);
      }
      clearData();
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

  void deleteEmergencyContact({required int deleteId}) async {
    LoadingDialog.showLoader();

    Dio.FormData formData = Dio.FormData.fromMap({
      "id": deleteId,
    });

    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.emergencyContactDelete,
        formData,
        onSendProgress: (count, total) {},
      );
      LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        Utils.showToast(response['message'] ?? "Emergency contact deleted successfully.");
        getEmergencyContactList(showLoader: false);
        Get.find<HomeController>().getEmergencyContactList(showLoader: false);
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
    contactNameController.clear();
    contactNumberController.clear();
  }

  // html screen

  String? title;
  String? data;

  void getTermsAndCondition() async {
    title = null;
    data = null;
    LoadingDialog.showLoader();

    try {
      var response = await ApiProvider().getAPICall(Endpoints.termAndCondition, passToken: true);
      LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null) {
          title = response['data']['title'];
          data = response['data']['description'];
        }
      }
      update();
    } on Dio.DioException catch (e) {
      LoadingDialog.hideLoader();
      Utils.showToast(e.message ?? "Something went wrong");
      Get.back();
      update();
      debugPrint(e.toString());
    } catch (e) {
      LoadingDialog.hideLoader();
      Utils.showToast("Something went wrong");
      Get.back();

      update();
      debugPrint(e.toString());
    }
  }

  void getPrivacyPolicy() async {
    title = null;
    data = null;
    LoadingDialog.showLoader();

    try {
      var response = await ApiProvider().getAPICall(Endpoints.privacyPolicy, passToken: true);
      LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null) {
          title = response['data']['title'];
          data = response['data']['description'];
        }
      }
      update();
    } on Dio.DioException catch (e) {
      LoadingDialog.hideLoader();
      Utils.showToast(e.message ?? "Something went wrong");
      Get.back();
      update();
      debugPrint(e.toString());
    } catch (e) {
      LoadingDialog.hideLoader();
      Utils.showToast("Something went wrong");
      Get.back();

      update();
      debugPrint(e.toString());
    }
  }

  void saveSettings() async {
    // LoadingDialog.showLoader();

    try {
      Dio.FormData formData = Dio.FormData.fromMap({"report_annonymously": reportAnonymously ? 1 : 0});
      var response = await ApiProvider().postAPICall(
        Endpoints.saveSetting,
        formData,
      );
      // LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
      } else {
        reportAnonymously = !reportAnonymously;
      }
      update();
    } on Dio.DioException catch (e) {
      // LoadingDialog.hideLoader();
      Utils.showToast(e.message ?? "Something went wrong");
      reportAnonymously = !reportAnonymously;

      update();
      debugPrint(e.toString());
    } catch (e) {
      // LoadingDialog.hideLoader();
      Utils.showToast("Something went wrong");
      reportAnonymously = !reportAnonymously;

      update();
      debugPrint(e.toString());
    }
  }

  void logoutUser({
    bool? showLoader = true,
  }) async {
    if (showLoader == true) {
      LoadingDialog.showLoader();
    }
    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.logout,
        null,
        onSendProgress: (count, total) {},
      );
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }

      if (response['success'] != null && response['success'] == true) {
        // Utils.showToast(response['message'] ?? 'Logout successfully.');
        await StorageService().deleteAllSecureData();
        Get.offAllNamed(Routes.SIGN_IN);
      } else {
        Utils.showToast(response['message'] ?? 'Failed to logout');
      }
    } on Dio.DioException catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast(e.message ?? "Something went wrong");
      debugPrint(e.toString());
    } catch (e) {
      if (showLoader == true) {
        LoadingDialog.hideLoader();
      }
      Utils.showToast("Something went wrong");
      debugPrint(e.toString());
    }
  }

  //Watch Page

  var watch = WatchConnectivity();

  var count = 0;

  var supported = false;
  var paired = false;
  var reachable = false;
  var context = <String, dynamic>{};
  var receivedContexts = <Map<String, dynamic>>[];
  final log = <String>[];

  bool watchHasUserData = false;

  Timer? timer;

  String? scannedQrCode;

  // Platform messages are asynchronous, so we initialize in an async method.
  void initPlatformState() async {
    try {
      watch = WatchConnectivity();
      watchListener();
      supported = await watch.isSupported;
      paired = await watch.isPaired;
      reachable = await watch.isReachable;
      context = await watch.applicationContext;
      receivedContexts = await watch.receivedApplicationContexts;
      scannedQrCode = null;
      // reachable = true;
      update();
    } on PlatformException catch (pException) {
      if (pException.code.contains(
          '17: API: Wearable.API is not available on this device. Connection failed with: ConnectionResult{statusCode=API_UNAVAILABLE, resolution=null, message=null}')) {
        Utils.showAlertDialog(
          context: Get.context!,
          title: AppLocalizations.of(Get.context!)!.alert,
          description: "API: Wearable.API is not available on this device.",
          buttons: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text(AppLocalizations.of(Get.context!)!.ok),
            )
          ],
        );
      }
    }
  }

  void sendMessage({required Map<String, dynamic> data}) {
    final message = data;
    //final message = {'abcd': 'value'};
    watch.sendMessage(message);
    log.add('Sent message: $message');
    update();
  }

  void sendContext() {
    count++;
    final context = {'data': count};
    watch.updateApplicationContext(context);
    log.add('Sent context: $context');
    update();
  }

  void toggleBackgroundMessaging() {
    if (timer == null) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) => sendMessage(data: {}));
    } else {
      timer?.cancel();
      timer = null;
    }
    update();
  }

  void receivedMessage(Map<String, dynamic> data) {
    print("Data = ${data.toString()}");
    if (data['qr_valid'] != null) {
      if (data['qr_valid'] == true) {
        Utils.showToast("QR validation successful.");
        sendUserDataToWatch();
      } else {
        Utils.showToast("Invalid Qr Code");
        initPlatformState();
      }
    } else if (data['user_data_saved'] != null) {
      if (data['user_data_saved'] == true) {
        saveWatchDataStatus();
      } else {
        initPlatformState();
      }
    }
  }

  Future<void> saveWatchDataStatus() async {
    await StorageService().writeSecureData(Constants.watchHasData, 'Yes');
    checkWatchData();
  }

  Future<void> sendUserDataToWatch() async {
    String? accessToken = await StorageService().readSecureData(Constants.accessToken);
    String? userName = await StorageService().readSecureData(Constants.userName);
    String? userId = await StorageService().readSecureData(Constants.userId);
    sendMessage(data: {
      'user_data': {
        'user_name': userName,
        'user_id': userId,
        'user_token': accessToken,
      }
    });
  }

  Future<void> checkWatchData() async {
    watchHasUserData = await StorageService().readSecureData(Constants.watchHasData) == 'Yes';
    update();
  }

  watchListener() {
    watch.messageStream.listen((e) {
      receivedMessage(e);
    });

    watch.contextStream.listen((e) {
      log.add('Received context: $e');
    });
  }
}

class LanguageModel {
  String imageUrl;
  String languageName;
  String languageCode;

  LanguageModel({
    required this.languageName,
    required this.languageCode,
    required this.imageUrl,
  });
}
