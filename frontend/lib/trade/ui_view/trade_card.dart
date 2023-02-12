// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unscript_app/trade/models/buy_bonds_models.dart';
import 'package:unscript_app/trade/service/trade_service.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class TradeCard extends StatefulWidget {
  TradeCard(
      {super.key,
      required this.index,
      required this.isShimmer,
      this.bond_model});
  int index;
  bool isShimmer;
  BuyBonds? bond_model;

  @override
  State<TradeCard> createState() => _TradeCardState();
}

class _TradeCardState extends State<TradeCard> {
  TradeServie servie = TradeServie();
  bool _isLoading = false;
  String title = "Buy";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return widget.isShimmer
        ? Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: UnScriptTheme.perfectWhite,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                color: UnScriptTheme.nearlyWhite,
              ),
              height: (widget.index % 4 + 1) * 100,
              width: screenWidth / 2,
              child: Center(
                child: Text(
                  widget.index % 4 == 0 ? "bond" : 'text1',
                  style: UnScriptTheme.screenText(
                    size: screenWidth / 16,
                    weight: FontWeight.w100,
                  ),
                ),
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(20.0),
              ),
              color: widget.index % 4 == 0
                  ? UnScriptTheme.bgTextColor2.withOpacity(0.2)
                  : UnScriptTheme.bgTextColor2.withOpacity(0.1),
            ),
            height: (widget.index % 4 + 1) * 100,
            width: screenWidth / 2,
            child: widget.index % 4 == 0
                ? Center(
                    child: Text(
                      "",
                      style: UnScriptTheme.screenText(
                          size: screenWidth / 16,
                          weight: FontWeight.w600,
                          color: UnScriptTheme.bgTextColor2),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              widget.bond_model!.companyName!.split(":").first,
                              style: UnScriptTheme.screenText(
                                  size: screenWidth / 25,
                                  weight: FontWeight.bold,
                                  color: UnScriptTheme.nearlyBlue),
                            )),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                "₹${widget.bond_model!.bondPrice!}",
                                style: UnScriptTheme.screenText(
                                    size: screenWidth / 20,
                                    weight: FontWeight.bold),
                              ),
                              Text(
                                " (${widget.bond_model!.change})",
                                style: UnScriptTheme.screenText(
                                    size: screenWidth / 32,
                                    color:
                                        widget.bond_model!.change!.contains("-")
                                            ? Colors.redAccent
                                            : UnScriptTheme.successGreen,
                                    weight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        widget.index % 4 != 1
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_upward,
                                            color: UnScriptTheme.successGreen,
                                            size: screenWidth / 22,
                                          ),
                                          Text(
                                            widget.bond_model!.upVal!
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: UnScriptTheme.screenText(
                                                size: screenWidth / 30,
                                                weight: FontWeight.bold,
                                                color:
                                                    UnScriptTheme.successGreen),
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
                                            widget.bond_model!.downVal
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: UnScriptTheme.screenText(
                                                size: screenWidth / 30,
                                                weight: FontWeight.bold,
                                                color: Colors.redAccent),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    width: screenWidth,
                                    child: Card(
                                      color: UnScriptTheme.bgTextColor2
                                          .withOpacity(0.8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
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
                                                  color: UnScriptTheme
                                                      .backgroundColor),
                                            ),
                                            Text(
                                              widget.bond_model!.faceValue!
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: UnScriptTheme.screenText(
                                                  size: screenWidth / 22,
                                                  weight: FontWeight.bold,
                                                  color: UnScriptTheme
                                                      .backgroundColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: screenWidth / 2,
                            child: ElevatedButton(
                                onPressed: title == "Bought"
                                    ? null
                                    : () {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        servie.createBond(
                                            context: context,
                                            requestBody: {
                                              "bond_id": widget.bond_model!.id!,
                                              "requested_price" : widget.bond_model!.bondPrice!,
                                            }).then((value) {
                                          setState(() {
                                            _isLoading = false;
                                            title = "Bought";
                                          });
                                        });
                                      },
                                style: UnScriptTheme.buttonStyle(
                                    backColor: UnScriptTheme.nearlyBlue),
                                child: _isLoading
                                    ? Center(
                                        child: SizedBox(
                                          height: screenWidth / 25,
                                          width: screenWidth / 25,
                                          child:
                                              const CircularProgressIndicator(
                                            color:
                                                UnScriptTheme.backgroundColor,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        title,
                                        style: UnScriptTheme.screenText(
                                            size: screenWidth / 28,
                                            weight: FontWeight.bold,
                                            color: title == "Bought"
                                                ? UnScriptTheme.perfectWhite
                                                : UnScriptTheme
                                                    .backgroundColor),
                                      )),
                          ),
                        )
                      ],
                    ),
                  ));
  }
}
