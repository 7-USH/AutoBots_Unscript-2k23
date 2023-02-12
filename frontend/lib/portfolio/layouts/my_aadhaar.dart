// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/home/models/profile_details_model.dart';
import 'package:unscript_app/login/login.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class MyAadhaar extends StatefulWidget {
  MyAadhaar({required this.model});

  ProfileDetailsModel model;
  @override
  _MyAadhaarState createState() => _MyAadhaarState();
}

class _MyAadhaarState extends State<MyAadhaar> {
  var inputFormat = DateFormat('yyyy-mm-dd');

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: UnScriptTheme.nearlyBlue,
        elevation: 0.0,
        actions: [
          IconButton(
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
              icon: Container(
                height: screenWidth / 12,
                width: screenWidth / 12,
                decoration: BoxDecoration(
                    color: UnScriptTheme.perfectWhite,
                    borderRadius: BorderRadius.circular(screenWidth / 24)),
                child: const Icon(
                  FontAwesomeIcons.powerOff,
                  color: UnScriptTheme.backgroundColor,
                ),
              )),
        ],
        title: Text(
          "My Aadhaar",
          style: UnScriptTheme.screenText(
            size: screenWidth / 17,
            weight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: UnScriptTheme.backgroundColor),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 7),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                    bottom: Radius.circular(0)),
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Text(
                                'Front',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                              height: 257,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(0),
                                    bottom: Radius.circular(20)),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        height: 50,
                                        width: 50,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            // orange rectangle box
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 30, 5),
                                            height: 15,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(0),
                                                      right:
                                                          Radius.circular(100)),
                                              color: Colors.orange,
                                            ),
                                            child: Text(
                                              'Bharat Sarkar',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            // green rectangle box
                                            height: 15,
                                            width: 200,
                                            margin: EdgeInsets.fromLTRB(
                                                20, 0, 0, 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(0),
                                                      right:
                                                          Radius.circular(100)),
                                              color: Colors.lightGreen,
                                            ),
                                            child: Text(
                                              'Government Of India',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 50),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  widget.model.fullName!,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                                Text(
                                                  'DOB: ${inputFormat.parse(widget.model.dob!).toString().split(" ")[0].replaceAll("-", "/")}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    child: Text(
                                                      widget.model.gender!
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0, 5, 0, 0),
                                                      child: Text(
                                                        "${widget.model.aadhaarNo!.substring(0, 4)} ${widget.model.aadhaarNo!.substring(4, 8)} ${widget.model.aadhaarNo!.substring(8, 12)}",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ))
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 0, 10),
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 3,
                                    color: Colors.red,
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        'MERA ADHAR, MERI PEHCHAAN',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 355, 0, 10),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                    bottom: Radius.circular(0)),
                              ),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                  child: Text(
                                'Back',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              height: 264,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(0),
                                    bottom: Radius.circular(20)),
                                border:
                                    Border.all(color: Colors.black, width: 1),
                              ),
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            // orange rectangle box
                                            margin: EdgeInsets.fromLTRB(
                                                0, 0, 30, 5),
                                            height: 15,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(0),
                                                      right:
                                                          Radius.circular(100)),
                                              color: Colors.orange,
                                            ),
                                            child: Text(
                                              'Bharat Sarkar',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            // green rectangle box
                                            height: 15,
                                            width: 200,
                                            margin: EdgeInsets.fromLTRB(
                                                20, 0, 0, 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                      left: Radius.circular(0),
                                                      right:
                                                          Radius.circular(100)),
                                              color: Colors.lightGreen,
                                            ),
                                            child: Text(
                                              'Government Of India',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 140,
                                          width: 150,
                                          child: Column(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 10, 40, 0),
                                                  child: Text(
                                                    'Address:',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.left,
                                                  )),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 0, 40, 0),
                                                  child: Text(
                                                    widget.model.address!,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(),
                                          height: 140,
                                          width: 140,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        "${widget.model.aadhaarNo!.substring(0, 4)} ${widget.model.aadhaarNo!.substring(4, 8)} ${widget.model.aadhaarNo!.substring(8, 12)}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )),
                                  Divider(
                                    thickness: 3,
                                    color: Colors.red,
                                  ),
                                  Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 30,
                                            color: Colors.black,
                                          ),
                                          Container(
                                            height: 15,
                                            width: 30,
                                            color: Colors.black,
                                          ),
                                          Container(
                                            height: 15,
                                            width: 30,
                                            color: Colors.black,
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
