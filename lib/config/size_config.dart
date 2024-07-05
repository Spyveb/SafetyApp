import 'package:flutter/cupertino.dart';

// A utility class for managing size configurations based on the device screen size.
class SizeConfig {
  late MediaQueryData _mediaQueryData;
  static double? deviceWidth;
  static double? deviceHeight;

  // Initializes the SizeConfig with the provided [BuildContext].
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    deviceWidth = _mediaQueryData.size.width;
    deviceHeight = _mediaQueryData.size.height;
  }
}

// Get the proportionate height as per the screen size.
double getProportionateScreenHeight(double inputHeight) {
  double? screenHeight = SizeConfig.deviceHeight;
  // 800 is the layout height that designer used
  return (inputHeight / 852.0) * screenHeight!;
}

// Get the proportionate width as per the screen size.
double getProportionateScreenWidth(double inputWidth) {
  double? screenWidth = SizeConfig.deviceWidth;
  // 390 is the layout width that designer used
  return (inputWidth / 393.0) * screenWidth!;
}

// Get the proportionate font size as per the screen size.
double getProportionalFontSize(double fontSize) {
  double finalFontSize = fontSize;
  double? screenWidth = SizeConfig.deviceWidth;
  finalFontSize = (finalFontSize * screenWidth!) / 393.0;
  return finalFontSize;
}
