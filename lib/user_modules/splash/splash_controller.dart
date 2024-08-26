import 'package:distress_app/imports.dart';
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

  String? notificationType;

  Future<void> getInitialData() async {
    bool isFirstTime = await StorageService().isFirstTime();
    print("IsFirstTime>>>>" + isFirstTime.toString());

    if (!isFirstTime) {
      this.isFirstTime = false;
      String? accessToken = await StorageService().readSecureData(Constants.accessToken);

      if (accessToken != null && accessToken.isNotEmpty) {
        if (notificationType == 'sos_create') {
          Future.delayed(Duration(milliseconds: 1500)).then((value) {
            Get.offAllNamed(Routes.POLICE_DASHBOARD);
            Get.toNamed(Routes.POLICE_SOSEMERGENCY);
          });
        } else if (notificationType == 'non_create') {
          Future.delayed(Duration(milliseconds: 1500)).then((value) async {
            Get.offAllNamed(Routes.POLICE_DASHBOARD);
            // Get.toNamed(Routes.POLICE_REPORTEDNONEMGCASES);

            print("HEL: ${reportCaseModel?.firstName}");
            if (reportCaseModel != null) {
              Get.find<ReportedNonEmgCasesController>().goToDetails(reportCaseModel!);
              await Get.toNamed(Routes.POLICE_REPORTEDNONEMGCASE_DETAILS);
              Get.find<ReportedNonEmgCasesController>().reportCaseModel = null;
              reportCaseModel = null;
            }
          });
        } else if (notificationType == 'sos_accept') {
          Get.lazyPut(() => DashBoardController());
          Get.lazyPut(() => HomeController());
          Get.lazyPut(() => SettingsController());
          Get.lazyPut(() => TrainingController());
          Get.lazyPut(() => ReportController());
          Get.lazyPut(() => ChatController());
          Future.delayed(Duration(milliseconds: 1500)).then((value) {
            Get.offAllNamed(Routes.DASHBOARD);
            Get.toNamed(Routes.USERSOSREQUESTDETAIL);
          });
        } else if (notificationType == 'non_accept') {
          Future.delayed(Duration(milliseconds: 1500)).then((value) {
            Get.offAllNamed(Routes.DASHBOARD);
          });
        } else {
          isAuthenticated = true;
          role = await StorageService().readSecureData(Constants.role) ?? "user";

          if (role == "police_officer") {
            Future.delayed(Duration(milliseconds: 2500)).then((value) {
              Get.offAllNamed(Routes.POLICE_DASHBOARD);
            });
          } else if (role == "social_worker") {
            Get.offAllNamed(Routes.SOCIAL_WORKER_DASHBOARD);
          }
          // else if (controller.role == "social_worker") {
          //   Get.offAllNamed(Routes.SOCIAL_WORKER_DASHBOARD);
          // }
          else {
            Future.delayed(Duration(milliseconds: 2500)).then((value) {
              Get.offAllNamed(Routes.DASHBOARD);
            });
          }
        }
      } else {
        isAuthenticated = false;
        Future.delayed(Duration(milliseconds: 2500)).then((value) {
          Get.offAllNamed(Routes.SIGN_IN);
        });
      }
    } else {
      this.isFirstTime = true;
      Future.delayed(Duration(milliseconds: 3500)).then((value) {
        Get.offAllNamed(Routes.ONBOARDING);
      });
    }
    update();
  }

  ReportCaseModel? reportCaseModel;

  void goToDetails(ReportCaseModel model) {
    reportCaseModel = model;
    update();
  }
}
