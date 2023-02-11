import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hello, \nTushar",
                    style: UnScriptTheme.screenText(
                        size: screenWidth / 11, weight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Container(
                        height: screenWidth / 8,
                        width: screenWidth / 8,
                        decoration: BoxDecoration(
                            color: UnScriptTheme.perfectWhite,
                            borderRadius:
                                BorderRadius.circular(screenWidth / 16)),
                        child: const Icon(
                          Icons.notifications,
                          color: UnScriptTheme.backgroundColor,
                        ),
                      ))
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Balance",
                    style: UnScriptTheme.appText(
                        size: screenWidth / 16,
                        weight: FontWeight.w600,
                        color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
                  ),
                  Text(
                    "\$24,087.43",
                    style: UnScriptTheme.screenText(
                        size: screenWidth / 10,
                        weight: FontWeight.bold,
                        color: UnScriptTheme.nearlyBlue),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: UnScriptTheme.buttonStyle(
                          backColor: UnScriptTheme.bgTextColor2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.arrowLeftLong,
                            color: UnScriptTheme.backgroundColor,
                          ),
                          Text(
                            "Withdraw",
                            style: UnScriptTheme.screenText(
                                size: screenWidth / 20,
                                weight: FontWeight.bold,
                                color: UnScriptTheme.backgroundColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: UnScriptTheme.buttonStyle(
                          backColor: UnScriptTheme.nearlyBlue),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.arrowRightLong,
                            color: UnScriptTheme.perfectWhite,
                          ),
                          Text(
                            "Deposit",
                            style: UnScriptTheme.screenText(
                              size: screenWidth / 20,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
