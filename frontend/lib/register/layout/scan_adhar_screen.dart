// ignore_for_file: must_be_immutable, unnecessary_null_comparison, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/register/layout/verify_otp_screen.dart';
import 'package:unscript_app/register/models/register_model.dart';
import 'package:unscript_app/register/service/register_service.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class ScanAdharScreen extends StatefulWidget {
  ScanAdharScreen({super.key, required this.email, required this.password});
  String email;
  String password;
  @override
  State<ScanAdharScreen> createState() => _ScanAdharScreenState();
}

class _ScanAdharScreenState extends State<ScanAdharScreen> {
  late File _frontImage;
  late File _backImage;

  bool frontBool = false;
  bool backBool = false;

  String front = "F R O N T";
  String back = "B A C K";

  RegisterService service = RegisterService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: UnScriptTheme.backgroundColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: screenWidth,
            height: 60,
            child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  if (_backImage != null && _frontImage != null) {
                    setState(() {
                      _isLoading = true;
                    });
                    service
                        .registerUser(
                            context: context,
                            model: RegisterModel(
                                email: widget.email,
                                device_token: preferences.getString("device_token"),
                                password: widget.password,
                                aadhaar_image_back:
                                    base64Encode(_backImage.readAsBytesSync()),
                                aadhaar_image_front: base64Encode(
                                    _frontImage.readAsBytesSync())))
                        .then((value) {
                      if (value is RegisterModel) {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) {
                          return VerifyOtpScreen(email: widget.email);
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
                        "Create an Account",
                        style: UnScriptTheme.screenText(
                            size: screenWidth / 21,
                            weight: FontWeight.bold,
                            color: UnScriptTheme.backgroundColor),
                      )),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 6),
                child: Text(
                  "KYC Verification",
                  style: UnScriptTheme.screenText(
                      size: screenWidth / 12, weight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Take front and rear image of your aadhaar card.",
                  style: UnScriptTheme.screenText(
                      size: screenWidth / 23,
                      weight: FontWeight.w600,
                      isShadow: true,
                      color: UnScriptTheme.bgTextColor2.withOpacity(0.6)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "1. Front Image of Aadhaar",
                  style: UnScriptTheme.screenText(
                      size: screenWidth / 23,
                      weight: FontWeight.w600,
                      isShadow: true,
                      color: UnScriptTheme.perfectWhite),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: !frontBool
                        ? Container(
                            height: screenWidth / 2,
                            width: screenWidth * 0.6,
                            decoration: BoxDecoration(
                                color:
                                    UnScriptTheme.bgTextColor2.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        : Container(
                            clipBehavior: Clip.antiAlias,
                            height: screenWidth / 2,
                            width: screenWidth * 0.6,
                            decoration: BoxDecoration(
                                color:
                                    UnScriptTheme.bgTextColor2.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.file(
                              _frontImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: screenWidth / 2,
                    child: ElevatedButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          XFile? file = await _picker.pickImage(
                              source: ImageSource.camera);

                          setState(() {
                            _frontImage = File(file!.path);
                            frontBool = true;
                          });
                        },
                        style: UnScriptTheme.buttonStyle(
                            backColor: UnScriptTheme.bgTextColor2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera,
                              color: UnScriptTheme.backgroundColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            for (String c in front.split(" "))
                              Text(
                                c,
                                style: UnScriptTheme.screenText(
                                    size: screenWidth / 25,
                                    color: UnScriptTheme.backgroundColor,
                                    weight: FontWeight.bold),
                              )
                          ],
                        )),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "2. Back Image of Aadhaar",
                  style: UnScriptTheme.screenText(
                      size: screenWidth / 23,
                      weight: FontWeight.w600,
                      isShadow: true,
                      color: UnScriptTheme.perfectWhite),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: !backBool
                        ? Container(
                            clipBehavior: Clip.antiAlias,
                            height: screenWidth / 2,
                            width: screenWidth * 0.6,
                            decoration: BoxDecoration(
                                color:
                                    UnScriptTheme.bgTextColor2.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20)),
                          )
                        : Container(
                            height: screenWidth / 2,
                            clipBehavior: Clip.antiAlias,
                            width: screenWidth * 0.6,
                            decoration: BoxDecoration(
                                color:
                                    UnScriptTheme.bgTextColor2.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.file(
                              _backImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: screenWidth / 2,
                    child: ElevatedButton(
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          XFile? file = await _picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {
                            _backImage = File(file!.path);
                            backBool = true;
                          });
                        },
                        style: UnScriptTheme.buttonStyle(
                            backColor: UnScriptTheme.bgTextColor2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera,
                              color: UnScriptTheme.backgroundColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            for (String c in back.split(" "))
                              Text(
                                c,
                                style: UnScriptTheme.screenText(
                                    size: screenWidth / 25,
                                    color: UnScriptTheme.backgroundColor,
                                    weight: FontWeight.bold),
                              )
                          ],
                        )),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
