// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/app/app.dart';
import 'package:unscript_app/login/login.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({super.key, required this.text, required this.statusCode});
  String text;
  int statusCode;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: UnScriptTheme.backgroundColor,
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    LottieBuilder.asset(
                      "assets/gifs/error.json",
                      height: screenWidth / 2,
                      width: screenWidth / 2,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "{ Error $statusCode }",
                        textAlign: TextAlign.center,
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 15, weight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: UnScriptTheme.appText(
                          size: screenWidth / 20,
                          color: UnScriptTheme.bgTextColor2,
                          weight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: screenWidth,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          if (statusCode >= 500) {
                            pref.clear().then((value) {
                              if (value) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              }
                            });
                          } else {
                            await Navigator.of(context, rootNavigator: true)
                                .pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const App(),
                              ),
                            );
                          }
                        },
                        style: UnScriptTheme.buttonStyle(
                            backColor: UnScriptTheme.nearlyBlue),
                        child: Text(
                        statusCode >= 500 ? "Head Login" : "Go Home",
                          style: UnScriptTheme.screenText(
                              size: screenWidth / 21, weight: FontWeight.bold),
                        )),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
