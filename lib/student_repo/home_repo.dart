import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:german_room/student_models/diem_danh_model.dart';
import 'package:german_room/student_models/home_model.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepo {
  Dio dio = Dio();
  //Lấy danh sách bài tập

  //Báo cáo điểm
  Future<List<BaoCaoHocTapModel>> getBaoCaoDiem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.feedback,
    );
    //return DiemDanhModel.fromJson(response.data['data']);
    List<BaoCaoHocTapModel> list = [];
    for (var item in response.data['data']) {
      list.add(BaoCaoHocTapModel.fromJson(item));
    }
    return list;
  }

  Future<String> getDetailFeedback(
      String? checkinOffId, String typeLearn, String? meetingId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.get(
      ApiPath.feedbackDetail,
      queryParameters: {
        'checkin_off_id': checkinOffId,
        'type_learn': typeLearn,
        'meeting_id': meetingId,
      },
    );
    return (response.data)['data'];
  }
}
