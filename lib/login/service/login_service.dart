// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:unscript_app/common/api.dart';
import 'package:unscript_app/login/models/login_model.dart';
import 'package:unscript_app/login/models/session_model.dart';

class LoginService {
  final ApiService _service = ApiService();

  Future<dynamic> loginUser({required BuildContext context,required LoginModel model}) async {
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
}
