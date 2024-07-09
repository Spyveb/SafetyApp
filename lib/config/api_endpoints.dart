class Endpoints {
  Endpoints._();

  static const baseUrl = "https://royalblue-mandrill-559334.hostingersite.com/public/";

  // Authentication Endpoints
  static const signIn = "${baseUrl}api/login"; // Endpoint for user sign in
  static const signUp = "${baseUrl}api/signup"; // Endpoint for user sign up
  static const getProfile = "${baseUrl}api/get_profile"; // Endpoint for get profile
  static const updateProfile = "${baseUrl}api/update_profile"; // Endpoint for get profile
  static const deleteAccount = "${baseUrl}api/delete_account"; // Endpoint for delete account
}
