// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:unscript_app/home/models/bond_model.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class BondCard extends StatelessWidget {
  BondCard({super.key, required this.model});
  BondModel model;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: UnScriptTheme.backgroundColor,
        border: Border.all(color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth * 0.7,
                child: Text(
                  model.companyName!.split(":").first,
                  overflow: TextOverflow.ellipsis,
                  style: UnScriptTheme.screenText(
                      size: screenWidth / 22,
                      weight: FontWeight.bold,
                      color: UnScriptTheme.nearlyBlue),
                ),
              ),
              Text(
                model.companyName!.split(":").last,
                overflow: TextOverflow.ellipsis,
                style: UnScriptTheme.screenText(
                    size: screenWidth / 22,
                    weight: FontWeight.bold,
                    color: UnScriptTheme.nearlyBlue),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "₹${model.open!}",
                        overflow: TextOverflow.ellipsis,
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 22,
                            weight: FontWeight.bold,
                            color: UnScriptTheme.perfectWhite),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "(${model.change!})",
                        overflow: TextOverflow.ellipsis,
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 29,
                            weight: FontWeight.bold,
                            color: model.change!.contains("-")
                                ? Colors.redAccent
                                : UnScriptTheme.successGreen),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: UnScriptTheme.successGreen,
                            size: screenWidth / 22,
                          ),
                          Text(
                            model.high!.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: UnScriptTheme.screenText(
                                size: screenWidth / 28,
                                weight: FontWeight.bold,
                                color: UnScriptTheme.successGreen),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: screenWidth / 32,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.redAccent,
                            size: screenWidth / 22,
                          ),
                          Text(
                            model.low!.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: UnScriptTheme.screenText(
                                size: screenWidth / 28,
                                weight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Card(
                color: UnScriptTheme.bgTextColor2.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Face value",
                        overflow: TextOverflow.ellipsis,
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 28,
                            weight: FontWeight.bold,
                            color: UnScriptTheme.backgroundColor),
                      ),
                      Text(
                        model.faceValue!.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 22,
                            weight: FontWeight.bold,
                            color: UnScriptTheme.backgroundColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
