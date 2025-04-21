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

  // //api về đăng nhập, các thông tin của học sinh
  // static const String refreshToken = '$hocvienUrl/refresh_token/';
  // static const String login = '$hocvienUrl/login';

  // //Thông tin và đổi thông tin học viên
  // static const String profile = '$hocvienUrl/profile';
  // static const String changePassword = '$hocvienUrl/profile/change_password';
  // static const String changeAvatar = '$hocvienUrl/change_avatar';
  // static const String changeInfo = '$hocvienUrl/profile/edit';

  // //Danh sách tin tức
  // static const String post = '$hocvienUrl/post';
  // static const String postDetail = '$hocvienUrl/post/detail';

  // //Diem danh
  // static const String diemDanh = '$hocvienUrl/diem_danh';
  // static const String detailDiemdanh = '$hocvienUrl/detail_diem_danh';
  // static const String notification = '$hocvienUrl/notification';
  // static const String chat = '$hocvienUrl/chat';
  // static const String teacherChat = '${baseUrl}api/teachers/chat';
  // static const String chatTeacherCustomer = '$hocvienUrl/chat_teacher_customer';
  // static const String chatTeacher = '$hocvienUrl/chat_messages';
  // static const String sendMessage = '$hocvienUrl/send_chat_messages';
  // static const String sendImageMessage = '$hocvienUrl/send_chat_img';
  // //Lịch thi
  // static const String offlineExamSchedule = '$hocvienUrl/offline_exam_schedule';
  // static const String changeCoso = '$offlineExamSchedule/change_coso';
  // static const String changeDay = '$offlineExamSchedule/change_day';
  // static const String dangKyThi = '$offlineExamSchedule/dang_ky';

  // //Bài tập + báo báo cáo học tập + feedback
  // static const String baiTap = '$hocvienUrl/bai_tap';
  // static const String detailBaiTap = '$hocvienUrl/mycourse/detail_exercise';
  // static const String reportExercise = '$hocvienUrl/bao_cao_hoc_tap';
  // static const String listFeedback = '$hocvienUrl/danh_gia';
  // static const String detailFeedback = '$hocvienUrl/detail_danh_gia';
  // //TKB
  // static const String calendar = '$hocvienUrl/calendar';
  // static const String listFeeback = '$hocvienUrl/danh_gia';
  // static const String detailsFeedback = '$hocvienUrl/detail_danh_gia';
  // //Khóa học của tôi khoa hoc
  // static const String myCourse = '$hocvienUrl/mycourse';
  // static const String detailMyCourse = '$myCourse/detail';
  // static const String detailBaoCao = '$myCourse/detail/bao_cao';
  // static const String myCoursedetailBaiTap = '$myCourse/detail/bai_tap';
  // //Chi tiet khoa hoc
  // static const String coureDetail = '$hocvienUrl/course/detail';
  // //Xin nghi
  // static const String xinNghi = '$myCourse/xin_nghi';
  // static const String detailBuoihoc = '$myCourse/detail/buoi_hoc';
  // static const String baiTapKhoahoc = '$myCourse/detail/bai_tap';
  // static const String detailBaitap = '$myCourse/detail_exercise';
  // static const String submitExeTL = '$myCourse/submit_exercise_tu_luan';

  // //payment
  // static const String payment = '$hocvienUrl/payment';

  //api do oneSignal cung cấp
  // static const String oneSignal =
  //     'https://api.onesignal.com/notifications?app_id=1f643336-9d73-4c65-ac00-38d499b8c462';
}
