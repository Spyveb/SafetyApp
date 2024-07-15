import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../imports.dart';

class PoliceSettingController extends GetxController {
  @override
  void onReady() {
    getCurrentLanguage();
    super.onReady();
  }

  Locale? locale;

  bool availability = false;

  void availabilitySwitch(bool value) {
    availability = value;
    update();

    saveSettings();
  }

  void saveSettings() async {
    // LoadingDialog.showLoader();

    try {
      Dio.FormData formData = Dio.FormData.fromMap(
        {"availability": availability ? 1 : 0},
      );
      var response = await ApiProvider().postAPICall(
        Endpoints.saveSetting,
        formData,
      );
      // LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        await StorageService()
            .writeSecureData(Constants.availability, availability == true ? 'Available' : 'Unavailable');
      } else {
        availability = !availability;
      }
      await Get.find<PoliceDashBoardController>().getUserName();
      // Get.find<PoliceDashBoardController>().update();
      update();
    } on Dio.DioException catch (e) {
      // LoadingDialog.hideLoader();
      Utils.showToast(e.message ?? "Something went wrong");
      availability = !availability;

      update();
      debugPrint(e.toString());
    } catch (e) {
      // LoadingDialog.hideLoader();
      Utils.showToast("Something went wrong");
      availability = !availability;

      update();
      debugPrint(e.toString());
    }
  }

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
    await StorageService()
        .writeSecureData(Constants.language, locale != null ? locale!.languageCode : Constants.enLanguage);
    update();
  }

  List<LanguageModel> languages = [
    LanguageModel(languageName: "English", languageCode: "en", imageUrl: AppImages.usLanguage),
    LanguageModel(languageName: "Dutch", languageCode: "de", imageUrl: AppImages.germanyLanguage),
    LanguageModel(languageName: "French", languageCode: "fr", imageUrl: AppImages.frenchLanguage),
    LanguageModel(languageName: "Afrikaans", languageCode: "af", imageUrl: AppImages.namibiaLanguage),
  ];

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
    availability = userModel.availability == 1;
    update();
  }

  Future<void> saveUserData(UserModel userModel) async {
    await StorageService().writeSecureData(Constants.userId, userModel.id.toString());
    await StorageService().writeSecureData(Constants.userName, userModel.username ?? "");
    await StorageService().writeSecureData(Constants.firstName, userModel.firstName ?? "");
    await StorageService().writeSecureData(Constants.lastName, userModel.lastName ?? "");
    await StorageService().writeSecureData(Constants.profileImage, userModel.profileImage ?? "");
    await StorageService().writeSecureData(Constants.email, userModel.email ?? "");
    await StorageService()
        .writeSecureData(Constants.availability, userModel.availability == 1 ? "Available" : "Unavailable");
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
}
