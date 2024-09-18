import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart' as Dio;
import 'package:distress_app/helpers/firebase_auth_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../imports.dart';

class SignUpController extends GetxController {
  bool termValue = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isObscure = true;
  bool isObscureConfirm = true;
  CountryCode selectedCountryCode = CountryCode(dialCode: '+93');

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  File? profileImage;

  List<String> roleList = [
    'User',
    'Police',
  ];

  String role = 'User';

  void termValueChange(value) {
    termValue = value;
    update();
  }

  signUpMethod() async {
    LoadingDialog.showLoader();
    try {
      Dio.FormData formData = Dio.FormData.fromMap({
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": emailController.text,
        "mobile_code": selectedCountryCode,
        "mobile_number": phoneNumberController.text,
        "dob": Utils.sendDateFormat(birthDateController.text),
        "username": userNameController.text,
        "password": passwordController.text,
        // "role": role == 'User' ? 'user' : 'police_officer',
        "role": 'user',
      });

      if (profileImage != null) {
        formData.files.add(
          MapEntry(
            'profile_image',
            await Dio.MultipartFile.fromFile(profileImage!.path),
          ),
        );
      }

      var response = await ApiProvider().postAPICall(
        Endpoints.signUp,
        formData,
        passToken: false,
        onSendProgress: (count, total) {},
      );
      // LoadingDialog.hideLoader();
      if (response['success'] != null && response['success'] == true) {
        if (response['data'] != null) {
          if (response['data']['user'] != null) {
            UserModel userModel = UserModel.fromJson(response['data']['user']);
            // await saveUserData(userModel);
            tempUserModel = userModel;
            LoadingDialog.hideLoader();
            Utils.showCustomDialog(
              context: navState.currentContext!,
              barrierDismissible: false,
              child: Center(
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(32),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 1.5,
                      sigmaY: 1.5,
                    ),
                    child: Container(
                      width: SizeConfig.deviceWidth! * .85,
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(16),
                        vertical: getProportionateScreenHeight(60),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          getProportionateScreenWidth(32),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: getProportionateScreenHeight(141),
                            width: getProportionateScreenWidth(141),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(AppImages.registrationSuccess),
                              ),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(navState.currentContext!)!.registrationSuccessful,
                            style: TextStyle(
                              fontFamily: AppFonts.sansFont600,
                              fontSize: getProportionalFontSize(20),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Text(
                            AppLocalizations.of(navState.currentContext!)!.kindlyVerifyYourMobileNumber,
                            style: TextStyle(
                              fontFamily: AppFonts.sansFont400,
                              fontSize: getProportionalFontSize(16),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(28),
                          ),
                          CommonButton(
                            width: getProportionateScreenWidth(196),
                            text: AppLocalizations.of(navState.currentContext!)!.verify,
                            onPressed: () {
                              Get.back();
                              if (userModel.mobileCode != null && userModel.mobileNumber != null) {
                                otpPhoneNo = '${userModel.mobileCode} ${userModel.mobileNumber}';
                                sendOTP(isResend: false);
                              }
                            },
                            radius: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }
      } else {
        LoadingDialog.hideLoader();
        Utils.showCustomDialog(
          context: navState.currentContext!,
          child: Center(
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(32),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 1.5,
                  sigmaY: 1.5,
                ),
                child: Container(
                  width: SizeConfig.deviceWidth! * .85,
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(16),
                    vertical: getProportionateScreenHeight(60),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(32),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: getProportionateScreenHeight(141),
                        width: getProportionateScreenWidth(141),
                        margin: EdgeInsets.only(
                          left: getProportionateScreenWidth(32),
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppImages.registrationFail),
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(navState.currentContext!)!.registrationUnSuccessful,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont600,
                          fontSize: getProportionalFontSize(20),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Text(
                        response['message'] ?? AppLocalizations.of(navState.currentContext!)!.registrationFailed,
                        style: TextStyle(
                          fontFamily: AppFonts.sansFont400,
                          fontSize: getProportionalFontSize(16),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(28),
                      ),
                      CommonButton(
                        width: getProportionateScreenWidth(196),
                        text: AppLocalizations.of(navState.currentContext!)!.done,
                        onPressed: () {
                          Get.back();
                        },
                        radius: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    } on Dio.DioException catch (e) {
      LoadingDialog.hideLoader();
      Utils.showCustomDialog(
        context: navState.currentContext!,
        child: Center(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(32),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1.5,
                sigmaY: 1.5,
              ),
              child: Container(
                width: SizeConfig.deviceWidth! * .85,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                  vertical: getProportionateScreenHeight(60),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(32),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: getProportionateScreenHeight(141),
                      width: getProportionateScreenWidth(141),
                      margin: EdgeInsets.only(
                        left: getProportionateScreenWidth(32),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.registrationFail),
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(navState.currentContext!)!.registrationUnSuccessful,
                      style: TextStyle(
                        fontFamily: AppFonts.sansFont600,
                        fontSize: getProportionalFontSize(20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      e.message ?? AppLocalizations.of(navState.currentContext!)!.registrationFailed,
                      style: TextStyle(
                        fontFamily: AppFonts.sansFont400,
                        fontSize: getProportionalFontSize(16),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(28),
                    ),
                    CommonButton(
                      width: getProportionateScreenWidth(196),
                      text: AppLocalizations.of(navState.currentContext!)!.done,
                      onPressed: () {
                        Get.back();
                      },
                      radius: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      update();
      debugPrint(e.toString());
    } catch (e) {
      LoadingDialog.hideLoader();
      Utils.showCustomDialog(
        context: navState.currentContext!,
        child: Center(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              getProportionateScreenWidth(32),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1.5,
                sigmaY: 1.5,
              ),
              child: Container(
                width: SizeConfig.deviceWidth! * .85,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(16),
                  vertical: getProportionateScreenHeight(60),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(32),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: getProportionateScreenHeight(141),
                      width: getProportionateScreenWidth(141),
                      margin: EdgeInsets.only(
                        left: getProportionateScreenWidth(32),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.registrationFail),
                        ),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(navState.currentContext!)!.registrationUnSuccessful,
                      style: TextStyle(
                        fontFamily: AppFonts.sansFont600,
                        fontSize: getProportionalFontSize(20),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Text(
                      AppLocalizations.of(navState.currentContext!)!.registrationFailed,
                      style: TextStyle(
                        fontFamily: AppFonts.sansFont400,
                        fontSize: getProportionalFontSize(16),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(28),
                    ),
                    CommonButton(
                      width: getProportionateScreenWidth(196),
                      text: AppLocalizations.of(navState.currentContext!)!.done,
                      onPressed: () {
                        Get.back();
                      },
                      radius: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      update();
      debugPrint(e.toString());
    }
  }

  Future<void> saveUserData(UserModel userModel) async {
    await StorageService().writeSecureData(Constants.userId, userModel.id.toString());
    await StorageService().writeSecureData(Constants.email, userModel.email ?? "");
    await StorageService().writeSecureData(Constants.firstName, userModel.firstName ?? "");
    await StorageService().writeSecureData(Constants.lastName, userModel.lastName ?? "");
    await StorageService().writeSecureData(Constants.accessToken, userModel.token ?? "");
    await StorageService().writeSecureData(Constants.userName, userModel.username ?? "");
    await StorageService().writeSecureData(Constants.profileImage, userModel.profileImage ?? "");
    await StorageService().writeSecureData(Constants.role, userModel.role ?? "user");
    await StorageService().writeSecureData(Constants.availability, userModel.availability == 1 ? "Available" : "Unavailable");
  }

  late Timer timer;
  int secondsRemaining = 59;
  bool enableResend = false;
  TextEditingController otpController = TextEditingController();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  String otpPhoneNo = '';
  UserModel tempUserModel = UserModel();
  bool? isFromLogin;

  void startTimer() {
    enableResend = false;
    secondsRemaining = 59;
    update();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining--;
        update();
      } else {
        enableResend = true;
        update();
      }
    });
  }

  void sendOTP({
    bool? isResend = false,
  }) {
    if (otpPhoneNo.isNotEmpty) {
      // if (isResend == false) {
      //   Get.toNamed(Routes.PHONE_OTP_SCREEN);
      // }
      LoadingDialog.showLoader();
      FirebaseAuthentication().verifyPhoneNumber(
        phoneNumber: otpPhoneNo,
        verificationFailed: (FirebaseAuthException e) {
          LoadingDialog.hideLoader();
          if (e.code == 'invalid-phone-number') {
            Utils.showToast(AppLocalizations.of(Get.context!)!.theProvidedPhoneNumberIsNotValid);
          } else {
            Utils.showToast(e.message ?? AppLocalizations.of(Get.context!)!.somethingWentWrong);
          }
        },
        codeSent: (verificationId, resendToken) {
          Utils.showToast("OTP sent successfully.");

          LoadingDialog.hideLoader();
          otpVerificationId = verificationId;
          if (isResend == true) {
            otpController.clear();
            if (timer.isActive) {
              timer.cancel();
            }
            startTimer();
          } else {
            Get.toNamed(Routes.PHONE_OTP_SCREEN);
          }
        },
      );
    }
  }

  String? otpVerificationId;
  void verifyOTP() async {
    if (otpVerificationId != null) {
      LoadingDialog.showLoader();
      UserCredential? userCredential = await FirebaseAuthentication().verifyOPT(
        smsCode: otpController.text,
        verificationId: otpVerificationId!,
      );

      LoadingDialog.hideLoader();
      if (userCredential != null && userCredential.user != null) {
        Utils.showToast("OTP verification successful.");
        await saveUserData(tempUserModel);
        verifyMobileAPI();
        // if (isFromLogin == true) {
        //   Get.offAllNamed(Routes.DASHBOARD);
        // } else {
        //   Utils.showCustomDialog(
        //     context: navState.currentContext!,
        //     barrierDismissible: false,
        //     child: Center(
        //       child: Material(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(
        //           getProportionateScreenWidth(32),
        //         ),
        //         child: BackdropFilter(
        //           filter: ImageFilter.blur(
        //             sigmaX: 1.5,
        //             sigmaY: 1.5,
        //           ),
        //           child: Container(
        //             width: SizeConfig.deviceWidth! * .85,
        //             padding: EdgeInsets.symmetric(
        //               horizontal: getProportionateScreenWidth(16),
        //               vertical: getProportionateScreenHeight(60),
        //             ),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(
        //                 getProportionateScreenWidth(32),
        //               ),
        //               color: Colors.white,
        //             ),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               crossAxisAlignment: CrossAxisAlignment.center,
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 Container(
        //                   height: getProportionateScreenHeight(141),
        //                   width: getProportionateScreenWidth(141),
        //                   decoration: BoxDecoration(
        //                     image: DecorationImage(
        //                       image: AssetImage(AppImages.registrationSuccess),
        //                     ),
        //                   ),
        //                 ),
        //                 Text(
        //                   AppLocalizations.of(navState.currentContext!)!.registrationSuccessful,
        //                   style: TextStyle(
        //                     fontFamily: AppFonts.sansFont600,
        //                     fontSize: getProportionalFontSize(20),
        //                   ),
        //                   textAlign: TextAlign.center,
        //                 ),
        //                 SizedBox(
        //                   height: getProportionateScreenHeight(10),
        //                 ),
        //                 Text(
        //                   AppLocalizations.of(navState.currentContext!)!.youWillBeRedirectedToTheLogInPage,
        //                   style: TextStyle(
        //                     fontFamily: AppFonts.sansFont400,
        //                     fontSize: getProportionalFontSize(16),
        //                   ),
        //                   textAlign: TextAlign.center,
        //                 ),
        //                 SizedBox(
        //                   height: getProportionateScreenHeight(28),
        //                 ),
        //                 CommonButton(
        //                   width: getProportionateScreenWidth(196),
        //                   text: AppLocalizations.of(navState.currentContext!)!.done,
        //                   onPressed: () {
        //                     Get.back();
        //                     Get.offAllNamed(Routes.SIGN_IN);
        //                   },
        //                   radius: 50,
        //                 )
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   );
        // }

        Get.offAllNamed(Routes.DASHBOARD);
      }
    } else {
      Utils.showToast("OTP verification failed please try again!");
    }
  }

  void verifyMobileAPI() async {
    // LoadingDialog.showLoader();
    try {
      Dio.FormData formData = Dio.FormData.fromMap({});

      var response = await ApiProvider().postAPICall(
        Endpoints.verifyMobile,
        formData,
        passToken: true,
        onSendProgress: (count, total) {},
      );
      // LoadingDialog.hideLoader();
      // if (response['success'] != null && response['success'] == true) {
      // } else {}
    } on Dio.DioException catch (e) {
      // LoadingDialog.hideLoader();
      // update();
      debugPrint(e.toString());
    } catch (e) {
      // LoadingDialog.hideLoader();
      // update();
      debugPrint(e.toString());
    }
  }
}
