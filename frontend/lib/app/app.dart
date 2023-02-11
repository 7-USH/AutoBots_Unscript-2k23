// ignore_for_file: prefer_const_literals_to_create_immutables, unused_field, prefer_const_constructors, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:unscript_app/Trade/trade.dart';
import 'package:unscript_app/home/home.dart';
import 'package:unscript_app/news/news.dart';
import 'package:unscript_app/portfolio/portfolio.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: PersistentTabView(
        context,
        backgroundColor: UnScriptTheme.backgroundColor,
        items: [
          PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.home,
              ),
              inactiveColorPrimary: UnScriptTheme.bgTextColor2,
              activeColorSecondary: UnScriptTheme.perfectWhite,
              activeColorPrimary: UnScriptTheme.bgTextColor2,
              title: "Home",
              textStyle: UnScriptTheme.appText(
                  size: screenWidth / 26, weight: FontWeight.bold)),
          PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.news,
              ),
              inactiveColorPrimary: UnScriptTheme.bgTextColor2,
              activeColorSecondary: UnScriptTheme.perfectWhite,
              activeColorPrimary: UnScriptTheme.bgTextColor2,
              title: "News",
              textStyle: UnScriptTheme.appText(
                  size: screenWidth / 26, weight: FontWeight.bold)),
          PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.arrow_right_arrow_left,
              ),
              inactiveColorPrimary: UnScriptTheme.bgTextColor2,
              activeColorSecondary: UnScriptTheme.perfectWhite,
              activeColorPrimary: UnScriptTheme.bgTextColor2,
              title: "Trade",
              textStyle: UnScriptTheme.appText(
                  size: screenWidth / 26, weight: FontWeight.bold)),
          PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.person,
              ),
              inactiveColorPrimary: UnScriptTheme.bgTextColor2,
              activeColorSecondary: UnScriptTheme.perfectWhite,
              activeColorPrimary: UnScriptTheme.bgTextColor2,
              title: "Portfolio",
              textStyle: UnScriptTheme.appText(
                  size: screenWidth / 26, weight: FontWeight.bold)),
        ],
        decoration: NavBarDecoration(
            border: Border(
                top: BorderSide(
                    width: 0.2,
                    color: UnScriptTheme.bgTextColor2.withOpacity(0.6)))),
        screens: [Home(), NewsPage(), TradeScreen(), Portfolio()],
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.easeIn,
        ),
        controller: _controller,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: false,
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}
