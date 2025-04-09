class DiemDanhModel {
  final String id;
  final String courseName;
  final String alias;
  final String startDate;
  final String expiryDate;
  final String total;
  final String totalAttended;
  final String totalAbsent;
  final int percentage;
  DiemDanhModel({
    required this.id,
    required this.courseName,
    required this.alias,
    required this.startDate,
    required this.expiryDate,
    required this.total,
    required this.totalAttended,
    required this.totalAbsent,
    required this.percentage,
  });
  factory DiemDanhModel.fromJson(Map<String, dynamic> json) {
    return DiemDanhModel(
      id: json['id'],
      courseName: json['course_name'] ?? '',
      alias: json['alias'] ?? '',
      startDate: json['start_date'] ?? '',
      expiryDate: json['expiry_date'] ?? '',
      total: json['total'] ?? '',
      totalAttended: json['total_attended'] ?? '',
      totalAbsent: json['total_absent'] ?? '',
      percentage: json['percentage'] ?? 0,
    );
  }
}

class InfoDiemDanh {
  final String courseName;
  final String alias;
  final String settingCourseTypeId;
  final String startDate;
  final String expiryDate;
  final String total;
  final String totalAttended;
  final String totalAbsent;
  final int totalChuahoc;
  final List<DetailDiemDanh> daqua;
  final List<DetailDiemDanh> saptoi;
  InfoDiemDanh({
    required this.courseName,
    required this.alias,
    required this.settingCourseTypeId,
    required this.startDate,
    required this.expiryDate,
    required this.total,
    required this.totalAttended,
    required this.totalAbsent,
    required this.totalChuahoc,
    required this.daqua,
    required this.saptoi,
  });
  factory InfoDiemDanh.fromJson(Map<String, dynamic> json) {
    return InfoDiemDanh(
      courseName: json['value']['course_name'],
      alias: json['value']['alias'],
      settingCourseTypeId: json['value']['setting_course_type_id'],
      startDate: json['value']['start_date'],
      expiryDate: json['value']['expiry_date'],
      total: json['value']['total'],
      totalAttended: json['value']['total_attended'],
      totalAbsent: json['value']['total_absent'],
      totalChuahoc: json['value']['total_chua_hoc'],
      daqua: ((json['da_qua'] as List)
          .map((e) => DetailDiemDanh.fromJson(e))
          .toList()),
      saptoi: ((json['sap_toi'] as List)
          .map((e) => DetailDiemDanh.fromJson(e))
          .toList()),
    );
  }
}

class DetailDiemDanh {
  final String day;
  final String time;
  final String teacherName;
  final String gvStatus;
  final String gvStatusName;
  final String phongHoc;
  DetailDiemDanh({
    required this.day,
    required this.time,
    required this.teacherName,
    required this.gvStatus,
    required this.gvStatusName,
    required this.phongHoc,
  });
  factory DetailDiemDanh.fromJson(Map<String, dynamic> json) {
    return DetailDiemDanh(
      day: json['day'] ?? '',
      time: json['time'] ?? '',
      teacherName: json['teachers_full_name'] ?? '',
      gvStatus: json['gv_status'] ?? '',
      gvStatusName: json['gv_status_name'] ?? '',
      phongHoc: json['phong_hoc'] ?? '',
    );
  }
}
