import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart' as Dio;
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
        "role": role == 'User' ? 'user' : 'police_officer',
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
            await saveUserData(userModel);
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
                            AppLocalizations.of(navState.currentContext!)!.youWillBeRedirectedToTheLogInPage,
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
                              Get.offAllNamed(Routes.SIGN_IN);
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
    await StorageService()
        .writeSecureData(Constants.availability, userModel.availability == 1 ? "Available" : "Unavailable");
  }
}
