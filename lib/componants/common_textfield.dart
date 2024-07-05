// Importing necessary packages and files.
import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// A custom text field widget commonly used throughout the application.
class CommonTextField extends StatefulWidget {
  final String? lableText; // Label text for the text field.
  final String? hintText; // Label text for the text field.
  final String? initialValue; // Initial value of the text field.
  final FormFieldValidator<String>? validation; // Validation function for the text field.
  final Widget? suffix; // Suffix widget for the text field.
  final Widget? prefixIcon; // Prefix widget for the text field.
  final Widget? prefix; // Prefix widget for the text field.
  final TextEditingController? textEditingController; // Controller for the text field.
  final bool? obscure; // Whether the text should be obscured.
  final TextInputType? keyboardType; // Keyboard type for the text field.
  final TextInputAction? textInputAction; // Text input action for the text field.
  final bool? readOnly; // Whether the text field is read-only.
  bool? filled;
  final Color? floatingLableColor, fillColor; // Colors for the text field.
  final GestureTapCallback? onTap; // Callback function when the text field is tapped.
  final Function(String)? onChanged; // Callback function when the text field value changes.
  final TextCapitalization? textCapitalization; // Callback function when the text field value changes.
  final List<TextInputFormatter>? inputFormatters; // TextInputFormatters

  // Constructor for the CommonTextField widget.
  CommonTextField({
    Key? key, // Unique key to identify this widget.
    this.lableText, // Label text for the text field.
    this.hintText, // Label text for the text field.
    this.initialValue, // Initial value of the text field.
    this.validation, // Validation function for the text field.
    this.textEditingController, // Controller for the text field.
    this.obscure, // Whether the text should be obscured.
    this.keyboardType, // Keyboard type for the text field.
    this.textInputAction, // Text input action for the text field.
    this.suffix, // Suffix widget for the text field.
    this.prefixIcon, // Prefix widget for the text field.
    this.prefix, // Prefix widget for the text field.
    this.readOnly, // Whether the text field is read-only.
    this.onTap, // Callback function when the text field is tapped.
    this.onChanged, // Callback function when the text field value changes.
    this.floatingLableColor, // Color of the floating label.
    this.filled = false, // Whether the text field is filled.
    this.fillColor, // Fill color of the text field.
    this.textCapitalization, // TextCapitalization of the text field.
    this.inputFormatters, // TextInputFormatters of the text field.
  }) : super(key: key);

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    // Return a TextFormField widget with specified configurations.
    return TextFormField(
      initialValue: widget.initialValue,
      autocorrect: false,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      controller: widget.textEditingController,
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      style: TextStyle(
        fontFamily: AppFonts.sansFont400,
        fontSize: getProportionalFontSize(14),
        color: Colors.black87,
      ),
      validator: widget.validation,
      inputFormatters: widget.inputFormatters,
      obscureText: widget.obscure ?? false,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefixIcon,
        prefix: widget.prefix,

        filled: widget.filled,
        fillColor: widget.fillColor,
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(10),
          ),
          borderSide: BorderSide(color: AppColors.textFieldGreyColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(10),
          ),
          borderSide: BorderSide(color: Colors.black87, width: 1.5),
        ),
        // labelText: widget.lableText,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: AppFonts.sansFont400,
          fontSize: getProportionalFontSize(14),
          color: AppColors.textFieldGreyColor,
        ),
        errorStyle: TextStyle(
          fontSize: getProportionalFontSize(12),
          fontFamily: AppFonts.sansFont400,
          color: AppColors.redDefault,
        ),
        // floatingLabelStyle: TextStyle(
        //   fontFamily: AppFonts.sansFont500,
        //   fontSize: getProportionalFontSize(14),
        //   color: Colors.black87,
        // ),
        // labelStyle: TextStyle(
        //   fontFamily: AppFonts.sansFont400,
        //   fontSize: getProportionalFontSize(14),
        //   color: AppColors.textFieldGreyColor,
        // ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(16),
          vertical: getProportionateScreenHeight(20),
        ),
      ),
    );
  }
}
