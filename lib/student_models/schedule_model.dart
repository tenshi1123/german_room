// model một buổi học trong lịch học
import 'package:html_unescape/html_unescape.dart';
import 'package:intl/intl.dart';

class ScheduleModel {
  final String courseName;
  final String courseAlias;
  final String buoiHoc;
  final DateTime createdDate;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String? phongHocName;
  final String? cosoName;
  final String? checkinOffId;
  final String? linkZoom;
  final String? meetingId;
  final String meetingCustomerZoomGoogleOfflineId;
  final String? customerLeaveId;
  String? customerLeaveReason;
  final String? customerLeaveCreateAt;
  final String typeLearn;
  ScheduleModel({
    required this.courseName,
    required this.courseAlias,
    required this.buoiHoc,
    required this.createdDate,
    required this.timeStart,
    required this.timeEnd,
    this.phongHocName,
    this.cosoName,
    this.checkinOffId,
    this.linkZoom,
    this.meetingId,
    this.customerLeaveId,
    this.customerLeaveReason,
    this.customerLeaveCreateAt,
    required this.typeLearn,
    required this.meetingCustomerZoomGoogleOfflineId,
  });
  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      courseName: json["course_name"] ?? '',
      courseAlias: json["course_alias"] ?? '',
      buoiHoc: json["buoi_hoc"] ?? json['name'] ?? '',
      createdDate: DateFormat("dd-MM-yyyy").parse(json["created_date"] ?? ''),
      timeStart: DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(json["time_start"] ?? '0000-00-00 00:00:00'),
      timeEnd: DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(json["time_end"] ?? '0000-00-00 00:00:00'),
      phongHocName: json["phonghoc_name"],
      cosoName: json["coso_name"],
      checkinOffId: json["checkin_off_id"],
      linkZoom: json["link_zoom"] ?? json['link_learn'],
      meetingId: json["meeting_id"],
      customerLeaveId: json["customer_leave_id"],
      customerLeaveReason: json["customer_leave_reason"],
      customerLeaveCreateAt: json["customer_leave_created_at"],
      typeLearn: json["type_learn"] ?? '',
      meetingCustomerZoomGoogleOfflineId:
          json["meeting_customer_zoom_google_offline_id"] ?? '',
    );
  }
}

class DetaiLessonModel {
  final InfoLessonModel infoLesson;
  final List<HomeWorkModel> listHomeWorks;
  final List<DocumentModel> listDocument;
  final String feedback;
  DetaiLessonModel({
    required this.infoLesson,
    required this.listHomeWorks,
    required this.listDocument,
    required this.feedback,
  });
  factory DetaiLessonModel.fromJson(Map<String, dynamic> json) {
    return DetaiLessonModel(
      infoLesson: InfoLessonModel.fromJson(json["info_lesson"]),
      listHomeWorks: (json["homework"] as List)
          .map((e) => HomeWorkModel.fromJson(e))
          .toList(),
      listDocument: (json["document"] as List)
          .map((e) => DocumentModel.fromJson(e))
          .toList(),
      feedback: sanitizeHtml(json['feedback']),
    );
  }
}

String sanitizeHtml(String raw) {
  final unescape = HtmlUnescape();
  return unescape.convert(raw).replaceAll(RegExp(r'[\r\n]+'), '').trim();
}

class InfoLessonModel {
  final String? namePhongHoc;
  final String? coSoName;
  final String? linkZoom;
  final String nameLesson;
  final String topic;
  final String lessonContent;
  InfoLessonModel({
    this.namePhongHoc,
    this.coSoName,
    this.linkZoom,
    required this.nameLesson,
    required this.topic,
    required this.lessonContent,
  });
  factory InfoLessonModel.fromJson(Map<String, dynamic> json) {
    return InfoLessonModel(
      namePhongHoc: json["name_phonghoc"],
      coSoName: json["coso_name"],
      linkZoom: json["link_zoom"],
      nameLesson: json["name_lesson"] ?? '',
      topic: json["topic"] ?? '',
      lessonContent: json["lesson_content"] ?? '',
    );
  }
}

class DataHomeWorkModel {
  final List<ListBTModel> listHomeWorks;
  final String name;
  DataHomeWorkModel({
    required this.listHomeWorks,
    required this.name,
  });
  factory DataHomeWorkModel.fromJson(Map<String, dynamic> json) {
    return DataHomeWorkModel(
      listHomeWorks:
          (json["list"] as List).map((e) => ListBTModel.fromJson(e)).toList(),
      name: json['name'],
    );
  }
}

class ListBTModel {
  final String id;
  final String nameExercise;
  final String linkExercise;
  final String timeDeadline;
  final String daySubmit;
  final String status;
  final String score;
  final String percent;
  final String typeLearn;
  final String typeExercise;
  final String noteTeacher;
  ListBTModel({
    required this.id,
    required this.nameExercise,
    required this.linkExercise,
    required this.timeDeadline,
    required this.daySubmit,
    required this.status,
    required this.score,
    required this.percent,
    required this.typeLearn,
    required this.typeExercise,
    required this.noteTeacher,
  });
  factory ListBTModel.fromJson(Map<String, dynamic> json) {
    return ListBTModel(
      id: json["class_lesson_document_id"] ?? '',
      nameExercise: json['name_exercise'] ?? '',
      linkExercise: json['link_exercise'] ?? '',
      timeDeadline: json['deadline'] ?? '',
      daySubmit: json['day_submit'] ?? '',
      status: json['status'] ?? '',
      score: json['score'] ?? '',
      percent: json['percent'] ?? '',
      typeLearn: json['type_learn'] ?? '',
      typeExercise: json['type_exercise'] ?? '',
      noteTeacher: json['note_teacher'] ?? '',
    );
  }
}

class HomeWorkModel {
  final String image;
  final String name;
  final String documentId;
  final String timeDeadline;
  final String note;
  final String nameTeacher;
  final String isSubmit;
  final String customerId;
  final String typeLearn;
  final String eventCheckinOffId;
  final String? baiTapDaNop;

  HomeWorkModel({
    required this.image,
    required this.name,
    required this.documentId,
    required this.timeDeadline,
    required this.note,
    required this.nameTeacher,
    required this.isSubmit,
    required this.customerId,
    required this.typeLearn,
    required this.eventCheckinOffId,
    this.baiTapDaNop,
  });
  factory HomeWorkModel.fromJson(Map<String, dynamic> json) {
    return HomeWorkModel(
      image: json["course_schedule_img"] ?? '',
      name: json['name'] ?? '',
      documentId: json['class_lesson_document_id'] ?? '',
      timeDeadline: json['time_deadline'] ?? '',
      note: json['note'] ?? '',
      nameTeacher: json['name_teacher'] ?? '',
      isSubmit: json['is_submit_homework'] ?? '',
      customerId: json['class_lesson_document_customer_id'] ?? '',
      typeLearn: json['type_learn'] ?? '',
      eventCheckinOffId: json['event_checkin_off_id'] ?? '',
      baiTapDaNop: json['url_file_customer'],
    );
  }
}

class DocumentModel {
  final String point;
  final String name;
  DocumentModel({
    required this.point,
    required this.name,
  });
  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      point: json['course_schedule_img'],
      name: json['name'],
    );
  }
}
