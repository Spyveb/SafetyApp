import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnBoardingController>(
        builder: (controller) {
          return PageView.builder(
            clipBehavior: Clip.none,
            controller: controller.pageController,
            itemCount: controller.onBoardingList.length,
            onPageChanged: (value) {
              controller.activePage = value;
              controller.update();
            },
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              OnBoardingModel onBoardingModel = controller.onBoardingList[index];
              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      index % 2 == 0
                          ? SizedBox(
                              height: _height(index),
                            )
                          : Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(24),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          onBoardingModel.image,
                          height: getProportionateScreenHeight(300),
                          alignment: Alignment.center,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(24),
                      ),
                      Text(
                        onBoardingModel.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(30),
                          fontFamily: AppFonts.interFont700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List<Widget>.generate(
                          controller.onBoardingList.length,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(5),
                            ),
                            child: InkWell(
                              onTap: () {
                                controller.pageController.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                              },
                              child: Container(
                                height: getProportionateScreenHeight(12),
                                width: getProportionateScreenWidth(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.activePage == index ? AppColors.primaryColor : AppColors.greyColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          if (index < controller.onBoardingList.length - 1) {
                            controller.pageController.animateToPage(index + 1, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                          } else {
                            Get.offAllNamed(Routes.SIGN_IN);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(17),
                              horizontal: getProportionateScreenWidth(70),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                getProportionateScreenWidth(50),
                              ),
                            ),
                            backgroundColor: index % 2 == 0 ? AppColors.primaryColor : AppColors.greyColor),
                        child: Text(
                          onBoardingModel.buttonText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: getProportionalFontSize(20),
                            fontFamily: AppFonts.interFont700,
                            color: index % 2 == 0 ? AppColors.whiteColor : AppColors.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(50),
                      ),
                    ],
                  ),
                  Align(
                    alignment: _alignment(index),
                    child: Image.asset(
                      onBoardingModel.cornerImage,
                      color: AppColors.primaryColor,
                      height: _height(index),
                      width: _width(index),
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }

  Alignment _alignment(int index) {
    Alignment alignment = Alignment.topLeft;

    if (index == 0) {
      alignment = Alignment.topLeft;
    } else if (index == 1) {
      alignment = Alignment.bottomLeft;
    } else if (index == 2) {
      alignment = Alignment.topRight;
    } else if (index == 3) {
      alignment = Alignment.bottomRight;
    }

    return alignment;
  }

  double _height(int index) {
    double height = getProportionateScreenHeight(178);
    if (index == 0) {
      height = getProportionateScreenHeight(178);
    } else if (index == 1) {
      height = getProportionateScreenHeight(206);
    } else if (index == 2) {
      height = getProportionateScreenHeight(182.5);
    } else if (index == 3) {
      height = getProportionateScreenHeight(144.71);
    }
    return height;
  }

  double _width(int index) {
    double width = getProportionateScreenWidth(122);
    if (index == 0) {
      width = getProportionateScreenWidth(122);
    } else if (index == 1) {
      width = getProportionateScreenWidth(86);
    } else if (index == 2) {
      width = getProportionateScreenWidth(273);
    } else if (index == 3) {
      width = getProportionateScreenWidth(122);
    }
    return width;
  }
}
