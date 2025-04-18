import 'package:intl/intl.dart';

class MyCourseModel {
  final String courseName;
  final String courseId;
  final String courseScheduleName;
  final String customerCourseScheduleId;
  final String courseImg;
  final String courseScheduleId;
  final String settingCourseTypeId;
  final String settingCourseTypeName;
  final String settingCourseType;
  final String customerZoomGoogleOfflineId;
  MyCourseModel({
    required this.courseName,
    required this.courseId,
    required this.courseScheduleName,
    required this.customerCourseScheduleId,
    required this.courseImg,
    required this.courseScheduleId,
    required this.settingCourseTypeId,
    required this.settingCourseTypeName,
    required this.settingCourseType,
    required this.customerZoomGoogleOfflineId,
  });
  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      courseName: json['course_name'] ?? '',
      courseId: json['course_id'] ?? '',
      courseScheduleName: json['course_schedule_name'] ?? '',
      customerCourseScheduleId: json['customer_course_schedule_id'] ?? '',
      courseImg: json['course_img'] ?? '',
      courseScheduleId: json['course_schedule_id'] ?? '',
      settingCourseTypeId: json['setting_course_type_id'] ?? '',
      settingCourseTypeName: json['setting_course_type_name'] ?? '',
      settingCourseType: json['setting_course_type_type'] ?? '',
      customerZoomGoogleOfflineId:
          json['customer_zoom_google_offline_id'] ?? '',
    );
  }
}

class DetailMyCourse {
  final String id;
  final String alias;
  final String name;
  final String img;
  final String settingCourseTypeId;
  final String courseScheduleId;
  final List<DetailCourse> saptoi;
  final List<DetailCourse> daqua;
  DetailMyCourse({
    required this.id,
    required this.alias,
    required this.name,
    required this.img,
    required this.settingCourseTypeId,
    required this.courseScheduleId,
    required this.saptoi,
    required this.daqua,
  });
  factory DetailMyCourse.fromJson(Map<String, dynamic> json) {
    return DetailMyCourse(
      id: json["value"]["id"] ?? '',
      alias: json["value"]["alias"] ?? '',
      name: json["value"]["name"] ?? '',
      img: json["value"]["img"] ?? '',
      settingCourseTypeId: json["value"]["setting_course_type_id"] ?? '',
      courseScheduleId: json["value"]["course_schedule_id"] ?? '',
      saptoi: ((json['sap_toi'] as List)
          .map((e) => DetailCourse.fromJson(e))
          .toList()),
      daqua: ((json['da_qua'] as List)
          .map((e) => DetailCourse.fromJson(e))
          .toList()),
    );
  }
}

class DetailCourse {
  final String id;
  final String name;
  final String teachingContent;
  final DateTime day;
  final String time;
  final String teacherName;
  final String phongHoc;
  final String cosoName;
  final String cosoAddress;
  DetailCourse({
    required this.id,
    required this.name,
    required this.teachingContent,
    required this.day,
    required this.time,
    required this.teacherName,
    required this.phongHoc,
    required this.cosoName,
    required this.cosoAddress,
  });
  factory DetailCourse.fromJson(Map<String, dynamic> json) {
    return DetailCourse(
      id: json["id"] ?? '',
      name: json["name"] ?? '',
      teachingContent: json["teaching_content"] ?? '',
      day: DateFormat("yyyy-MM-dd").parse(json["day"] ?? ''),
      time: json["time"] ?? '',
      teacherName: json["teachers_full_name"] ?? '',
      phongHoc: json["phong_hoc"] ?? '',
      cosoName: json["coso_name"] ?? '',
      cosoAddress: json["coso_address"] ?? '',
    );
  }
}

class DetailBaoCaoModel {
  final int chuyenCan;
  final int baiTap;
  final int thaiDo;
  final String teacherId;
  final String fullName;
  final String content;
  final List<MonthlyReviewModel> monthlyReview;
  DetailBaoCaoModel({
    required this.chuyenCan,
    required this.baiTap,
    required this.thaiDo,
    required this.teacherId,
    required this.fullName,
    required this.content,
    required this.monthlyReview,
  });
  factory DetailBaoCaoModel.fromJson(Map<String, dynamic> json) {
    return DetailBaoCaoModel(
      chuyenCan: json['cc'],
      baiTap: json['bt'],
      thaiDo: json['tc'],
      teacherId: json['chat']['teachers_id'],
      fullName: json['chat']['full_name'],
      content: json['chat']['content'],
      monthlyReview: (json['value'] as List)
          .map((e) => MonthlyReviewModel.fromJson(e))
          .toList(),
    );
  }
}

class MonthlyReviewModel {
  final String monthName;
  final String teacherName;
  final String id;
  final String customerCourseScheduleId;
  final String evaluationMonthId;
  final List<String> nhanXet;
  final List<String> caiThien;
  MonthlyReviewModel({
    required this.monthName,
    required this.teacherName,
    required this.id,
    required this.customerCourseScheduleId,
    required this.evaluationMonthId,
    required this.nhanXet,
    required this.caiThien,
  });
  factory MonthlyReviewModel.fromJson(Map<String, dynamic> json) {
    return MonthlyReviewModel(
      monthName: json['evaluation_month_name'],
      teacherName: json['teachers_full_name'],
      id: json['id'],
      customerCourseScheduleId: json['customer_course_schedule_id'],
      evaluationMonthId: json['evaluation_month_id'],
      nhanXet:
          (json['nhan_xet'] as List).map((e) => e['name'].toString()).toList(),
      caiThien: (json['can_cai_thien'] as List)
          .map((e) => e['name'].toString())
          .toList(),
    );
  }
}

class MycourseBaiTapModel {
  final String scheduleId;
  final List<BaiTapValueModel> value;
  MycourseBaiTapModel({
    required this.scheduleId,
    required this.value,
  });
  factory MycourseBaiTapModel.fromJson(Map<String, dynamic> json) {
    return MycourseBaiTapModel(
      scheduleId: json['customer_course_schedule_id'].toString(),
      value: (json['value'] as List)
          .map((e) => BaiTapValueModel.fromJson(e))
          .toList(),
    );
  }
}

class BaiTapValueModel {
  final String id;
  final String name;
  final DateTime timeDeadline;
  final String type;
  final String typeName;
  final int status;
  final String note;
  BaiTapValueModel({
    required this.id,
    required this.name,
    required this.timeDeadline,
    required this.type,
    required this.typeName,
    required this.status,
    required this.note,
  });
  factory BaiTapValueModel.fromJson(Map<String, dynamic> json) {
    return BaiTapValueModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      timeDeadline:
          DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['time_deadline'] ?? ''),
      type: json['type'] ?? '',
      typeName: json['type_name'] ?? '',
      status: int.tryParse(json['status'].toString()) ?? 0,
      note: json['note'] ?? '',
    );
  }
}

class VideoLessonModel {
  final String id;
  final String customerCourseScheduleId;
  final String settingCourseTypeId;
  final String name;
  final String teachingContent;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String phongHoc;
  final String teacherFullName;
  final String content;
  final bool viewVideo;
  final String noteVideo;
  VideoLessonModel({
    required this.id,
    required this.customerCourseScheduleId,
    required this.settingCourseTypeId,
    required this.name,
    required this.teachingContent,
    required this.timeStart,
    required this.timeEnd,
    required this.phongHoc,
    required this.teacherFullName,
    required this.content,
    required this.viewVideo,
    required this.noteVideo,
  });
  factory VideoLessonModel.fromJson(Map<String, dynamic> json) {
    return VideoLessonModel(
      id: json['id'] ?? '',
      customerCourseScheduleId: json['customer_course_schedule_id'] ?? '',
      settingCourseTypeId: json['setting_course_type_id'] ?? '',
      name: json['name'] ?? '',
      teachingContent: json['teaching_content'] ?? '',
      timeStart:
          DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['time_start'] ?? ''),
      timeEnd: DateFormat("yyyy-MM-dd hh:mm:ss").parse(json['time_end'] ?? ''),
      phongHoc: json['phong_hoc'] ?? '',
      teacherFullName: json['teachers_full_name'] ?? '',
      content: json['content'] ?? '',
      viewVideo: json['view_video'] ?? '',
      noteVideo: json['note_video'] ?? '',
    );
  }
}

class EvaluationModel {
  final String avatar;
  final String fullName;
  final String star;
  final List<String> value;
  EvaluationModel({
    required this.avatar,
    required this.fullName,
    required this.star,
    required this.value,
  });
  factory EvaluationModel.fromJson(Map<String, dynamic> json) {
    return EvaluationModel(
      avatar: json['avatar'] ?? '',
      fullName: json['full_name'] ?? '',
      star: json['star'] ?? '',
      value: (json['value'] as List).map((e) => e['text'].toString()).toList(),
    );
  }
}

class FreeCourseModel {
  final String courseName;
  final String courseId;
  final String courseImg;
  final String lessonNumber;
  final String metaDescription;
  FreeCourseModel({
    required this.courseName,
    required this.courseId,
    required this.courseImg,
    required this.lessonNumber,
    required this.metaDescription,
  });
  factory FreeCourseModel.fromJson(Map<String, dynamic> json) {
    return FreeCourseModel(
      courseName: json['course_name'] ?? '',
      courseId: json['course_id'] ?? '',
      courseImg: json['course_img'] ?? '',
      lessonNumber: json['lesson_number'] ?? '',
      metaDescription: json['meta_description'] ?? '',
    );
  }
}

class CourseVideoModel {
  final DetailClassModel detailClassModel;
  final List<TopicalModel> listTopical;
  CourseVideoModel({
    required this.detailClassModel,
    required this.listTopical,
  });
  factory CourseVideoModel.fromJson(Map<String, dynamic> json) {
    return CourseVideoModel(
      detailClassModel: DetailClassModel.fromJson(json['info']),
      listTopical: ((json['topical'] as List)
          .map((e) => TopicalModel.fromJson(e))
          .toList()),
    );
  }
}

class DetailClassModel {
  final String name;
  final String courseId;
  final String settingCourseTypeName;
  final String settingCourseTypeId;
  final String courseImg;
  final String metaDescription;
  final int percentLearning;
  DetailClassModel({
    required this.name,
    required this.courseId,
    required this.settingCourseTypeName,
    required this.settingCourseTypeId,
    required this.courseImg,
    required this.metaDescription,
    required this.percentLearning,
  });
  factory DetailClassModel.fromJson(Map<String, dynamic> json) {
    return DetailClassModel(
      name: json['course_name'] ??
          json['name'].replaceAll(RegExp(r'&amp;'), '&') ??
          '',
      courseId: json['course_id'] ?? '',
      settingCourseTypeName: json['setting_course_type_name'] ?? '',
      settingCourseTypeId: json['setting_course_type_id'] ?? '',
      courseImg: json['course_img'] ?? '',
      metaDescription: json['meta_description'] ?? '',
      percentLearning: json['percent_learning'] ?? 0,
    );
  }
}

class TopicalModel {
  final String topicalId;
  final String nameTopical;
  final String courseId;
  final String settingCourseTypeId;
  final String numLLessson;

  TopicalModel({
    required this.topicalId,
    required this.nameTopical,
    required this.courseId,
    required this.settingCourseTypeId,
    required this.numLLessson,
  });
  factory TopicalModel.fromJson(Map<String, dynamic> json) {
    return TopicalModel(
      topicalId: json['topical_id'] ?? '',
      nameTopical: json['name_topical'] ?? '',
      courseId: json['course_id'] ?? '',
      settingCourseTypeId: json['setting_course_type_id'] ?? '',
      numLLessson: json['num_lessson'] ?? '0',
    );
  }
}
