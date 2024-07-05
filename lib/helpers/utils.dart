import 'dart:io';

import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as img;
import 'package:intl/intl.dart';

// Utility class containing various helper functions.
class Utils {
  Utils._();

  static bool _loaderActive = false;

  // Show a loader dialog.
  static void showLoader(BuildContext context) {
    if (!_loaderActive) {
      _loaderActive = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.black45,
          pageBuilder: (context, animation1, animation2) => Center(
                child: SizedBox(
                    height: SizeConfig.deviceHeight,
                    width: SizeConfig.deviceWidth,
                    child: Platform.isAndroid
                        ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor))
                        : const CupertinoActivityIndicator(
                            color: Colors.white,
                            radius: 25,
                          )),
              ));
    }
  }

  // Hide the loader dialog.
  static hideLoader(BuildContext context) {
    if (_loaderActive) {
      _loaderActive = false;
      Navigator.pop(context);
    }
  }

  // Compress an image file.
  static Future<File> compressImage(File file) async {
    img.Image? image = await img.decodeImageFile(file.path);

    if (image != null) {
      img.Image? thumbnail;
      if (image.height > image.width) {
        thumbnail = img.copyResize(image, height: 1000, interpolation: img.Interpolation.nearest, maintainAspect: true);
      } else {
        thumbnail = img.copyResize(image, width: 1000, interpolation: img.Interpolation.nearest, maintainAspect: true);
      }

      // Save the thumbnail as a PNG.
      file.writeAsBytesSync(
        img.encodePng(thumbnail),
      );
    }
    return file;
  }

  // Show a toast message.
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: getProportionalFontSize(13),
    );
  }

  static showCustomDialog(
      {required BuildContext context, required Widget child, bool? barrierDismissible, Function()? onPop}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      barrierLabel: "Dialog",
      useRootNavigator: false,
      barrierColor: Colors.black.withOpacity(.7),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return child;
      },
    ).then((value) {
      if (onPop != null) {
        onPop();
      }
    });
  }

  static showAlertDialog({
    required context,
    required title,
    bool? bar,
    required description,
    required buttons,
  }) {
    showDialog(
      context: context,
      barrierDismissible: bar ?? false,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: Text(
                title,
                style: TextStyle(
                  fontFamily: AppFonts.sansFont400,
                  fontSize: getProportionalFontSize(16),
                ),
              ),
              content: Text(
                description,
                style: TextStyle(
                  fontFamily: AppFonts.sansFont400,
                  fontSize: getProportionalFontSize(14),
                ),
              ),
              actions: buttons,
            )
          : AlertDialog(
              title: Text(
                title,
                style: TextStyle(
                  fontFamily: AppFonts.sansFont400,
                  fontSize: getProportionalFontSize(16),
                ),
              ),
              content: Text(
                description,
                style: TextStyle(
                  fontFamily: AppFonts.sansFont400,
                  fontSize: getProportionalFontSize(14),
                ),
              ),
              actions: buttons,
            ),
    );
  }

  // Date picker dialog.
  static Future<String?> datePicker(BuildContext context,
      {DateTime? lastDate, firstDate, initialDate, String? forMate}) async {
    String? dateTime;
    DateTime? pickedDate = await showDatePicker(
      builder: (context, child) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(90), horizontal: getProportionateScreenWidth(25)),
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: AppColors.primaryColor),
            ),
            child: child!,
          ),
        );
      },
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(DateTime.now().year - 100),
      lastDate: lastDate ?? DateTime(DateTime.now().year + 100),
    );

    if (pickedDate != null) {
      final DateFormat serverFormatter = DateFormat(forMate ?? 'dd/MM/yyyy');
      dateTime = serverFormatter.format(pickedDate);
    }

    return dateTime;
  }
}
