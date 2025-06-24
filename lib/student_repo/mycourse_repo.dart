import 'package:dio/dio.dart';
import 'package:german_room/student_models/home_model.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/student_models/schedule_model.dart';
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
      ApiPath.lesson,
    );
    List<MyCourseModel> list = [];
    for (var item in response.data['data']) {
      list.add(MyCourseModel.fromJson(item));
    }
    return list;
  }

  Future<ClassDetailModel> getListLesson(
      {required String typeId, required String scheduleId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.post(
      ApiPath.detailClass,
      data: {
        'setting_course_type_id': typeId,
        'course_schedule_id': scheduleId,
      },
    );
    return ClassDetailModel.fromJson(response.data['data']);
  }

  //chi tiet lich hoc
  Future<DetaiLessonModel> getDetailSchedule({
    required String? checkinOffId,
    required String typeLearn,
    required String? meetingId,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.get(
      ApiPath.homework,
      queryParameters: {
        'checkin_off_id': checkinOffId,
        'type_learn': typeLearn,
        'meeting_id': meetingId,
      },
    );
    DetaiLessonModel result =
        DetaiLessonModel.fromJson((response.data)['data']);
    return result;
  }

  Future<CourseVideoModel?> getListTopical({
    required String typeId,
    required String scheduleId,
    required String courseId,
    required int type,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      if (token == null) {
        return null;
      }
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.post(
        type == 1 ? ApiPath.topical : ApiPath.topicalFree,
        data: {
          'course_id': courseId,
          'course_schedule_id': scheduleId,
          'setting_course_type_id': typeId,
        },
      );
      // Kiểm tra status và trả về null nếu không phải true
      if (response.data is Map && response.data['status'] == true) {
        return CourseVideoModel.fromJson(response.data['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<LessonVideoResult> getlistLessonVideo({
    required String topicalId,
    required String settingCoureTypeId,
    required int type,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.post(
      type == 1 ? ApiPath.video : ApiPath.videoFree,
      data: {
        'topical_id': topicalId,
        'setting_course_type_id': settingCoureTypeId,
      },
    );
    LessonVideoResult result =
        LessonVideoResult.fromJson((response.data)['data']);
    return result;
  }

  Future<String> getLinkVideo({
    required String lessonId,
    required String settingCoureTypeId,
    required String lessonType,
    required int type,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    final response = await dio.post(
      type == 1 ? ApiPath.detailVideo : ApiPath.detailVideoFree,
      data: {
        'lesson_id': lessonId,
        'setting_course_type_id': settingCoureTypeId,
        'lesson_type': lessonType,
      },
    );

    return response.data['data']['lesson_content'] ??
        response.data['data']['link_webview'];
  }

  Future<List<FreeCourseModel>> getLessonFree() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.get(
      ApiPath.lessonFree,
    );
    List<FreeCourseModel> result = ((response.data)['data'] as List)
        .map((e) => FreeCourseModel.fromJson(e))
        .toList();
    return result;
  }

  Future<List<BaiTapValueModel>> getExerciseLesson({
    required String id,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.detailClass,
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
      ApiPath.detailClass,
      data: {'id': id, 'type': "document"},
    );
    List<DeValueModel> list = [];
    for (var item in response.data['data']['document']) {
      list.add(DeValueModel.fromJson(item));
    }
    return list;
  }

  Future<PointModel> getPoint({
    required String id,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.point,
      data: {
        'course_schedule_id': id,
      },
    );
    return PointModel.fromJson(response.data['data']);
  }
}
