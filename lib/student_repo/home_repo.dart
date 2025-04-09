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
  Future<ListExcerciseModel> getListBaiTap() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.baiTap,
    );
    //return DiemDanhModel.fromJson(response.data['data']);
    return ListExcerciseModel.fromJson((response.data)['data']);
  }

  //Lấy chi tiết bài tập chi tiet bai tap
  Future<DetailExcerciseModel> getDetailExsercise(
      {required String id, required String customerCourseScheduleId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(ApiPath.detailBaiTap,
        data: jsonEncode({
          'id': int.tryParse(id),
          'customer_course_schedule_id': int.tryParse(
            customerCourseScheduleId,
          ),
        }));
    //return DiemDanhModel.fromJson(response.data['data']);
    return DetailExcerciseModel.fromJson((response.data)['data']);
  }

  Future uploadExcercise(
      {required String id,
      required String courseScheduleId,
      required String note,
      File? photo}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    FormData formData;
    if (photo == null) {
      formData = FormData.fromMap({
        'id': id,
        'customer_course_schedule_id': courseScheduleId,
        'note': note,
      });
    } else {
      formData = FormData.fromMap({
        'id': id,
        'customer_course_schedule_id': courseScheduleId,
        'note': note,
        'file': [
          await MultipartFile.fromFile(photo.path,
              filename: photo.path.split('/').last),
        ]
      });
    }

    await dio.post(ApiPath.submitExeTL, data: formData);
  }

  //Báo cáo điểm
  Future<BaoCaoHocTapModel> getBaoCaoDiem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.reportExercise,
    );
    //return DiemDanhModel.fromJson(response.data['data']);
    return BaoCaoHocTapModel.fromJson((response.data)['data']);
  }

  Future<InfoDiemDanh> getDetailDiemDanh(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response =
        await dio.post(ApiPath.detailDiemdanh, data: jsonEncode({"id": id}));
    return InfoDiemDanh.fromJson((response.data)['data']);
  }

  Future<List<PostModel>> getlistPost(int page) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(ApiPath.post,
        data: jsonEncode({
          'page': page,
          'limit': 10,
        }));
    List<PostModel> list = [];
    for (var item in response.data['data']['value']) {
      list.add(PostModel.fromJson(item));
    }
    return list;
  }

  Future<DetailPostModel> getDetailPost({required String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(ApiPath.postDetail, data: jsonEncode({"id": id}));
    return DetailPostModel.fromJson((response.data)['data']);
  }
}
