class ApiPath {
  //baseurl
  static const String baseUrl = 'https://lms.germanroom.vn/api';

  //Authentication
  static const String login = '$baseUrl/login';
  static const String register = '$baseUrl/register';
  static const String forgotPassword = '$baseUrl/forgot-password';
  static const String checkPhone = '$baseUrl/check-phone';
  static const String saveOtp = '$baseUrl/save-opt';
  static const String refreshToken = '$baseUrl/refresh-token';

  //Tai khoan ca nhan
  static const String userInfo = '$baseUrl/user/info';
  static const String deleteUser = '$baseUrl/user/delete';
  // check password
  static const String checkPassword = '$baseUrl/user/password/check';
  // Đổi mật khẩu
  static const String changePassword = '$baseUrl/user/password/update';
  // Thong bao
  static const String notification = '$baseUrl/notification';
  static const String noticationCheck = '$baseUrl/notification/check';
  static const String notificationDetail = '$baseUrl/notification/detail';
  static const String notificationUpdate = '$baseUrl/notification/update';

  // Trang chu
  // kiem tra danh gia va nhan xet
  static const String feedback = '$baseUrl/feedback';
  static const String feedbackDetail = '$baseUrl/feedback/detail';

  //Xin nghỉ theo buổi
  static const String xinNghi = '$baseUrl/schedule/leave';
  static const String cancelXinNghi = '$baseUrl/schedule/leave/cancel';

  //lich hoc
  static const String schedule = '$baseUrl/schedule';

  //Chi tiet 1 lich hoc
  static const String homework = '$baseUrl/homework';
  static const String uploadHomework = '$baseUrl/homework/upload';

  static const String listClass = '$baseUrl/class';
  static const String detailClass = '$baseUrl/class/detail';

  //Khoa hoc mien phi
  static const String lessonFree = '$baseUrl/lesson/free';
  static const String topicalFree = '$baseUrl/lesson/topical/free';
  static const String videoFree = '$baseUrl/lesson/topical/video/free';
  static const String detailVideoFree =
      '$baseUrl/lesson/topical/video/detail/free';

  //Danh sach khoa hoc
  static const String lesson = '$baseUrl/lesson';
  static const String topical = '$baseUrl/lesson/topical';
  static const String video = '$baseUrl/lesson/topical/video';
  static const String detailVideo = '$baseUrl/lesson/topical/video/detail';

  //chat
  static const String listTeacher = '$baseUrl/chat/lecture';
  static const String listMessage = '$baseUrl/chat/lecture/message';
  static const String sendMessage = '$baseUrl/chat/lecture/message/send';

  // Học liệu
  static const String listResource = '$baseUrl/hoc-lieu/category';
  static const String listResourceByCategory = '$baseUrl/hoc-lieu/course';
  static const String listLesson = '$baseUrl/hoc-lieu/lesson';
  //cái này giống hệt cái trên
  static const String danhMucCap1 = '$baseUrl/hoc-lieu/tong-quan';
  static const String danhMucCap2 = '$baseUrl/hoc-lieu/tong-quan/course';
  static const String danhMucCap3 = '$baseUrl/hoc-lieu/course/learning';
  static const String detailLesson = '$baseUrl/hoc-lieu/course/learning/part';
  static const String getLinkQuestion = '$baseUrl/hoc-lieu/';

  //api do oneSignal cung cấp
  // static const String oneSignal =
  //     'https://api.onesignal.com/notifications?app_id=1f643336-9d73-4c65-ac00-38d499b8c462';
}
