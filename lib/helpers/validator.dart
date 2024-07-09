import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';

// Validation class containing various validation functions.
class Validation {
  // Validate email format.
  static String? emailValidation(String? value, String? fieldName, BuildContext context) {
    if (value!.isEmpty) {
      return "${AppLocalizations.of(context)!.pleaseEnter} $fieldName";
    }
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    if (!regExp.hasMatch(value)) {
      return "${AppLocalizations.of(context)!.pleaseEnterAValid} $fieldName";
    }

    if (value.length > 50) {
      return AppLocalizations.of(context)!.shouldNotBeGreaterThan;
    }
    return null;
  }

  // Validate alphanumeric format.
  static String? alphaNumericValidation(String? value, String? fieldName, BuildContext context) {
    if (value!.isEmpty) {
      return "${AppLocalizations.of(context)!.pleaseEnter} $fieldName";
    }
    RegExp regExp = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!regExp.hasMatch(value)) {
      return "${AppLocalizations.of(context)!.pleaseEnterAValid} $fieldName";
    }

    if (value.length > 20) {
      return AppLocalizations.of(context)!.shouldNotBeGreaterThan;
    }
    return null;
  }

  // Validate if field is empty.
  static String? emptyValidation(String? value, BuildContext context, String? fieldName) {
    if (value!.isEmpty) {
      return "${AppLocalizations.of(context)!.pleaseEnter} ${fieldName}";
    }

    return null;
  }

  // // Validate userName.
  // static String? userNameValidation(String? value, BuildContext context, String? fieldName) {
  //   if (value == null || value.isEmpty) {
  //     return "${AppLocalizations.of(context)!.pleaseEnter} ${fieldName}";
  //   }
  //   // RegExp regExp = RegExp(r'^[+][0-9]+$');
  //   RegExp regExp = RegExp(r'^[a-zA-Z0-9_\-@]+$');
  //
  //   if (!regExp.hasMatch(value)) {
  //     return "${AppLocalizations.of(context)!.pleaseEnterAValid} $fieldName";
  //   }
  //   return null;
  // }

  // Validate if field is empty and mobile number with country code.
  static String? mobileValidationWithCode(String? value, BuildContext context, String? fieldName) {
    if (value!.isEmpty) {
      return "${AppLocalizations.of(context)!.pleaseEnter} ${fieldName}";
    }
    RegExp regExp = RegExp(r'^[0-9]+$');
    // RegExp regExp = RegExp(r'^[0-9]+$');

    if (!regExp.hasMatch(value)) {
      return "${AppLocalizations.of(context)!.pleaseEnterAValid} $fieldName";
    }
    return null;
  }

  // Validate username.
  static String? userNameValidation(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return AppLocalizations.of(context)!.pleaseEnterYourUserName;
    }
    RegExp regExp = RegExp(r'^[a-zA-Z0-9_\-=@]+$');
    if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context)!.youEnteredAnInvalidUserName;
    }
    return null;
  }

  // Check if string contains at least one uppercase character.
  static bool? minimumOneUpperCase(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return false;
    }
    RegExp regExp = RegExp(r'^(?=.*?[A-Z])');
    return regExp.hasMatch(value);
  }

  // Check if string is a username.
  static bool? isUserName(String? value) {
    if (value!.isEmpty) {
      return false;
    }
    return RegExp(r'^[a-zA-Z]').hasMatch(value);
  }

  // Check if string contains at least one lowercase character.
  static bool? minimumOneLowerCase(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return false;
    }
    RegExp regExp = RegExp(r'^(?=.*?[a-z])');
    return regExp.hasMatch(value);
  }

  // Check if string has minimum length of eight characters.
  static bool? minimumEightChars(String? value, BuildContext context) {
    if (value!.isEmpty) {
      return false;
    }
    RegExp regExp = RegExp(r'^.{8,}');
    return regExp.hasMatch(value);
  }

  // Check if string is numeric.
  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}
