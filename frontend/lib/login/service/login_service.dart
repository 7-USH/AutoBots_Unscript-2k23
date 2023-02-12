// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/common/api.dart';
import 'package:unscript_app/home/models/profile_details_model.dart';
import 'package:unscript_app/login/models/login_model.dart';
import 'package:unscript_app/login/models/reset_pass_model.dart';
import 'package:unscript_app/login/models/session_model.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class LoginService {
  final ApiService _service = ApiService();

  Future<dynamic> loginUser(
      {required BuildContext context, required LoginModel model}) async {
    String endpoint = "login/auth";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      AnimatedSnackBar.material(
        response.left.message!,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    } else {
      return SessionModel.fromJson(response.right);
    }
  }

  Future<dynamic> sendForgotOTP(
      {required Map<String, dynamic> requestBody,
      required BuildContext context}) async {
    String endpoint = "login/send-forgot-password-otp";
    var response = await _service.postData(endpoint, requestBody);
    if (response.isLeft) {
      AnimatedSnackBar.material(
        response.left.message!,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    } else {
      return true;
    }
  }

  Future<dynamic> validateOTP(
      {required BuildContext context, required ResetPassModel model}) async {
    String endpoint = "login/validate-reset-password-otp";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      AnimatedSnackBar.material(
        response.left.message!,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    } else {
      SessionModel token = SessionModel.fromJson(response.right);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('session', token.session!);
      return token;
    }
  }

  Future<dynamic> resetPassword(
      {required ResetPassModel model, required BuildContext context}) async {
    String endpoint = "login/reset-password";
    var response = await _service.postData(endpoint, model.toJson());
    if (response.isLeft) {
      AnimatedSnackBar.material(
        response.left.message!,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    } else {
      return response;
    }
  }

  Future<ProfileDetailsModel> getMyDetails(
      {required BuildContext context}) async {
    String endpoint = "user/get-user-details";
    var response = await _service.getData(endpoint);
    if (response.isLeft) {
      return UnScriptTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return ProfileDetailsModel.fromJson(response.right);
    }
  }
}
