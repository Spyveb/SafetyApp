import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool termValue = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isObscure = true;
  bool isObscureConfirm = true;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void termValueChange(value) {
    termValue = value;
    update();
  }

  // signUpMethod() async {
  //   LoadingDialog.showLoader();
  //   try {
  //     Dio.FormData formData = Dio.FormData.fromMap({
  //       "username": userNameController.text,
  //       "email": emailController.text,
  //       "password": confirmPasswordController.text,
  //       "firstname": firstNameController.text,
  //       "lastname": lastNameController.text,
  //     });
  //     var response = await ApiProvider().postAPICall(
  //       Endpoints.register,
  //       formData,
  //       passToken: false,
  //       onSendProgress: (count, total) {},
  //     );
  //     LoadingDialog.hideLoader();
  //     if (response['status'] != null && response['status'] == true) {
  //       if (response['data'] != null) {
  //         if (response['data']['user'] != null) {
  //           UserModel userModel = UserModel.fromJson(response['data']['user']);
  //           await saveUserData(userModel);
  //           Utils.showToast(response['message'] ?? "User registered successfully.");
  //           if (response['data']['user']['otp'] != null) {
  //             Get.lazyPut(() => OtpController());
  //             OtpController otpController = Get.find<OtpController>();
  //             otpController.otp = (response['data']['user']['otp']).toString();
  //             otpController.email = (response['data']['user']['email'] ?? emailController.text).toString();
  //             otpController.myDuration = Duration(seconds: 59);
  //             otpController.startTimer();
  //             update();
  //             Get.toNamed(
  //               Routes.SENDOTP,
  //             );
  //           }
  //         }
  //       }
  //     } else {
  //       Utils.showToast(response['message'] ?? "Signup Failed");
  //     }
  //   } on Dio.DioException catch (e) {
  //     LoadingDialog.hideLoader();
  //     Utils.showToast(e.message ?? "Something went wrong");
  //     update();
  //     debugPrint(e.toString());
  //   } catch (e) {
  //     LoadingDialog.hideLoader();
  //     Utils.showToast("Something went wrong");
  //     update();
  //     debugPrint(e.toString());
  //   }
  // }
  //
  // Future<void> saveUserData(UserModel userModel) async {
  //   await StorageService().writeSecureData(Constants.userId, userModel.customerId.toString());
  //   await StorageService().writeSecureData(Constants.email, userModel.email.toString());
  //   await StorageService().writeSecureData(Constants.firstName, userModel.firstname ?? "");
  //   await StorageService().writeSecureData(Constants.lastName, userModel.lastname ?? "");
  //   await StorageService().writeSecureData(Constants.isSkipped, 'NO');
  //   Get.find<DashBoardController>().isSkipped = 'NO';
  // }
}
