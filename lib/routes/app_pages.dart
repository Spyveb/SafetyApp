import 'package:distress_app/imports.dart';
import 'package:distress_app/police_modules/police_dashboard/notification_screen.dart';
import 'package:distress_app/police_modules/reported_non_emergency_cases/contents_detail_view.dart';
import 'package:distress_app/police_modules/reported_non_emergency_cases/reported_non_emergency_case_details.dart';
import 'package:distress_app/police_modules/setting/police_edit_profile_screen.dart';
import 'package:distress_app/user_modules/home_module/user_sos_request_detail.dart';
import 'package:distress_app/user_modules/settings_module/change_password_screen.dart';
import 'package:distress_app/user_modules/training_module/video_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

abstract class AppPages {
  const AppPages._();

  static final routes = [
    // User Modules
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
      name: Routes.OTP_SCREEN,
      page: () => OtpScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.RESET_PASSWORD_SCREEN,
      page: () => ResetPasswordScreen(),
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
      name: Routes.USERSOSREQUESTDETAIL,
      page: () => UserSosRequestDetailScreen(),
      binding: HomeBinding(),
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
      name: Routes.HTML_SCREEN,
      page: () => HTMLDataScreen(),
      // binding: SettingsBinding,
    ),
    GetPage(
      name: Routes.TRAINING,
      page: () => TrainingScreen(),
      binding: TrainingBinding(),
    ),
    GetPage(
      name: Routes.VIDEO_SCREEN,
      page: () => const VideoScreen(),
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
    GetPage(
      name: Routes.CHANGE_PASSWORD_SCREEN,
      page: () => ChangePasswordScreen(),
      binding: SettingsBinding(),
    ),

    // Police Modules
    GetPage(
      name: Routes.POLICE_DASHBOARD,
      page: () => const PoliceDashBoardScreen(),
      binding: PoliceDashBoardBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION_SCREEN,
      page: () => const NotificationScreen(),
      binding: PoliceDashBoardBinding(),
    ),
    GetPage(
      name: Routes.POLICE_SOSEMERGENCY,
      page: () => const PoliceSOSEmergencyScreen(),
      binding: PoliceSOSEmergencyBinding(),
    ),
    GetPage(
      name: Routes.POLICE_REPORTEDEMGCASES,
      page: () => const ReportedEmgCasesScreen(),
      binding: ReportedEmgCasesBinding(),
    ),
    GetPage(
      name: Routes.POLICE_REPORTEDNONEMGCASES,
      page: () => const ReportedNonEmgCasesScreen(),
      binding: ReportedNonEmgCasesBinding(),
    ),
    GetPage(
      name: Routes.POLICE_REPORTEDNONEMGCASE_DETAILS,
      page: () => const ReportedNonEmgCaseDetailsScreen(),
      // binding: ReportedNonEmgCasesBinding(),
    ),
    GetPage(
      name: Routes.CONTENTS_DETAIL_VIEW,
      page: () => const ContentsDetailViewScreen(),
      // binding: ReportedNonEmgCasesBinding(),
    ),
    GetPage(
      name: Routes.POLICE_SETTING,
      page: () => const PoliceSettingScreen(),
      binding: PoliceSettingBinding(),
    ),
    GetPage(
      name: Routes.POLICE_EDIT_PROFILE,
      page: () => const PoliceEditProfileScreen(),
      binding: PoliceSettingBinding(),
    ),

    // SocialWorker Modules
    GetPage(
      name: Routes.SOCIAL_WORKER_DASHBOARD,
      page: () => const SocialWorkerDashBoardScreen(),
      binding: SocialWorkerDashBoardBinding(),
    ),
    GetPage(
      name: Routes.SOCIAL_WORKER_REQUEST,
      page: () => const SocialWorkerRequestScreen(),
      binding: SocialWorkerRequestdBinding(),
    ),
    GetPage(
      name: Routes.SOCIAL_WORKER_SETTINGS,
      page: () => const SocialWorkerSettingScreen(),
      binding: SocialWorkerSettingBinding(),
    ),
    GetPage(
      name: Routes.SOCIAL_WORKER_EDIT_PROFILE,
      page: () => const SocialWorkerSettingScreen(),
      binding: SocialWorkerSettingBinding(),
    ),
  ];
}
