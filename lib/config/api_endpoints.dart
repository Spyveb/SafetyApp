class Endpoints {
  Endpoints._();

  static const baseUrl = "https://royalblue-mandrill-559334.hostingersite.com/public/";

  // Authentication Endpoints
  static const signIn = "${baseUrl}api/login"; // Endpoint for user sign in
  static const signUp = "${baseUrl}api/signup"; // Endpoint for user sign up
  static const getProfile = "${baseUrl}api/get_profile"; // Endpoint for get profile
  static const forgotPassword = "${baseUrl}api/forget_password"; // Endpoint for forgot password
  static const resetPassword = "${baseUrl}api/reset_password"; // Endpoint for reset password
  static const updateProfile = "${baseUrl}api/update_profile"; // Endpoint for get profile
  static const deleteAccount = "${baseUrl}api/delete_account"; // Endpoint for delete account
  static const saveSetting = "${baseUrl}api/save_setting"; // Endpoint for save setting
  static const sendSOSEmergency = "${baseUrl}api/create_sos_emergency_case"; // Endpoint for create_sos_emergency_case
  static const sosEmergencyList = "${baseUrl}api/sos_emergency_case_list"; // Endpoint for sos_emergency_case_list
  static const openSOSEmergencyList =
      "${baseUrl}api/open_sos_emergency_case_list"; // Endpoint for open_sos_emergency_case_list
  static const sendNonEmergency = "${baseUrl}api/create_non_emergency_case"; // Endpoint for delete account
  static const nonEmergencyList = "${baseUrl}api/non_emergency_case_list"; // Endpoint for delete account
  static const categoryList = "${baseUrl}api/categories_list"; // Endpoint for categories list
  static const categoryDetail = "${baseUrl}api/category_detail"; // Endpoint for category_detail
  static const emergencyContactList = "${baseUrl}api/emergency_contact_list"; // Endpoint for emergencyContactList
  static const saveAddress = "${baseUrl}api/save_address"; // Endpoint for saveAddress
  static const saveFCMToken = "${baseUrl}api/save_fcm_token"; // Endpoint for saveAddress

  static const emergencyContactCreate =
      "${baseUrl}api/emergency_contact_create"; // Endpoint for emergency_contact_create
  static const emergencyContactUpdate =
      "${baseUrl}api/emergency_contact_update"; // Endpoint for emergency_contact_update
  static const emergencyContactDelete =
      "${baseUrl}api/emergency_contact_delete"; // Endpoint for emergency_contact_delete
  static const termAndCondition =
      "https://royalblue-mandrill-559334.hostingersite.com/public/api/content/term-and-condition"; // Endpoint for term-and-condition

  static const privacyPolicy =
      "https://royalblue-mandrill-559334.hostingersite.com/public/api/content/privacy-policy"; // Endpoint for term-and-condition
}
