// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class AssetCard extends StatelessWidget {
  String text1, text2, text3;
  AssetCard({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: UnScriptTheme.backgroundColor,
          border:
              Border.all(color: UnScriptTheme.bgTextColor2.withOpacity(0.6))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NVDA",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 23,
                    weight: FontWeight.w600,
                    color: UnScriptTheme.perfectWhite),
              ),
              Text(
                "Nvidia",
                style: UnScriptTheme.appText(
                    size: screenWidth / 23,
                    weight: FontWeight.w600,
                    color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "25.94",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 23,
                    letterSpacing: 0.1,
                    weight: FontWeight.w600,
                    color: UnScriptTheme.successGreen),
              ),
              Text(
                "⬆ 0.14%",
                style: UnScriptTheme.appText(
                    size: screenWidth / 23,
                    letterSpacing: 0.1,
                    weight: FontWeight.w600,
                    color: UnScriptTheme.successGreen),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$227.26",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 23,
                    letterSpacing: 0.1,
                    weight: FontWeight.w600,
                    color: UnScriptTheme.nearlyBlue),
              ),
              Text(
                "10 shares",
                style: UnScriptTheme.appText(
                    size: screenWidth / 26,
                    letterSpacing: 0.1,
                    weight: FontWeight.w600,
                    color: UnScriptTheme.nearlyBlue.withOpacity(0.6)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
