import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  ///TODO Static/Dynamic
  List<String> reportType = [
    'Missing Person',
    'Police Report',
  ];

  String reportTypeValue = 'Missing Person';

  bool addFriendsValue = false;
  bool reportAnonymouslyValue = false;

  bool speakToProfessional = false;

  List<File> pickedFiles = [];
  @override
  void onReady() {
    super.onReady();
  }

  void switchAddFriendsValue(bool value) {
    addFriendsValue = value;
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
}
