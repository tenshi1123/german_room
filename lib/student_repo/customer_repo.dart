import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:german_room/student_models/customer_models.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/utils/constants/api_path.dart';
import 'package:german_room/utils/constants/const_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerRepo {
  Dio dio = Dio();
  Future<StudentHomeModel?> getHomeInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;

    try {
      response = await dio.post(
        ApiPath.hocvienUrl,
      );
      return StudentHomeModel.fromJson(response.data['data']);
    } on DioException {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove(ConstString.type);
    } catch (e) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove(ConstString.type);
    }
    return null;
  }

  Future<List<CalendarModel>> getListTkb(
      {required String day1, required String day2}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(ApiPath.calendar,
        data: jsonEncode({
          'start_day': day1,
          'end_day': day2,
        }));
    List<CalendarModel> list = [];
    for (var item in response.data['data']['value']) {
      list.add(CalendarModel.fromJson(item));
    }
    return list;
  }

  Future<ProfileModel> getCustomerProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.profile,
    );
    return ProfileModel.fromJson(response.data['data']['value']);
  }

  Future<String> changePassword(
      String oldPass, String password, String newPass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(ApiPath.changePassword, data: {
      'password_old': oldPass,
      'pass_new': password,
      're_pass_new': newPass,
    });
    return response.data['message'];
  }

  Future<List<PaymentModel>> getPayment() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.payment,
    );
    List<PaymentModel> list = [];
    for (var item in response.data['data']['value']) {
      list.add(PaymentModel.fromJson(item));
    }
    return list;
  }
  // change teacher password
  // Future<String> changePassword(
  //     String oldPass, String password, String newPass) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? token = prefs.getString('token');
  //   dio.options.headers['Authorization'] = 'Bearer $token';
  //   Response response;
  //   Response response2;
  //   response = await dio.get(
  //     ApiPath.checkPassword,
  //     queryParameters: {
  //       'password': oldPass,
  //     },
  //   );
  //   if (response.data['message'] == "Mật khẩu đúng") {
  //     response2 = await dio.post(ApiPath.changePassword, data: {
  //       'password': password,
  //       're_password': newPass,
  //     });
  //     return response2.data['message'];
  //   } else {
  //     return response.data['message'];
  //   }
  // }

  Future<List<NotiModel>> getListNoti() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.notification,
    );
    List<NotiModel> reults = [];
    for (var item in response.data['data']['value']) {
      reults.add(NotiModel.fromJson(item));
    }
    return reults;
  }
}
