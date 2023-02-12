// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unscript_app/trade/models/buy_bonds_models.dart';
import 'package:unscript_app/trade/service/trade_service.dart';
import 'package:unscript_app/trade/ui_view/trade_card.dart';
import 'package:unscript_app/utils/unscript_theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Trade extends StatefulWidget {
  const Trade({super.key});

  @override
  State<Trade> createState() => _TradeState();
}

class _TradeState extends State<Trade> {
  late Timer _timer;
  TradeServie service = TradeServie();
  late Future<List<BuyBonds>> _future;
  String formattedTime =
      DateFormat("hh:mm a").format(DateTime.now()).toString();
  String formattedDate =
      DateFormat("MMM dd, yyyy").format(DateTime.now()).toString();

  @override
  void initState() {
    setFuture();
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());
    super.initState();
  }

  Future<void> setFuture() async {
    setState(() {
      _future = service.getUserBonds(context: context);
    });
  }

  void _update() {
    setState(() {
      formattedTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
      formattedDate =
          DateFormat("MMM dd, yyyy").format(DateTime.now()).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      onRefresh: setFuture,
      child: Scaffold(
        backgroundColor: UnScriptTheme.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        formattedDate,
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 20, weight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        formattedTime,
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 22,
                            weight: FontWeight.bold,
                            color: UnScriptTheme.nearlyBlue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "What's for",
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 8,
                            weight: FontWeight.bold,
                            color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Today?",
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 8,
                            weight: FontWeight.bold,
                            color: UnScriptTheme.perfectWhite),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return MasonryGridView.count(
                              crossAxisCount: 2,
                              physics: const BouncingScrollPhysics(),
                              mainAxisSpacing: 4,
                              scrollDirection: Axis.vertical,
                              crossAxisSpacing: 4,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return TradeCard(
                                  index: index,
                                  bond_model: snapshot.data![index],
                                  isShimmer: false,
                                );
                              });
                        } else {
                          return MasonryGridView.count(
                              crossAxisCount: 2,
                              physics: const BouncingScrollPhysics(),
                              mainAxisSpacing: 4,
                              scrollDirection: Axis.vertical,
                              crossAxisSpacing: 4,
                              shrinkWrap: true,
                              itemCount: 15,
                              itemBuilder: (context, index) {
                                return TradeCard(
                                  index: index,
                                  isShimmer: true,
                                );
                              });
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
