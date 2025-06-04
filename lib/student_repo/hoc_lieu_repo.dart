import 'package:dio/dio.dart';
import 'package:german_room/student_models/hoclieu_model.dart';
import 'package:german_room/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HocLieuRepo {
  Dio dio = Dio();

  Future<List<OverviewModel>> getDsCap1() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.danhMucCap1,
    );
    List<OverviewModel> list = [];
    for (var item in response.data['data']) {
      list.add(OverviewModel.fromJson(item));
    }
    return list;
  }

  Future<List<KhoaHocModel>> getDsCap2({required String categoryId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.danhMucCap2,
      queryParameters: {
        'category_id': categoryId,
      },
    );
    List<KhoaHocModel> list = [];
    for (var item in response.data['data']) {
      list.add(KhoaHocModel.fromJson(item));
    }
    return list;
  }

  Future<List<HocLieuModel>> getDsCap3({required String courseId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.danhMucCap3,
      queryParameters: {
        'course_id': courseId,
      },
    );
    List<HocLieuModel> list = [];
    for (var item in response.data['data']) {
      list.add(HocLieuModel.fromJson(item));
    }
    return list;
  }

  Future<DetailLearingModel> getDetailLearing({
    required String learningMaterialsId,
    required String partId,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.detailLesson,
      queryParameters: {
        'learning_material_id': learningMaterialsId,
        'part_id': partId,
      },
    );
    return DetailLearingModel.fromJson(response.data['data']);
  }

  Future<String> getLinkQuestion({
    required String partId,
    required String questionId,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      '${ApiPath.getLinkQuestion}$token/part/$partId/question/$questionId',
    );
    return response.data['data']['link'];
  }
}
