class ReviewModels {
  final String id;
  final String monthName;
  final String months;
  final String teacherName;
  final String courseName;
  final String alias;
  ReviewModels({
    required this.id,
    required this.monthName,
    required this.months,
    required this.teacherName,
    required this.courseName,
    required this.alias,
  });
  factory ReviewModels.fromJson(Map<String, dynamic> json) {
    return ReviewModels(
      id: json['id'] ?? '',
      monthName: json['evaluation_month_name'] ?? '',
      months: json['months'] ?? '',
      teacherName: json['teachers_full_name'] ?? '',
      courseName: json['course_schedule_name'] ?? '',
      alias: json['alias'] ?? '',
    );
  }
}
