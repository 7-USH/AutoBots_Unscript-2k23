// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/app/app.dart';
import 'package:unscript_app/login/login.dart';
import 'package:unscript_app/register/layout/verify_otp_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getToken();
  //push notifications
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  const orientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ];
  SystemChrome.setPreferredOrientations(orientations);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = const Scaffold();

  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((newToken) {
      print("FCM Token: ");
      print(newToken);
      // // save device token to server
      // tokenService.updateTokenOnServer(newToken);
    });
    switchHome();
    super.initState();
  }

  void switchHome() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? session = sharedPreferences.getString("session");
    if (session == null) {
      setState(() {
        home = const Login();
      });
    } else {
      setState(() {
        home = App();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UnScript Hackathon",
      debugShowCheckedModeBanner: false,
      home: home,
    );
  }
}
