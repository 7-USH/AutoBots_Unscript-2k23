import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/utils/app_error.dart';
import 'package:http/http.dart' as http;
import 'package:unscript_app/utils/unscript_theme.dart';

class ApiService {
  static final ApiService _apiService = ApiService._internal();

  factory ApiService() {
    return _apiService;
  }

  ApiService._internal();

  Future<Either<MyError, Map<String, dynamic>>> getData(String endpoint) async {
    Uri uri = getUri(endpoint);
    var response = await http.get(uri, headers: await getHeaders());
    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body.toString()));
    }
    if (response.statusCode >= 500) {
      return Left(MyError(
          key: AppError.SERVER_ERROR,
          message: "Server error with http status ${response.statusCode}",
          statusCode: response.statusCode));
    }
    return Left(MyError(
        key: AppError.ERROR_DETECTED,
        message: "Bad http status ${response.statusCode}",
        statusCode: response.statusCode));
  }

  Future<Either<MyError, Map<String, dynamic>>> postData(
      String endpoint, Map<String, dynamic> requestBody) async {
    Uri uri = getUri(endpoint);
    var response = await http.post(uri,
        body: jsonEncode(requestBody), headers: await getHeaders());
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body));
    }
    if (response.statusCode >= 500) {
      return Left(MyError(
          key: AppError.SERVER_ERROR,
          message: "Server error with http status ${response.statusCode}",
          statusCode: response.statusCode));
    }
    return Left(MyError(
        key: AppError.ERROR_DETECTED,
        message: jsonDecode(response.body)["detail"],
        statusCode: response.statusCode));
  }

  Future<Either<MyError, Map<String, dynamic>>> updateData(
      String endpoint, Map<String, dynamic> requestBody) async {
    Uri uri = getUri(endpoint);
    var response = await http.put(uri,
        body: jsonEncode(requestBody), headers: await getHeaders());
    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body));
    }
    if (response.statusCode >= 500) {
      return Left(MyError(
          key: AppError.SERVER_ERROR,
          message: "Server error with http status ${response.statusCode}",
          statusCode: response.statusCode));
    }
    return Left(MyError(
        key: AppError.ERROR_DETECTED,
        message: jsonDecode(response.body)["detail"],
        statusCode: response.statusCode));
  }

  Future<Either<MyError, List<dynamic>>> getAllData(String endpoint) async {
    Uri uri = getUri(endpoint);
    var response = await http.get(uri, headers: await getHeaders());
    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body.toString()) as List<dynamic>);
    }
    if (response.statusCode >= 500) {
      return Left(MyError(
          key: AppError.SERVER_ERROR,
          message: "Server error with http status ${response.statusCode}",
          statusCode: response.statusCode));
    }
    return Left(MyError(
        key: AppError.ERROR_DETECTED,
        message: "Bad http status ${response.statusCode}",
        statusCode: response.statusCode));
  }

  Future<Either<MyError, Map<String, dynamic>>> postAllData(
      String endpoint, List<Map<String, dynamic>> requestBody) async {
    Uri uri = getUri(endpoint);
    var response = await http.post(uri, body: jsonEncode(requestBody));
    if (response.statusCode == 200) {
      return Right(jsonDecode(response.body));
    }
    if (response.statusCode >= 500) {
      return Left(MyError(
          key: AppError.SERVER_ERROR,
          message: "Server error with http status ${response.statusCode}",
          statusCode: response.statusCode));
    }
    return Left(MyError(
        key: AppError.ERROR_DETECTED,
        message: "Bad http status ${response.statusCode}",
        statusCode: response.statusCode));
  }

  Uri getUri(String endpoint) {
    return Uri.parse(
        UnScriptTheme.UNSCRIPT_DB_LINK + UnScriptTheme.API_VERSION + endpoint);
  }

  Future<Map<String, String>> getHeaders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? access = pref.getString("session");
    return {
      'Authorization': 'Bearer $access',
      'Content-Type': 'application/json; charset=UTF-8',
    };
  }
}
