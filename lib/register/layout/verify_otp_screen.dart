// ignore_for_file: must_be_immutable, unused_field, unused_local_variable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/app/app.dart';
import 'package:unscript_app/login/models/session_model.dart';
import 'package:unscript_app/register/models/activate_model.dart';
import 'package:unscript_app/register/service/register_service.dart';
import 'package:unscript_app/utils/unscript_theme.dart';
import 'package:lottie/lottie.dart';

class VerifyOtpScreen extends StatefulWidget {
  VerifyOtpScreen({super.key, required this.email});
  String email;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  bool _isLoading = false;
  RegisterService service = RegisterService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: UnScriptTheme.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: UnScriptTheme.nearlyBlue,
          automaticallyImplyLeading: false,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: LottieBuilder.asset("assets/gifs/email.json",
                    height: screenWidth / 2.5, width: screenWidth / 2.5),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 5),
                child: Text(
                  "Verify Email",
                  style: UnScriptTheme.appText(
                      size: screenWidth / 12,
                      weight: FontWeight.bold,
                      isShadow: true),
                ),
              ),
              Text(
                "A verification code has been sent to your email. This code is valid for 15 minutes only.",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 23,
                    weight: FontWeight.w500,
                    isShadow: true,
                    color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _textFieldOTP(
                      first: true,
                      last: false,
                      controller: _controller1,
                      screenWidth: screenWidth),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      controller: _controller2,
                      screenWidth: screenWidth),
                  _textFieldOTP(
                      first: false,
                      last: false,
                      controller: _controller3,
                      screenWidth: screenWidth),
                  _textFieldOTP(
                      first: false,
                      last: true,
                      controller: _controller4,
                      screenWidth: screenWidth),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: screenWidth,
                height: 60,
                child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      String activationCode = _controller1.text +
                          _controller2.text +
                          _controller3.text +
                          _controller4.text;

                      if (activationCode.length == 4) {
                        setState(() {
                          _isLoading = true;
                        });
                        service
                            .activateCode(
                                model: ActivateModel(
                                    email: widget.email,
                                    activationCode: int.parse(activationCode)),
                                context: context)
                            .then((value) async {
                          if (value is SessionModel) {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref
                                .setString('session', value.session!)
                                .then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              _controller1.clear();
                              _controller2.clear();
                              _controller3.clear();
                              _controller4.clear();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return const App();
                              }));
                            });
                          } else {
                            _controller1.clear();
                            _controller2.clear();
                            _controller3.clear();
                            _controller4.clear();
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
                            "Verify",
                            style: UnScriptTheme.screenText(
                                size: screenWidth / 21,
                                weight: FontWeight.bold,
                                color: UnScriptTheme.backgroundColor),
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first,
      last,
      required TextEditingController controller,
      required screenWidth}) {
    return Container(
      height: 80,
      margin: EdgeInsets.only(right: screenWidth / 20),
      child: Center(
        child: AspectRatio(
          aspectRatio: 0.8,
          child: TextField(
            controller: controller,
            autofocus: true,
            onChanged: (value) {
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: false,
            readOnly: false,
            textAlign: TextAlign.center,
            style: UnScriptTheme.appText(size: 20, weight: FontWeight.w600),
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.grey.withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: UnScriptTheme.perfectWhite),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
