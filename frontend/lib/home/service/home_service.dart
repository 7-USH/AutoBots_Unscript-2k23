// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:unscript_app/common/api.dart';
import 'package:unscript_app/home/models/bond_model.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class HomeService {
  final ApiService _apiService = ApiService();

  Future<List<BondModel>> getLiveBonds({required BuildContext context}) async {
    String endpoint = "live-data/live-bonds";
    var response = await _apiService.getAllData(endpoint);
    if (response.isLeft) {
      return UnScriptTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right
          .map<BondModel>((e) => BondModel.fromJson(e))
          .toList();
    }
  }

  
}
