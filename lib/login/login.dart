// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/app/app.dart';
import 'package:unscript_app/login/layout/forgot_screen.dart';
import 'package:unscript_app/login/models/login_model.dart';
import 'package:unscript_app/login/models/session_model.dart';
import 'package:unscript_app/login/service/login_service.dart';
import 'package:unscript_app/register/register.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginService service = LoginService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hey",
                  style: UnScriptTheme.screenText(
                      size: screenWidth / 3.5,
                      weight: FontWeight.bold,
                      letterSpacing: 2,
                      isShadow: true,
                      color: UnScriptTheme.nearlyBlue),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Welcome back,",
                  style: UnScriptTheme.appText(
                      size: screenWidth / 12,
                      weight: FontWeight.bold,
                      isShadow: true,
                      color: UnScriptTheme.perfectWhite),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "We're happy to see you here again. Enter your email address and password",
                  style: UnScriptTheme.screenText(
                      size: screenWidth / 23,
                      weight: FontWeight.w500,
                      isShadow: true,
                      color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: UnScriptTheme.screenText(
                          size: 16, weight: FontWeight.w500),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter email";
                        } else if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value.trim() )) {
                          return "Email is not valid";
                        }
                        return null;
                      },
                      decoration: UnScriptTheme.faInputDecoration(
                        hint: "Email",
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: UnScriptTheme.screenText(
                          size: 16, weight: FontWeight.w500),
                      obscureText: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                      decoration: UnScriptTheme.faInputDecoration(
                        hint: "Password",
                        fontSize: 16,
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
                              service
                                  .loginUser(
                                      context: context,
                                      model: LoginModel(
                                          username: emailController.text.trim(),
                                          password: passwordController.text))
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
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return const App();
                                    }));
                                  });
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              });
                            }
                          },
                          style: UnScriptTheme.buttonStyle(
                              backColor: UnScriptTheme.nearlyBlue),
                          child: _isLoading
                              ? Center(
                                  child: SizedBox(
                                    height: screenWidth / 20,
                                    width: screenWidth / 20,
                                    child: const CircularProgressIndicator(
                                      color: UnScriptTheme.perfectWhite,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                )
                              : Text(
                                  "Log In",
                                  style: UnScriptTheme.screenText(
                                      size: screenWidth / 21,
                                      weight: FontWeight.bold),
                                )),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const ForgotScreen();
                    }));
                  },
                  child: Text(
                    "Forgot password?",
                    style: UnScriptTheme.appText(
                        size: screenWidth / 25,
                        weight: FontWeight.w500,
                        isShadow: true,
                        color: UnScriptTheme.perfectWhite),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 1.2,
                        color: UnScriptTheme.bgTextColor2.withOpacity(0.6),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "or",
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 29,
                            weight: FontWeight.w500,
                            color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1.2,
                        color: UnScriptTheme.bgTextColor2.withOpacity(0.6),
                      ),
                    ),
                  ]),
              SizedBox(
                height: screenWidth / 10,
              ),
              SizedBox(
                width: screenWidth,
                height: 60,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const Register();
                      }));
                    },
                    style: UnScriptTheme.buttonStyle(
                        backColor: UnScriptTheme.bgTextColor2),
                    child: Text(
                      "Create an Account",
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
}
