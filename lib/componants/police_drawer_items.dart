import 'package:distress_app/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PoliceDrawerItems extends StatelessWidget {
  final String? itemName, imageName;
  final void Function()? onTap;
  final double? bottom;
  const PoliceDrawerItems({super.key, this.itemName, this.imageName, this.onTap, this.bottom});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: bottom ?? 0,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              imageName ?? AppImages.policeDashboard,
              height: getProportionateScreenHeight(32),
              width: getProportionateScreenWidth(32),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Flexible(
              child: Text(
                itemName ?? "Dashboard",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: AppFonts.sansFont600,
                  fontSize: getProportionalFontSize(18),
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
