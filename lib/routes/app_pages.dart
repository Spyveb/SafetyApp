import 'package:distress_app/imports.dart';
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
      name: Routes.EDIT_PROFILE,
      page: () => EditProfileScreen(),
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
