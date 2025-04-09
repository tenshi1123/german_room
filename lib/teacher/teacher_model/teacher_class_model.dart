class TeacherClassModel {
  final List<ItemClassModel> zoom;
  final List<ItemClassModel> offl;
  TeacherClassModel({
    required this.zoom,
    required this.offl,
  });
  factory TeacherClassModel.fromJson(Map<String, dynamic> json) {
    return TeacherClassModel(
      zoom: (json['zoom'] as List)
          .map((data) => ItemClassModel.fromJson(data))
          .toList(),
      offl: (json['off'] as List)
          .map((data) => ItemClassModel.fromJson(data))
          .toList(),
    );
  }
}

class ItemClassModel {
  final String id;
  final String name;
  final String alias;
  final String dateStart;
  final String dateEnd;
  ItemClassModel({
    required this.id,
    required this.name,
    required this.alias,
    required this.dateStart,
    required this.dateEnd,
  });
  factory ItemClassModel.fromJson(Map<String, dynamic> json) {
    return ItemClassModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      alias: json['alias'] ?? '',
      dateStart: json['date_start'] ?? '',
      dateEnd: json['date_end'] ?? '',
    );
  }
}

class DetailClass {
  final String hinhThucHoc;
  final String id;
  final String name;
  final String alias;
  final String settingCourseTypeId;
  final List<DetailBuoiHoc> dsBuoiHoc;
  DetailClass({
    required this.hinhThucHoc,
    required this.id,
    required this.name,
    required this.alias,
    required this.settingCourseTypeId,
    required this.dsBuoiHoc,
  });
  factory DetailClass.fromJson(Map<String, dynamic> json) {
    return DetailClass(
      hinhThucHoc: json['courseSchedule']['hinh_thuc_hoc'] ?? '',
      id: json['courseSchedule']['id'] ?? '',
      name: json['courseSchedule']['name'] ?? '',
      alias: json['courseSchedule']['alias'] ?? '',
      settingCourseTypeId:
          json['courseSchedule']['setting_course_type_id'] ?? '',
      dsBuoiHoc: (json['danh_sach_buoi_hoc'] as List)
          .map((data) => DetailBuoiHoc.fromJson(data))
          .toList(),
    );
  }
}

class DetailBuoiHoc {
  final String id;
  final String name;
  final String teachingContent;
  final DateTime day;
  final String timeStart;
  final String timeEnd;
  final String classRoomName;
  final String address;
  DetailBuoiHoc({
    required this.id,
    required this.name,
    required this.teachingContent,
    required this.day,
    required this.timeStart,
    required this.timeEnd,
    required this.classRoomName,
    required this.address,
  });
  factory DetailBuoiHoc.fromJson(Map<String, dynamic> json) {
    return DetailBuoiHoc(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      teachingContent: json['teaching_content'] ?? '',
      day: DateTime.parse(json['day']),
      timeStart: json['time_start'] ?? '',
      timeEnd: json['time_end'] ?? '',
      classRoomName: json['class_room_name'] ?? '',
      address: json['coso_address'] ?? '',
    );
  }
}

class DiemDanhHSModel {
  final String name;
  final String status;
  DiemDanhHSModel({
    required this.name,
    required this.status,
  });
  factory DiemDanhHSModel.fromJson(Map<String, dynamic> json) {
    return DiemDanhHSModel(
      name: json['full_name'] ?? '',
      status: json['gv_status'] ?? '0',
    );
  }
}

class ExamModel {
  final String id;
  final String name;
  final String type;
  final String tenBuoiHoc;
  String? examId;
  String? urlFile;
  ExamModel({
    required this.id,
    required this.name,
    required this.type,
    required this.tenBuoiHoc,
    this.examId,
    this.urlFile,
  });
  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '0',
      tenBuoiHoc: json['ten_buoi_hoc'] ?? '',
      examId: json['exam_id'],
      urlFile: json['url_file'],
    );
  }
}

//document là bài tập
//exam là đề thi
class DetailedExamModel {
  final ValueModel valueModel;
  final List<StudentExamModel> examModel;
  final List<DocumentModel> documentModel;
  DetailedExamModel({
    required this.valueModel,
    required this.examModel,
    required this.documentModel,
  });
  factory DetailedExamModel.fromJson(Map<String, dynamic> json) {
    return DetailedExamModel(
      valueModel: ValueModel.fromJson(json['value']),
      examModel: json['exam'] == null
          ? []
          : (json['exam'] as List)
              .map((data) => StudentExamModel.fromJson(data))
              .toList(),
      documentModel: json['docment'] == null
          ? []
          : (json['docment'] as List)
              .map((data) => DocumentModel.fromJson(data))
              .toList(),
    );
  }
}

class ValueModel {
  final String name;
  final String examId;
  final String urlFile;
  final String type;
  final String id;
  final String courseScheduleId;
  final String exerciseId;
  final String timeDeadline;
  final String meetingsId;
  final String createdAt;

  ValueModel({
    required this.name,
    required this.examId,
    required this.urlFile,
    required this.type,
    required this.id,
    required this.courseScheduleId,
    required this.exerciseId,
    required this.timeDeadline,
    required this.meetingsId,
    required this.createdAt,
  });
  factory ValueModel.fromJson(Map<String, dynamic> json) {
    return ValueModel(
      name: json['name'] ?? '',
      examId: json['exam_id'] ?? '',
      urlFile: json['url_file'] ?? '',
      type: json['type'] ?? '0',
      id: json['id'] ?? '',
      courseScheduleId: json['course_schedule_id'] ?? '',
      exerciseId: json['exercise_id'] ?? '',
      timeDeadline: json['time_deadline'] ?? '',
      meetingsId: json['meetings_id'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class StudentExamModel {
  final String fullName;
  final String phone;
  final String email;

  final String name;
  final String slug;
  final List<ExamDataModel> examData;
  StudentExamModel({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.name,
    required this.slug,
    required this.examData,
  });
  factory StudentExamModel.fromJson(Map<String, dynamic> json) {
    return StudentExamModel(
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      examData: (json['exam_data'] as List)
          .map((data) => ExamDataModel.fromJson(data))
          .toList(),
    );
  }
}

class ExamDataModel {
  final String id;
  final String name;
  final String skills;
  final String ccseeId;
  final String examDetailResultsId;
  final String ccseeFinalMark;
  final String note;
  final String createdAt;
  final String finalMark;
  ExamDataModel({
    required this.id,
    required this.name,
    required this.skills,
    required this.ccseeId,
    required this.examDetailResultsId,
    required this.ccseeFinalMark,
    required this.note,
    required this.createdAt,
    required this.finalMark,
  });
  factory ExamDataModel.fromJson(Map<String, dynamic> json) {
    return ExamDataModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      skills: json['skills'] ?? '',
      ccseeId: json['ccsee_id'] ?? '',
      examDetailResultsId: json['exam_detail_results_id'] ?? '',
      ccseeFinalMark: json['ccsee_final_mark'] ?? '',
      note: json['note'] ?? '',
      createdAt: json['created_at'] ?? '',
      finalMark: json['final_mark'] ?? '',
    );
  }
}

class DocumentModel {
  final String fullName;
  final String id;
  final String urlFileCustomer;
  final String urlFileTeacher;
  final String finalMark;
  final String noteCustomers;
  final String noteTeacher;
  final String createdAt;
  DocumentModel({
    required this.fullName,
    required this.id,
    required this.urlFileCustomer,
    required this.urlFileTeacher,
    required this.finalMark,
    required this.noteCustomers,
    required this.noteTeacher,
    required this.createdAt,
  });
  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      fullName: json['full_name'] ?? '',
      id: json['id'] ?? '',
      urlFileCustomer: json['url_file_customer'] ?? '',
      urlFileTeacher: json['url_file_teachers'] ?? '',
      finalMark: json['final_mark'] ?? '',
      noteCustomers: json['note_customer'] ?? 'Không có ghi chú',
      noteTeacher: json['note_teachers'] ?? 'Không có ghi chú',
      createdAt: json['created_at'] ?? '',
    );
  }
}
