import 'dart:io';

import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

/// A utility class for showing and hiding loading indicators.
class LoadingDialog {
  LoadingDialog._(); // Private constructor to prevent instantiation

  /// Flag to indicate whether the loader is currently active.
  static bool loaderActive = false;

  /// Value to track the progress of the loader.
  static double loaderValue = 0;

  /// Displays a loading indicator.
  static void showLoader() {
    if (!loaderActive) {
      loaderActive = true;
      showGeneralDialog(
        context: navState.currentContext!,
        barrierDismissible: false,
        barrierColor: Colors.black45,
        pageBuilder: (context, animation1, animation2) => Center(
          child: SizedBox(
            height: SizeConfig.deviceHeight,
            width: SizeConfig.deviceWidth,
            child: Platform.isAndroid
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : const CupertinoActivityIndicator(
                    color: AppColors.primaryColor,
                    radius: 25,
                    animating: true,
                  ),
          ),
        ),
      );
    }
  }

  /// Hides the loading indicator.
  static hideLoader() {
    if (loaderActive) {
      loaderActive = false;
      Navigator.pop(navState.currentContext!);
    }
  }
}
