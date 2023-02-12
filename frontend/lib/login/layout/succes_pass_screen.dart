import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:unscript_app/login/login.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class SuccessPassScreen extends StatefulWidget {
  const SuccessPassScreen({super.key});

  @override
  State<SuccessPassScreen> createState() => _SuccessPassScreenState();
}

class _SuccessPassScreenState extends State<SuccessPassScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: UnScriptTheme.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LottieBuilder.asset(
                "assets/gifs/pass_reset_success.json",
                frameRate: FrameRate.max,
                repeat: false,
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.width / 1.2,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 40),
              child: Text(
                "Password reset \nsuccessfully!",
                textAlign: TextAlign.center,
                style: UnScriptTheme.screenText(
                    size: MediaQuery.of(context).size.width / 16,
                    color: UnScriptTheme.bgTextColor2.withOpacity(0.6),
                    weight: FontWeight.w600),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return const Login();
                  }));
                },
                style: UnScriptTheme.buttonStyle(
                    backColor: UnScriptTheme.nearlyBlue),
                child: Text(
                  "Go to Login",
                  style: UnScriptTheme.screenText(
                      size: MediaQuery.of(context).size.width / 21,
                      weight: FontWeight.bold,
                      color: UnScriptTheme.backgroundColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
