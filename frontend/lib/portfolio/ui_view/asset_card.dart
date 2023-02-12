// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:unscript_app/portfolio/models/asset_model.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class AssetCard extends StatelessWidget {
  AssetCard({Key? key, required this.model}) : super(key: key);

  AssetModel model;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Badge(
      label: Text(
        model.bondDetails!.available! ? "public" : "private",
        style: UnScriptTheme.screenText(size: screenWidth / 34, weight: FontWeight.w600),
      ),
      backgroundColor: model.bondDetails!.available!
          ? UnScriptTheme.successGreen
          : Colors.redAccent,
      child: Container(
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
                SizedBox(
                  width: screenWidth / 4,
                  child: Text(
                    model.bondDetails!.companyName!.split(":").first,
                    style: UnScriptTheme.screenText(
                        size: screenWidth / 23,
                        weight: FontWeight.w600,
                        color: UnScriptTheme.perfectWhite),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "₹${model.bondDetails!.bondPrice!}",
                  style: UnScriptTheme.screenText(
                      size: screenWidth / 23,
                      letterSpacing: 0.1,
                      weight: FontWeight.w600,
                      color: UnScriptTheme.successGreen),
                ),
                Text(
                  model.bondDetails!.change!,
                  style: UnScriptTheme.appText(
                      size: screenWidth / 23,
                      letterSpacing: 0.1,
                      weight: FontWeight.w600,
                      color: model.bondDetails!.change!.contains("-")
                          ? Colors.redAccent
                          : UnScriptTheme.successGreen),
                ),
              ],
            ),
            SizedBox(
              height: screenWidth / 7,
              width: screenWidth / 7,
              child: ElevatedButton(
                  onPressed: () {},
                  style: UnScriptTheme.buttonStyle(
                      backColor: UnScriptTheme.bgTextColor2),
                  child: Text(
                    "Sell",
                    style: UnScriptTheme.screenText(
                        size: screenWidth / 30, weight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
