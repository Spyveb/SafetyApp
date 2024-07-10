import 'package:distress_app/helpers/secure_storage.dart';
import 'package:distress_app/utils/constants.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    getInitialData();
    super.onReady();
  }

  bool isFirstTime = false;
  bool isAuthenticated = false;
  String role = "user";

  Future<void> getInitialData() async {
    bool isFirstTime = await StorageService().isFirstTime();
    print("IsFirstTime>>>>" + isFirstTime.toString());

    if (!isFirstTime) {
      this.isFirstTime = false;
      String? accessToken = await StorageService().readSecureData(Constants.accessToken);
      if (accessToken != null && accessToken.isNotEmpty) {
        isAuthenticated = true;
        role = await StorageService().readSecureData(Constants.role) ?? "user";
        // Future.delayed(Duration(milliseconds: 1500)).then((value) {
        //   Get.offAllNamed(AppRoute.splashRoute);
        // });
      } else {
        isAuthenticated = false;
        // Future.delayed(Duration(milliseconds: 3500)).then((value) {
        //   Get.offAllNamed(AppRoute.splashRoute);
        // });
      }
    } else {
      this.isFirstTime = true;
      // Future.delayed(Duration(milliseconds: 3500)).then((value) {
      //   Get.offAllNamed(AppRoute.splashRoute);
      // });
    }
    update();
  }
}
