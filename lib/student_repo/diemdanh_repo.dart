import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:german_room/student_models/diem_danh_model.dart';
import 'package:german_room/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiemdanhRepo {
  Dio dio = Dio();
  Future<List<DiemDanhModel>> getListDiemDanh() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.diemDanh,
    );
    //return DiemDanhModel.fromJson(response.data['data']);
    List<DiemDanhModel> result = ((response.data)['data']['value'] as List)
        .map((e) => DiemDanhModel.fromJson(e))
        .toList();
    return result;
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
}
