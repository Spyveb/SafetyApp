import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  late bool _isDarkTheme;
  ThemeData _themeData = ThemeData.dark();
  Color _backgroundColor = AppColors.whiteColor;
  Color textColor = AppColors.textColor;
  Color lightTextColor = AppColors.lightTextColor;

  ColorScheme _colorScheme = const ColorScheme.light(primary: AppColors.primaryColor);
  bool _useMaterial3 = true;

  ThemeProvider({required bool initialTheme}) {
    _isDarkTheme = initialTheme;
    _loadThemeFromPrefs();
  }

  bool get isDarkTheme => _isDarkTheme;
  ThemeData get themeData => _themeData;
  Color get backgroundColor => _backgroundColor;
  Color get textThemeColor => textColor;
  Color get lightTextThemeColor => textColor;
  ColorScheme get colorScheme => _colorScheme;
  bool get useMaterial3 => _useMaterial3;

  Future<void> _loadThemeFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkTheme = prefs.getBool(Constants.isDarkThemeSelected) ?? _isDarkTheme;
    setTheme(_isDarkTheme ? ThemeData.dark() : ThemeData.light(), notify: false);
  }

  void setTheme(ThemeData themeData, {bool notify = true}) async {
    // Check if the new theme is different from the current one
    if (_themeData != themeData) {
      _themeData = themeData;
      if (themeData == ThemeData.dark()) {
        _isDarkTheme = true;
        _backgroundColor = AppColors.blackColor;
        textColor = AppColors.whiteColor;
        lightTextColor = AppColors.textFieldGreyColor;
        _colorScheme = const ColorScheme.dark(primary: AppColors.primaryColor);
        _useMaterial3 = true;
      } else {
        _isDarkTheme = false;
        _backgroundColor = AppColors.whiteColor;
        textColor = AppColors.textColor;
        lightTextColor = AppColors.lightTextColor;
        _colorScheme = const ColorScheme.dark(primary: AppColors.primaryColor);
        _useMaterial3 = false;
      }

      if (notify) {
        notifyListeners();
        await _saveThemeToPrefs(); // Save theme to shared preferences
      }
    }
  }

  Future<void> _saveThemeToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Constants.isDarkThemeSelected, _isDarkTheme);
  }

  void toggleMaterial3() {
    _useMaterial3 = !_useMaterial3;
    notifyListeners();
  }
}
