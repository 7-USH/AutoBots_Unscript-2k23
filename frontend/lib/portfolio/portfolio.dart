// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/portfolio/ui_view/asset_card.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  IconButton(
                      onPressed: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.clear().then((value) => print(value));
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
                      ))
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
                      "- \$5,157.85",
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
                            "- \$2,13,122.85",
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
                            "- \$2,60,122.85",
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
              ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  shrinkWrap: true,
                  separatorBuilder: (_, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (_, index) {
                    return AssetCard(text1: "", text2: "", text3: "");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
