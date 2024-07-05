// A button widget commonly used throughout the application.
import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final double? height, width, radius; // Height and width of the button.
  final String? text; // Text to display on the button.
  final VoidCallback? onPressed; // Callback function when the button is pressed.
  final EdgeInsets? padding; // Callback function when the button is pressed.
  final TextStyle? textStyle; // CommonButton textStyle.

  // Constructor for the CommonButton widget.
  const CommonButton(
      {Key? key, this.height, this.width, this.text, this.onPressed, this.radius, this.padding, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? SizeConfig.deviceWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.white10),
          backgroundColor: MaterialStateProperty.all(
            AppColors.primaryColor,
          ),
          padding: MaterialStateProperty.all(
            padding ??
                EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(20),
                  horizontal: getProportionateScreenWidth(16),
                ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                getProportionateScreenWidth(radius ?? 10),
              ),
            ),
          ),
        ),
        child: Text(
          text ?? "Click here",
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: textStyle ??
              TextStyle(
                fontSize: getProportionalFontSize(16),
                fontFamily: AppFonts.sansFont600,
                color: AppColors.whiteColor,
              ),
        ),
      ),
    );
  }
}
