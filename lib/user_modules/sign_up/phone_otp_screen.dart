import 'package:distress_app/imports.dart';
import 'package:distress_app/packages/otp_field/pinput.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneOtpScreen extends GetView<SignUpController> {
  const PhoneOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignUpController>(
        init: SignUpController(),
        initState: (state) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            controller.startTimer();
          });
        },
        dispose: (state) {
          controller.timer.cancel();
        },
        global: true,
        autoRemove: false,
        builder: (SignUpController signUpController) {
          return SafeArea(
            child: BackgroundWidget(
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
                                    text: controller.otpPhoneNo,
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
                        onPressed: controller.otpFormKey.currentState != null && controller.otpFormKey.currentState!.validate()
                            ? () {
                                controller.verifyOTP();
                              }
                            : null,
                        width: SizeConfig.deviceWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(16),
                          vertical: getProportionateScreenHeight(16),
                        ),
                        text: AppLocalizations.of(context)!.submit,
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(12),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: controller.enableResend
                              ? () {
                                  controller.sendOTP(isResend: true);
                                }
                              : null,
                          child: Text(
                            "Resend OTP ${controller.enableResend == false ? "in ${controller.secondsRemaining} seconds" : ''}",
                            style: TextStyle(
                              fontSize: getProportionalFontSize(14),
                              // fontWeight:controller.enableResend ? FontWeight FontWeight.w500,
                              fontFamily: controller.enableResend ? AppFonts.sansFont600 : AppFonts.sansFont400,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
