import 'package:dio/dio.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/student_models/schedule_model.dart';
import 'package:german_room/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerRepo {
  Dio dio = Dio();

  //lịch học
  Future<List<ScheduleModel>> getScheduleList(
      String dayStart, String dayEnd) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.get(
      ApiPath.schedule,
      queryParameters: {
        'day_start': dayStart,
        'day_end': dayEnd,
      },
    );
    List<ScheduleModel> result = ((response.data)['data'] as List)
        .map((e) => ScheduleModel.fromJson(e))
        .toList();
    return result;
  }

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

  Future<ProfileModel?> getCustomerProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;

    try {
      response = await dio.post(
        ApiPath.userInfo,
      );
      return ProfileModel.fromJson(response.data['data']);
    } on DioException {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.remove('token');
      return null;
    } catch (e) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      return null;
    }
  }

  Future<String> leaveSchedule(
      {required String checkinOffId, required String reason}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.xinNghi,
      data: {
        'meeting_customer_zoom_google_offline_id': checkinOffId,
        'reason': reason,
      },
    );
    return response.data['message'];
  }

  Future<String> cancleSchedule(
      {required String checkinOffId, required String mettingId}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.cancelXinNghi,
      data: {
        'meeting_customer_zoom_google_offline_id': checkinOffId,
        'meeting_id': mettingId,
      },
    );
    return response.data['message'];
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
    for (var item in response.data['data']) {
      reults.add(NotiModel.fromJson(item));
    }
    return reults;
  }
}
