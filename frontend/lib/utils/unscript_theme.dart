// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unscript_app/utils/error_page.dart';

class UnScriptTheme {
  static const Color backgroundColor = Color(0xff1A1A1A);
  static const Color perfectWhite = Color.fromARGB(255, 255, 255, 255);
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color successGreen = Color(0xff4BB543);
  static const Color nearlyBlue = Color(0xff00BCD5);
  static const Color bgTextColor1 = Color(0xff1E1E1E);
  static const Color bgTextColor2 = Color(0xffAEAEAE);

  // ignore: constant_identifier_names
  static const String UNSCRIPT_DB_LINK =
      "http://ec2-100-26-209-28.compute-1.amazonaws.com:8000/";
  //"https://fcreh-autobots.onrender.com/";
  //"https://frce-fastapi-soumitrakand7.cloud.okteto.net/";

  // ignore: constant_identifier_names
  static const String API_VERSION = "api/v1/";

  static TextStyle appText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = nearlyWhite,
    double letterSpacing = -1,
    bool isShadow = false,
  }) {
    return GoogleFonts.dmSans(
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        letterSpacing: letterSpacing,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static TextStyle screenText({
    required double size,
    required FontWeight weight,
    FontStyle style = FontStyle.normal,
    Color color = nearlyWhite,
    double letterSpacing = -1,
    bool isShadow = false,
  }) {
    return GoogleFonts.sora(
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        letterSpacing: letterSpacing,
        color: color,
        shadows: isShadow
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0.1, 0.4),
                    spreadRadius: 3,
                    blurRadius: 2)
              ]
            : null);
  }

  static ButtonStyle buttonStyle(
      {double fontSize = 10,
      FontWeight weight = FontWeight.bold,
      Color fontColor = Colors.white,
      required Color backColor,
      Color borderColor = Colors.transparent}) {
    return ElevatedButton.styleFrom(
        textStyle: appText(size: fontSize, weight: weight, color: fontColor),
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor)));
  }

  static InputDecoration faInputDecoration(
      {String? hint,
      Color? bgColor,
      double fontSize = 20,
      Color? borderColor,
      EdgeInsets? padding}) {
    return InputDecoration(
      contentPadding:
          padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      counter: const Offstage(),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: borderColor ?? perfectWhite, width: 1.3)),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: Colors.grey),
      ),
      hintText: hint,
      fillColor: Colors.transparent,
      hintStyle: screenText(
          size: fontSize, weight: FontWeight.normal, color: bgTextColor2),
      filled: true,
    );
  }

  static moveToError(
      {required BuildContext context,
      required String text,
      required int statusCode}) {
    Navigator.of(context, rootNavigator: true).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ErrorPage(text: text, statusCode: statusCode),
      ),
    );
  }
}
