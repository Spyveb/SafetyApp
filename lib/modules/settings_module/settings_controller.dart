import 'package:distress_app/helpers/secure_storage.dart';
import 'package:distress_app/main.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:distress_app/utils/constants.dart';
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
