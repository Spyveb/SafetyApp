import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/providers/theme_provider.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:distress_app/utils/app_fonts.dart';
import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.themeProvider,
    required this.onTap,
    this.text,
    this.suffix,
  });

  final ThemeProvider themeProvider;
  final void Function()? onTap;
  final String? text;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(6),
          horizontal: getProportionateScreenWidth(22),
        ),
        decoration: BoxDecoration(
          color: AppColors.settingsTileBackColor,
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(3),
          ),
          border: Border.all(
            color: AppColors.settingsTileBorderColor,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text ?? '',
                style: TextStyle(
                  fontSize: getProportionalFontSize(16),
                  color: themeProvider.lightTextThemeColor,
                  fontFamily: AppFonts.sansFont500,
                ),
              ),
            ),
            suffix ??
                IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: themeProvider.textThemeColor,
                    size: 24,
                  ),
                )
          ],
        ),
      ),
    );
  }
}
