import 'package:get/get.dart';

class TrainingController extends GetxController {
  int tabIndex = 1;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  ///TODO
  List<String> educationList = [
    "Violence",
    "Drugs",
    "Mental Health",
    "Community",
  ];
  @override
  void onReady() {
    // getHome();
    super.onReady();
  }
}
