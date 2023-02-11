// ignore_for_file: use_build_context_synchronously, unused_import
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:unscript_app/common/api.dart';
import 'package:unscript_app/login/models/session_model.dart';
import 'package:unscript_app/register/models/activate_model.dart';
import 'package:unscript_app/register/models/register_model.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class RegisterService {
  final ApiService _apiService = ApiService();

  Future<dynamic> registerUser(
      {required BuildContext context, required RegisterModel model}) async {
    String endpoint = "user/register";
    var response = await _apiService.postData(endpoint, model.toJson());
    if (response.isLeft) {
      AnimatedSnackBar.material(
        response.left.message!,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    } else {
      return RegisterModel.fromJson(response.right);
    }
  }

  Future<dynamic> activateCode(
      {required ActivateModel model, required BuildContext context}) async {
    String endpoint = "login/activate-user";
    var response = await _apiService.postData(endpoint, model.toJson());
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
}
