import 'package:distress_app/localization/app_localizations.dart';
import 'package:distress_app/main.dart';
import 'package:distress_app/utils/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  late PageController pageController;
  int activePage = 0;

  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      image: AppImages.onBoardingOne,
      text: AppLocalizations.of(navState.currentContext!)!.reportCrimes,
      buttonText: AppLocalizations.of(navState.currentContext!)!.next.toUpperCase(),
      cornerImage: AppImages.onBoardingOneCorner,
    ),
    OnBoardingModel(
      image: AppImages.onBoardingTwo,
      text: AppLocalizations.of(navState.currentContext!)!.accessEducationalResources,
      buttonText: AppLocalizations.of(navState.currentContext!)!.next.toUpperCase(),
      cornerImage: AppImages.onBoardingTwoCorner,
    ),
    OnBoardingModel(
      image: AppImages.onBoardingThree,
      text: AppLocalizations.of(navState.currentContext!)!.freeConsultation,
      buttonText: AppLocalizations.of(navState.currentContext!)!.next.toUpperCase(),
      cornerImage: AppImages.onBoardingThreeCorner,
    ),
    OnBoardingModel(
      image: AppImages.onBoardingFour,
      text: AppLocalizations.of(navState.currentContext!)!.safetyPlanning,
      buttonText: AppLocalizations.of(navState.currentContext!)!.finish.toUpperCase(),
      cornerImage: AppImages.onBoardingFourCorner,
    ),
  ];
}

class OnBoardingModel {
  final String cornerImage, image, text, buttonText;
  OnBoardingModel({
    required this.image,
    required this.text,
    required this.buttonText,
    required this.cornerImage,
  });
}
