import 'package:flutter/material.dart';

import '../imports.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget? child;
  const BackgroundWidget({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: Container(
        //     height: getProportionateScreenHeight(120),
        //     width: getProportionateScreenWidth(120),
        //     color: AppColors.amberColor,
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 300, sigmaY: 300),
        //     child: Container(
        //       height: getProportionateScreenHeight(120),
        //       width: getProportionateScreenWidth(120),
        //       color: Colors.transparent,
        //     ),
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: Container(
        //     height: getProportionateScreenHeight(120),
        //     width: getProportionateScreenWidth(120),
        //     color: AppColors.primaryColor,
        //   ),
        // ),
        // Align(
        //   alignment: Alignment.topRight,
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 300, sigmaY: 300),
        //     child: Container(
        //       height: getProportionateScreenHeight(120),
        //       width: getProportionateScreenWidth(120),
        //       color: Colors.transparent,
        //     ),
        //   ),
        // ),

        Container(
          height: SizeConfig.deviceHeight,
          width: SizeConfig.deviceWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 0.1,
              image: AssetImage(AppImages.commonBackground),
            ),
          ),
        ),
        child ?? SizedBox(),
      ],
    );
  }
}
