class StudentHomeModel {
  final CustomerInfoModel customerInfoModel;
  final String totalCourse;
  final String chuyenCan;
  final List<CalendarModel> lichHocSapToi;
  final List<CourseModels> listCourse;
  StudentHomeModel({
    required this.customerInfoModel,
    required this.totalCourse,
    required this.chuyenCan,
    required this.lichHocSapToi,
    required this.listCourse,
  });
  factory StudentHomeModel.fromJson(Map<String, dynamic> json) {
    return StudentHomeModel(
      customerInfoModel: CustomerInfoModel.fromJson(json['customer']),
      totalCourse: json['total_course'],
      chuyenCan: json['chuyen_can'],
      lichHocSapToi: [
        for (var item in json['lich_hoc_sap_toi']) CalendarModel.fromJson(item)
      ],
      listCourse: [
        for (var item in json['course']) CourseModels.fromJson(item)
      ],
    );
  }
}

class CourseModels {
  final String categoryName;
  final String id;
  final String name;
  final String slug;
  final String img;
  final String soBuoiHoc;
  CourseModels({
    required this.categoryName,
    required this.id,
    required this.name,
    required this.slug,
    required this.img,
    required this.soBuoiHoc,
  });
  factory CourseModels.fromJson(Map<String, dynamic> json) {
    return CourseModels(
      categoryName: json['category_name'] ?? '',
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      img: json['img'] ?? '',
      soBuoiHoc: json['so_buoi_hoc'] ?? '',
    );
  }
}

class CustomerInfoModel {
  final String id;
  final String code;
  final String fullName;
  final String phone;
  final String email;
  final String gender;
  final String dob;
  final String img;
  final String schoolName;
  final String address;
  final String targetIelts;

  CustomerInfoModel({
    required this.id,
    required this.code,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.gender,
    required this.dob,
    required this.img,
    required this.schoolName,
    required this.address,
    required this.targetIelts,
  });
  factory CustomerInfoModel.fromJson(Map<String, dynamic> json) {
    return CustomerInfoModel(
      id: json['id'] ?? '',
      code: json['code'],
      fullName: json['full_name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      gender: json['gender'],
      dob: json['dob'],
      img: json['img'],
      schoolName: json['school_name'],
      address: json['address'],
      targetIelts: json['target_ielts'],
    );
  }
}

class CalendarModel {
  final String id;
  final String courseScheduleAlias;
  final DateTime day;
  final String name;
  final String timeStart;
  final String timeEnd;
  final String cosoAddress;
  final String phongHocName;
  final String teacherName;
  final String teacherAvatar;
  final String type;
  final String status;
  CalendarModel({
    required this.id,
    required this.courseScheduleAlias,
    required this.day,
    required this.name,
    required this.timeStart,
    required this.timeEnd,
    required this.cosoAddress,
    required this.phongHocName,
    required this.teacherName,
    required this.teacherAvatar,
    required this.type,
    required this.status,
  });
  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      id: json["id"] ?? '',
      courseScheduleAlias: json["course_schedule_alias"] ?? '',
      day: DateTime.parse(json["day"]),
      name: json["name"] ?? '',
      timeStart: json["time_start"] ?? '',
      timeEnd: json["time_end"] ?? '',
      cosoAddress: json["coso_address"] ?? '',
      phongHocName: json['phonghoc_name'] ?? '',
      teacherName: json['teachers_full_name'] ?? '',
      teacherAvatar: json['teachers_avatar'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
