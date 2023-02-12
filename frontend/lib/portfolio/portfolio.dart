// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unscript_app/home/models/profile_details_model.dart';
import 'package:unscript_app/portfolio/layouts/my_aadhaar.dart';
import 'package:unscript_app/portfolio/models/asset_model.dart';
import 'package:unscript_app/portfolio/service/portfolio_service.dart';
import 'package:unscript_app/portfolio/ui_view/asset_card.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class Portfolio extends StatefulWidget {
  Portfolio({Key? key, required this.model}) : super(key: key);
  ProfileDetailsModel model;

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  PortFolioService service = PortFolioService();
  late Future<List<AssetModel>> _future;
  double investment = 0;

  @override
  void initState() {
    getFuture();
    super.initState();
  }

  Future<void> getFuture() async {
    setState(() {
      _future = service.getAssets(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: getFuture,
      child: Scaffold(
        backgroundColor: UnScriptTheme.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My',
                          style: UnScriptTheme.screenText(
                              size: screenWidth / 6,
                              weight: FontWeight.bold,
                              color: UnScriptTheme.nearlyBlue),
                        ),
                        Text(
                          'Portfolio',
                          style: UnScriptTheme.screenText(
                              size: screenWidth / 10,
                              weight: FontWeight.bold,
                              color: UnScriptTheme.perfectWhite),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                            onPressed: () async {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: MyAadhaar(
                                  model: widget.model,
                                ),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.scale,
                              );
                            },
                            icon: Container(
                              height: screenWidth / 8,
                              width: screenWidth / 8,
                              decoration: BoxDecoration(
                                  color: UnScriptTheme.perfectWhite,
                                  borderRadius:
                                      BorderRadius.circular(screenWidth / 16)),
                              child: const Icon(
                                Icons.settings,
                                color: UnScriptTheme.backgroundColor,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Track your portfolio in realtime',
                      style: UnScriptTheme.appText(
                          size: screenWidth / 20,
                          weight: FontWeight.bold,
                          color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
                    )),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "PROFIT & LOSS",
                    style: UnScriptTheme.appText(
                        size: screenWidth / 22, weight: FontWeight.bold),
                  ),
                ),
                Chip(
                  padding: const EdgeInsets.all(10),
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "- ₹5,157.85",
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 22,
                            letterSpacing: 0.1,
                            isShadow: true,
                            weight: FontWeight.bold,
                            color: UnScriptTheme.backgroundColor),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "(-1.95%)",
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 30,
                            isShadow: true,
                            weight: FontWeight.bold,
                            color: UnScriptTheme.backgroundColor),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.redAccent,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "INVESTMENT",
                              style: UnScriptTheme.appText(
                                  size: screenWidth / 22,
                                  weight: FontWeight.bold),
                            ),
                          ),
                          Chip(
                            padding: const EdgeInsets.all(10),
                            label: Text(
                              "₹2,13,122.85",
                              style: UnScriptTheme.screenText(
                                  letterSpacing: 0.1,
                                  size: screenWidth / 28,
                                  isShadow: true,
                                  weight: FontWeight.bold,
                                  color: UnScriptTheme.backgroundColor),
                            ),
                            backgroundColor: UnScriptTheme.nearlyBlue,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "DEPOSIT",
                              style: UnScriptTheme.appText(
                                  size: screenWidth / 22,
                                  weight: FontWeight.bold),
                            ),
                          ),
                          Chip(
                            padding: const EdgeInsets.all(10),
                            label: Text(
                              "₹2,60,122.85",
                              style: UnScriptTheme.screenText(
                                  letterSpacing: 0.1,
                                  size: screenWidth / 28,
                                  isShadow: true,
                                  weight: FontWeight.bold,
                                  color: UnScriptTheme.backgroundColor),
                            ),
                            backgroundColor:
                                UnScriptTheme.bgTextColor2.withOpacity(0.6),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 20),
                  child: Text(
                    "My Asset's",
                    style: UnScriptTheme.screenText(
                        size: screenWidth / 13,
                        weight: FontWeight.bold,
                        color: UnScriptTheme.nearlyBlue),
                  ),
                ),
                FutureBuilder(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemBuilder: (_, index) {
                              return AssetCard(
                                model: snapshot.data![index],
                              );
                            });
                      } else {
                        return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            separatorBuilder: (_, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemBuilder: (_, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade400,
                                highlightColor: UnScriptTheme.perfectWhite,
                                direction: ShimmerDirection.rtl,
                                child: Container(
                                  height: screenWidth / 3.5,
                                  decoration: BoxDecoration(
                                      color: UnScriptTheme.nearlyWhite,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              );
                            });
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
