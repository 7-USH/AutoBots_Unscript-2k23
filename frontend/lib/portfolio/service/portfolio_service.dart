// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:unscript_app/common/api.dart';
import 'package:unscript_app/portfolio/models/asset_model.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class PortFolioService {
  final ApiService _service = ApiService();

  Future<List<AssetModel>> getAssets({required BuildContext context}) async {
    String endpoint = "user-bonds/get-bonds-by-user";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      return UnScriptTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right
          .map<AssetModel>(
              (e) => AssetModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<dynamic> getRequestsByOwner({required BuildContext context}) async {
    String endpoint = "bond-requests/get-requests-by-owner";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      return UnScriptTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right;
    }
  }

  Future<dynamic> sellUserBond({required BuildContext context}) async {
    String endpoint = "user-bonds/sell-user-bonds";
    var response = await _service.updateData(endpoint, {});
    if (response.isLeft) {
      return UnScriptTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right;
    }
  }
}
