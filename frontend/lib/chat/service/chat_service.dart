// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:unscript_app/common/api.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class ChatService {
  final ApiService _service = ApiService();

  Future<dynamic> askQuestion(
      {required BuildContext context,
      required Map<String, dynamic> requestBody}) async {
    String endpoint = "live-data/ask-question";
    var response = await _service.postData(endpoint, requestBody);
    print(response);
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
