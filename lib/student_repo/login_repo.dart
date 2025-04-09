import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:german_room/utils/constants/api_path.dart';
import 'package:german_room/utils/constants/api_path_teacher.dart';
import 'package:german_room/utils/constants/const_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_util/sp_util.dart';

class LoginRepo {
  Dio dio = Dio();
  Future<bool> login(String code, String password) async {
    dio.options.headers['Token'] = 'german_room123456789';
    Response response;
    try {
      response = await dio.post(ApiPath.login,
          data: jsonEncode({
            'phone': code,
            'password': password,
          }));
    } on DioException {
      return false;
    }
    if (response.data['status'] == false) {
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data["refresh_token"]);
    await prefs.setString(ConstString.type, 'student');
    await prefs.setString('id_user', response.data["customer_id"]);
    return response.data["refresh_token"] != null;
  }

  Future<String> refreshToken() async {
    Dio dio = Dio();
    dio.options.headers['Token'] = 'BT123456789';
    Response response;
    response = await dio.post(ApiPath.login,
        data: jsonEncode({
          'code': SpUtil.getString(ConstString.idStudent),
          'password': SpUtil.getString(ConstString.md5Pass),
        }));
    SpUtil.putString(ConstString.token, response.data["token"]);
    // sendUserTag(int.parse(response.data["school_id"].toString()));
    return response.data["token"];
  }

  Future<bool> loginTeacher(String email, String password) async {
    dio.options.headers['Token'] = 'german_room123456789';
    Response response;
    try {
      response = await dio.post(ApiPathTeacher.login,
          data: jsonEncode({
            'email': email,
            'password': md5.convert(utf8.encode(password)).toString(),
          }));
    } on DioException {
      return false;
    }
    if (response.data['status'] == false) {
      return false;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data["refresh_token"]);
    await prefs.setString(ConstString.type, 'teacher');
    await prefs.setString('id_user', response.data["teachers_id"]);
    return response.data["refresh_token"] != null;
  }
}
