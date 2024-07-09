import 'package:distress_app/modules/chat/chat_bindings.dart';
import 'package:distress_app/modules/chat/chat_screen.dart';
import 'package:distress_app/modules/dashboard/dashboard_bindings.dart';
import 'package:distress_app/modules/dashboard/dashboard_screen.dart';
import 'package:distress_app/modules/home_module/home_bindings.dart';
import 'package:distress_app/modules/home_module/home_screen.dart';
import 'package:distress_app/modules/onboarding/onboarding_bindings.dart';
import 'package:distress_app/modules/onboarding/onboarding_screen.dart';
import 'package:distress_app/modules/report_module/report_bindings.dart';
import 'package:distress_app/modules/report_module/report_screen.dart';
import 'package:distress_app/modules/report_module/submit_report_screen.dart';
import 'package:distress_app/modules/settings_module/add_edit_emergency_contacts.dart';
import 'package:distress_app/modules/settings_module/emergency_contacts.dart';
import 'package:distress_app/modules/settings_module/settings_bindings.dart';
import 'package:distress_app/modules/settings_module/settings_screen.dart';
import 'package:distress_app/modules/sign_in/signin_bindings.dart';
import 'package:distress_app/modules/sign_in/signin_screen.dart';
import 'package:distress_app/modules/sign_up/signup_bindings.dart';
import 'package:distress_app/modules/sign_up/signup_screen.dart';
import 'package:distress_app/modules/splash/splash_bindings.dart';
import 'package:distress_app/modules/splash/splash_screen.dart';
import 'package:distress_app/modules/training_module/training_bindings.dart';
import 'package:distress_app/modules/training_module/training_screen.dart';
import 'package:distress_app/modules/training_module/training_topic_details_screen.dart';
import 'package:distress_app/modules/training_module/training_topic_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

abstract class AppPages {
  const AppPages._();

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnBoardingScreen(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: Routes.SIGN_IN,
      page: () => SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => DashBoardScreen(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.EMERGENCY_CONTACTS,
      page: () => EmergencyContactsScreen(),
      // binding: SettingsBinding,
    ),
    GetPage(
      name: Routes.ADD_EMERGENCY_CONTACTS,
      page: () => AddEditEmergencyContactsScreen(),
      // binding: SettingsBinding,
    ),
    GetPage(
      name: Routes.TRAINING,
      page: () => TrainingScreen(),
      binding: TrainingBinding(),
    ),
    GetPage(
      name: Routes.TRAINING_TOPIC,
      page: () => TrainingTopicScreen(),
      // binding: TrainingBinding(),
    ),
    GetPage(
      name: Routes.REPORT,
      page: () => ReportScreen(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: Routes.SUBMIT_REPORT,
      page: () => SubmitReportScreen(),
      // binding: ReportBinding(),
    ),
    GetPage(
      name: Routes.TRAINING_TOPIC_DETAILS,
      page: () => TrainingTopicDetailScreen(),
      // binding: ReportBinding(),
    ),
    GetPage(
      name: Routes.CHAT,
      page: () => ChatScreen(),
      binding: ChatBinding(),
    ),
  ];
}
