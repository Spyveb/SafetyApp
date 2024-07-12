import 'package:flutter/material.dart';

import '../imports.dart';

class CustomCasesList extends StatelessWidget {
  final String? caseNo, date, status, firstName, lastName, location, city;
  const CustomCasesList(
      {super.key, this.caseNo, this.date, this.status, this.firstName, this.lastName, this.location, this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(8),
        vertical: getProportionateScreenHeight(8),
      ),
      margin: EdgeInsets.only(
        bottom: getProportionateScreenHeight(16),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.blackColor,
          )
          // boxShadow: const [
          //   BoxShadow(
          //     color: Colors.black54,
          //     spreadRadius: 0,
          //     blurRadius: 8,
          //     offset: Offset(0.0, 4.0),
          //   ),
          // ],
          ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(100),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.caseNo,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        caseNo ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(100),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.date,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Text(
                      date ?? "",
                      style: TextStyle(
                        fontSize: getProportionalFontSize(14),
                        fontFamily: AppFonts.sansFont400,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(100),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.status,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Text(
                      status ?? "",
                      style: TextStyle(
                        fontSize: getProportionalFontSize(14),
                        fontFamily: AppFonts.sansFont600,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(100),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.firstName,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        firstName ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(100),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.lastName,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        lastName ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(100),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.location,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        location ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minWidth: getProportionateScreenWidth(100),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.city,
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont600,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        city ?? "",
                        style: TextStyle(
                          fontSize: getProportionalFontSize(14),
                          fontFamily: AppFonts.sansFont400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CommonButton(
            width: getProportionateScreenWidth(100),
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(4),
              vertical: getProportionateScreenHeight(4),
            ),
            radius: 50,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: getProportionalFontSize(13),
              fontFamily: AppFonts.sansFont600,
            ),
            onPressed: () {},
            text: "View case",
          )
        ],
      ),
    );
  }
}
