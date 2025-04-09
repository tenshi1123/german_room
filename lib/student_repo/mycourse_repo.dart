import 'package:dio/dio.dart';
import 'package:german_room/student_models/home_model.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MycourseRepo {
  Dio dio = Dio();
  Future<List<MyCourseModel>> getListMyCourse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.myCourse,
    );
    List<MyCourseModel> list = [];
    for (var item in response.data['data']['value']) {
      list.add(MyCourseModel.fromJson(item));
    }
    return list;
  }

  Future<DetailMyCourse> getDetailMyCourse({required String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.detailMyCourse,
      data: {
        'id': id,
      },
    );
    return DetailMyCourse.fromJson(response.data['data']);
  }

  Future<DetailBaoCaoModel> getMycourseBaocao({required String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.detailBaoCao,
      data: {
        'id': id,
      },
    );
    return DetailBaoCaoModel.fromJson(response.data['data']);
  }

  Future<MycourseBaiTapModel> getMycourseBaitap({required String id}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.myCoursedetailBaiTap,
      data: {
        'id': id,
      },
    );
    return MycourseBaiTapModel.fromJson(response.data);
  }

  Future<VideoLessonModel> getVideoLesson({
    required String id,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.detailBuoihoc,
      data: {'id': id, 'type': "video"},
    );
    return VideoLessonModel.fromJson(response.data['data']['value']);
  }

  Future<List<BaiTapValueModel>> getExerciseLesson({
    required String id,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.detailBuoihoc,
      data: {'id': id, 'type': "exercise"},
    );
    List<BaiTapValueModel> list = [];
    for (var item in response.data['data']['exercise']) {
      list.add(BaiTapValueModel.fromJson(item));
    }
    return list;
  }

  Future<List<DeValueModel>> getDocument({
    required String id,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.detailBuoihoc,
      data: {'id': id, 'type': "document"},
    );
    List<DeValueModel> list = [];
    for (var item in response.data['data']['document']) {
      list.add(DeValueModel.fromJson(item));
    }
    return list;
  }

  Future<EvaluationModel> getEvaluation({
    required String id,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.detailBuoihoc,
      data: {'id': id, 'type': "evaluation"},
    );
    return EvaluationModel.fromJson(response.data['data']['evaluation']);
  }
}
