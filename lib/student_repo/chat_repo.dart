import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:german_room/student_models/chat_models.dart';
import 'package:german_room/utils/constants/api_path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepo {
  Dio dio = Dio();

  Future<List<ChatModel>> getListConversation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.listTeacher,
    );
    List<ChatModel> list = [];
    for (var item in response.data['data']['value']) {
      list.add(ChatModel.fromJson(item));
    }
    return list;
  }

  Future<List<ChatModel>> getTeacherListConversation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.listTeacher,
    );
    List<ChatModel> list = [];
    for (var item in response.data['data']['value']) {
      list.add(ChatModel.fromJson(item));
    }
    return list;
  }

  Future<ConverastionModel> getConversationDetail(String chatId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(
      ApiPath.listMessage,
      data: {
        'chat_id': chatId,
      },
    );
    return ConverastionModel.fromJson(response.data['data']);
  }

  Future<bool> sendMessage(String chatId, String message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    Response response;
    response = await dio.post(ApiPath.sendMessage,
        data: jsonEncode(
          {
            'chat_id': int.parse(chatId),
            'content': message,
          },
        ));
    return response.data['status'] == 200;
  }

  Future<bool> sendImageMessage(String chatId, File photo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    dio.options.headers['Authorization'] = 'Bearer $token';
    var formData = FormData.fromMap({
      'chat_id': int.parse(chatId),
      'files[]': await MultipartFile.fromFile(photo.path,
          filename: photo.path.split('/').last),
    });
    Response response;
    response = await dio.post(ApiPath.sendMessage, data: formData);
    return response.data['status'] == 200;
  }
}
