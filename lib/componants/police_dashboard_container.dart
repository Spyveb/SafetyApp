import 'package:flutter/material.dart';

import '../imports.dart';

class PoliceDashboardContainer extends StatelessWidget {
  final String? title, value;
  const PoliceDashboardContainer({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(14),
        vertical: getProportionateScreenHeight(14),
      ),
      height: getProportionateScreenHeight(165),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          getProportionateScreenWidth(16),
        ),
        border: Border.all(
          color: AppColors.policeDarkBlueColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: getProportionalFontSize(19),
              fontFamily: AppFonts.sansFont600,
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Spacer(),
          Text(
            value ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: getProportionalFontSize(25),
              fontFamily: AppFonts.sansFont600,
              color: AppColors.policeDarkBlueColor,
            ),
          ),
        ],
      ),
    );
  }
}
