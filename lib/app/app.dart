// ignore_for_file: prefer_const_literals_to_create_immutables, unused_field, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/login/login.dart';
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
                CupertinoIcons.chat_bubble,
              ),
              inactiveColorPrimary: UnScriptTheme.bgTextColor2,
              activeColorSecondary: UnScriptTheme.perfectWhite,
              activeColorPrimary: UnScriptTheme.bgTextColor2,
              title: "Home",
              textStyle: UnScriptTheme.appText(
                  size: screenWidth / 26, weight: FontWeight.bold)),
          PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.chat_bubble,
              ),
              inactiveColorPrimary: UnScriptTheme.bgTextColor2,
              activeColorSecondary: UnScriptTheme.perfectWhite,
              activeColorPrimary: UnScriptTheme.bgTextColor2,
              title: "Home",
              textStyle: UnScriptTheme.appText(
                  size: screenWidth / 26, weight: FontWeight.bold)),
          PersistentBottomNavBarItem(
              icon: const Icon(
                CupertinoIcons.chat_bubble,
              ),
              inactiveColorPrimary: UnScriptTheme.bgTextColor2,
              activeColorSecondary: UnScriptTheme.perfectWhite,
              activeColorPrimary: UnScriptTheme.bgTextColor2,
              title: "Home",
              textStyle: UnScriptTheme.appText(
                  size: screenWidth / 26, weight: FontWeight.bold)),
        ],
        decoration: NavBarDecoration(
            border: Border(
                top: BorderSide(
                    color: UnScriptTheme.bgTextColor2.withOpacity(0.6)))),
        screens: [
          Scaffold(
            body: Center(
              child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.clear().then((value) {
                      if (value) {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return Login();
                        }));
                      }
                    });
                  },
                  child: Text("Clear")),
            ),
          ),
          const Scaffold(),
          const Scaffold()
        ],
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
