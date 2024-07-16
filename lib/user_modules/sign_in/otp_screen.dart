import 'package:distress_app/imports.dart';
import 'package:distress_app/packages/otp_field/pinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends GetView<SignInController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignInController>(
        init: SignInController(),
        global: true,
        autoRemove: false,
        builder: (SignInController signInController) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(24),
                vertical: getProportionateScreenHeight(12),
              ),
              child: Form(
                key: controller.otpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  height: getProportionateScreenHeight(40),
                                  width: getProportionateScreenWidth(40),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(bottom: getProportionateScreenHeight(8)),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 22,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  AppLocalizations.of(context)!.verificationCode,
                                  style: TextStyle(
                                    fontSize: getProportionalFontSize(22),
                                    fontFamily: AppFonts.sansFont600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!.pleaseEnterTheCodeSentTo,
                                  style: TextStyle(
                                    fontSize: getProportionalFontSize(18),
                                    fontFamily: AppFonts.sansFont400,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: controller.forgotEmail,
                                  style: TextStyle(
                                    fontSize: getProportionalFontSize(18),
                                    fontFamily: AppFonts.sansFont600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(80),
                          ),
                          Center(
                            child: Pinput(
                              keyboardType: TextInputType.number,
                              pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                              mainAxisAlignment: MainAxisAlignment.center,
                              autofocus: true,
                              length: 6,
                              controller: controller.otpController,
                              onChanged: (value) {
                                controller.update();
                              },
                              validator: (value) {
                                if (value!.length <= 5) {
                                  return "";
                                }
                                return null;
                              },
                              defaultPinTheme: PinTheme(
                                height: getProportionateScreenHeight(64),
                                width: getProportionateScreenWidth(64),
                                textStyle: TextStyle(
                                  fontSize: getProportionalFontSize(28),
                                  fontFamily: AppFonts.sansFont600,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                height: getProportionateScreenHeight(64),
                                width: getProportionateScreenWidth(64),
                                textStyle: TextStyle(
                                  fontSize: getProportionalFontSize(28),
                                  fontFamily: AppFonts.sansFont600,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(25),
                          ),
                        ],
                      ),
                    ),
                    CommonButton(
                      onPressed:
                          controller.otpFormKey.currentState != null && controller.otpFormKey.currentState!.validate()
                              ? () {
                                  controller.submitOtp(context);
                                }
                              : null,
                      width: SizeConfig.deviceWidth,
                      text: AppLocalizations.of(context)!.submit,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
