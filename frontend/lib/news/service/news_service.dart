// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:unscript_app/common/api.dart';
import 'package:unscript_app/news/models/news_model.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class NewsService {
  final ApiService _service = ApiService();

  Future<List<NewsModel>> getLiveNews({required BuildContext context}) async {
    String endpoint = "live-data/news";
    var response = await _service.getAllData(endpoint);
    if (response.isLeft) {
      return UnScriptTheme.moveToError(
          context: context,
          text: response.left.message!,
          statusCode: response.left.statusCode);
    } else {
      return response.right
          .map<NewsModel>((e) => NewsModel.fromJson(e))
          .toList();
    }
  }
}
