import 'dart:io';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/imports.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  ///TODO Static/Dynamic
  List<String> reportType = [
    'Missing Person',
    'Police Report',
  ];

  String reportTypeValue = 'Missing Person';

  bool alertFriendsValue = false;
  bool reportAnonymouslyValue = false;

  bool speakToProfessional = false;

  List<File> pickedFiles = [];

  TextEditingController informationController = TextEditingController();
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      pickedFiles.addAll(files);
    } else {
      // Utils.showToast("message")
      // User canceled the picker
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
      });

      if (pickedFiles.isNotEmpty) {
        for (int i = 0; i < pickedFiles.length; i++) {
          formData.files.add(
            MapEntry('file[${i}]',
                await Dio.MultipartFile.fromFile(pickedFiles[i].path, filename: pickedFiles[i].path.split('/').last)),
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
