// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:unscript_app/common/api.dart';
import 'package:unscript_app/trade/models/buy_bonds_models.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class TradeServie {
  final ApiService service = ApiService();

  Future<List<BuyBonds>> getUserBonds({required BuildContext context}) async {
    String endpoint = "live-data/get-bonds";
    var response = await service.getAllData(endpoint);
    if (response.isLeft) {
      return UnScriptTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right
          .map<BuyBonds>((e) => BuyBonds.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<dynamic> createRequest({required BuildContext context,required Map<String,dynamic> requestBody}) async {
    String endpoint = "bond-requests/create-request";
     var response = await service.postData(endpoint, requestBody);
    if (response.isLeft) {
       AnimatedSnackBar.material(
        response.left.message!,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    } else {
      return response.right;
    }
  }

  Future<dynamic> createBond(
      {required BuildContext context,
      required Map<String, dynamic> requestBody}) async {
    String endpoint = "user-bonds/create";
    var response = await service.postData(endpoint, requestBody);
    if (response.isLeft) {
      AnimatedSnackBar.material(
        response.left.message!,
        type: AnimatedSnackBarType.error,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
      ).show(context);
    } else {
      return response.right;
    }
  }
}
