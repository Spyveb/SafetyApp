import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/config/api_endpoints.dart';
import 'package:distress_app/helpers/secure_storage.dart';
import 'package:distress_app/helpers/utils.dart';
import 'package:distress_app/infrastructure/api_controller.dart';
import 'package:distress_app/infrastructure/models/user_model.dart';
import 'package:distress_app/main.dart';
import 'package:distress_app/packages/country_code_picker/src/country_code.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:distress_app/utils/constants.dart';
import 'package:distress_app/utils/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  bool reportAnonymously = false;

  void switchReportAnonymously(bool value) {
    reportAnonymously = value;
    update();
  }

  TextEditingController textEditingController = TextEditingController();

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
    await StorageService()
        .writeSecureData(Constants.language, locale != null ? locale!.languageCode : Constants.enLanguage);
    update();
  }

  void selectContact() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      Contact? contact = await FlutterContacts.openExternalPick();
      if (contact != null) {
        contactNameController.text = contact.displayName;
        contactNumberController.text = contact.phones.map((e) => e.number).toString();
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

  void getUserProfile() async {
    LoadingDialog.showLoader();
    try {
      var response = await ApiProvider().postAPICall(
        Endpoints.getProfile,
        null,
        onSendProgress: (count, total) {},
      );

      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null) {
          if (response['data']['user'] != null) {
            UserModel userModel = UserModel.fromJson(response['data']['user']);
            await saveUserData(userModel);
            LoadingDialog.hideLoader();
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

  Future<void> saveUserData(UserModel userModel) async {
    firstNameController.text = userModel.firstName ?? '';
    lastNameController.text = userModel.lastName ?? '';
    emailController.text = userModel.email ?? '';

    phoneNumberController.text = userModel.mobileNumber ?? '';
    selectedCountryCode = CountryCode(dialCode: userModel.mobileCode ?? '+93');
    birthDateController.text = Utils.displayDateFormat(userModel.dob ?? '');
    userNameController.text = userModel.username ?? '';
    update();
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
      "dob": birthDateController.text,
      "username": userNameController.text,
      // "username": userNameController.text,
    });
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
            // await saveUserData(userModel);
            LoadingDialog.hideLoader();
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
