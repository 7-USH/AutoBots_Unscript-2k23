// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:unscript_app/login/layout/verify_otp.dart';
import 'package:unscript_app/login/service/login_service.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  LoginService service = LoginService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Remember password? ",
              style: UnScriptTheme.screenText(
                  letterSpacing: 0.2,
                  size: screenWidth / 30,
                  weight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                " Log In",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 30,
                    weight: FontWeight.bold,
                    letterSpacing: 0.2,
                    color: UnScriptTheme.nearlyBlue),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: UnScriptTheme.nearlyBlue,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Uffo!",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 3.5,
                    weight: FontWeight.bold,
                    isShadow: true,
                    color: UnScriptTheme.nearlyBlue),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                "Forgot password?",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 12,
                    weight: FontWeight.bold,
                    isShadow: true,
                    color: UnScriptTheme.perfectWhite),
              ),
            ),
            Text(
              "Don't worry! it occurs. Please enter the email address linked with your account",
              style: UnScriptTheme.screenText(
                  size: screenWidth / 23,
                  weight: FontWeight.w500,
                  isShadow: true,
                  color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                autofocus: true,
                controller: emailController,
                style:
                    UnScriptTheme.screenText(size: 16, weight: FontWeight.w500),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter email";
                  } else if (!RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value.trim())) {
                    return "Email is not valid";
                  }
                  return null;
                },
                decoration: UnScriptTheme.faInputDecoration(
                  hint: "Email",
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: screenWidth,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      service.sendForgotOTP(
                          requestBody: {"email": emailController.text.trim()},
                          context: context).then((value) {
                        if (value) {
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return VerifyOTPPage(email: emailController.text);
                          }));
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      });
                    }
                  },
                  style: UnScriptTheme.buttonStyle(
                      backColor: UnScriptTheme.bgTextColor2),
                  child: _isLoading
                      ? Center(
                          child: SizedBox(
                            height: screenWidth / 20,
                            width: screenWidth / 20,
                            child: const CircularProgressIndicator(
                              color: UnScriptTheme.backgroundColor,
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      : Text(
                          "Send Verification Code",
                          style: UnScriptTheme.screenText(
                              size: screenWidth / 21,
                              weight: FontWeight.bold,
                              color: UnScriptTheme.backgroundColor),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
