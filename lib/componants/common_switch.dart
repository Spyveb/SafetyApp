import 'package:distress_app/config/size_config.dart';
import 'package:distress_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CommonSwitch extends StatelessWidget {
  final bool value;
  final Function(bool)? onChanged;
  const CommonSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: AppColors.blackColor,
      trackOutlineColor: MaterialStateProperty.all(
        AppColors.blackColor,
      ),
      inactiveTrackColor: Colors.transparent,
      inactiveThumbColor: AppColors.blackColor,
      activeTrackColor: Colors.transparent,
      trackOutlineWidth: MaterialStateProperty.all(
        getProportionateScreenWidth(3),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
