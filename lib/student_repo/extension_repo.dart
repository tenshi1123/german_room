import 'package:dio/dio.dart';
import 'package:german_room/student_models/review_models.dart';
import 'package:german_room/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtensionRepo {
  Dio dio = Dio();
  // Lấy danh sách đánh giá của học viên
  Future<List<ReviewModels>> getListReview() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.schedule,
    );
    List<ReviewModels> list = [];
    for (var item in response.data['data']['value']) {
      list.add(ReviewModels.fromJson(item));
    }
    return list;
  }
}
