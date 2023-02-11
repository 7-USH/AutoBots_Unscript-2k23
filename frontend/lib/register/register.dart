// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:unscript_app/register/layout/verify_otp_screen.dart';
import 'package:unscript_app/register/models/register_model.dart';
import 'package:unscript_app/register/service/register_service.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  RegisterService service = RegisterService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
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
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sign",
                style: UnScriptTheme.screenText(
                    letterSpacing: 2,
                    size: screenWidth / 6,
                    weight: FontWeight.bold,
                    isShadow: true,
                    color: UnScriptTheme.nearlyBlue),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Up.",
                style: UnScriptTheme.screenText(
                    size: screenWidth / 6,
                    letterSpacing: 2,
                    weight: FontWeight.bold,
                    isShadow: true,
                    color: UnScriptTheme.bgTextColor2),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(bottom: 10, top: 5),
              child: Text(
                "Create an account",
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
                "Create your account, it takes less than a minute. Enter your email and password",
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
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter name";
                      } else if (value.length < 8) {
                        return "Name should be atleast 8 characters long";
                      }
                      return null;
                    },
                    decoration: UnScriptTheme.faInputDecoration(
                      hint: "Name",
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: UnScriptTheme.screenText(
                        size: 16, weight: FontWeight.w500),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      } else if (!RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                          .hasMatch(value)) {
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
                                .registerUser(
                                    context: context,
                                    model: RegisterModel(
                                        fullName: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text))
                                .onError((error, stackTrace) {
                              setState(() {
                                _isLoading = false;
                              });
                            }).then((value) {
                              setState(() {
                                _isLoading = false;
                              });
                              if (value is RegisterModel) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) {
                                  return VerifyOtpScreen(
                                      email: emailController.text);
                                }));
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
                                "Create an Account",
                                style: UnScriptTheme.screenText(
                                    size: screenWidth / 21,
                                    weight: FontWeight.bold),
                              )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
