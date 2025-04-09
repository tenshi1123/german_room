class ApiPath {
  //baseurl
  static const String baseUrl = 'https://lms.german_roomenglish.edu.vn/';

  static const String hocvienUrl = '${baseUrl}api/customer';

  //api về đăng nhập, các thông tin của học sinh
  static const String refreshToken = '$hocvienUrl/refresh_token/';
  static const String login = '$hocvienUrl/login';

  //Thông tin và đổi thông tin học viên
  static const String profile = '$hocvienUrl/profile';
  static const String changePassword = '$hocvienUrl/profile/change_password';
  static const String changeAvatar = '$hocvienUrl/change_avatar';
  static const String changeInfo = '$hocvienUrl/profile/edit';

  //Danh sách tin tức
  static const String post = '$hocvienUrl/post';
  static const String postDetail = '$hocvienUrl/post/detail';

  //Diem danh
  static const String diemDanh = '$hocvienUrl/diem_danh';
  static const String detailDiemdanh = '$hocvienUrl/detail_diem_danh';
  static const String notification = '$hocvienUrl/notification';
  static const String chat = '$hocvienUrl/chat';
  static const String teacherChat = '${baseUrl}api/teachers/chat';
  static const String chatTeacherCustomer = '$hocvienUrl/chat_teacher_customer';
  static const String chatTeacher = '$hocvienUrl/chat_messages';
  static const String sendMessage = '$hocvienUrl/send_chat_messages';
  static const String sendImageMessage = '$hocvienUrl/send_chat_img';
  //Lịch thi
  static const String offlineExamSchedule = '$hocvienUrl/offline_exam_schedule';
  static const String changeCoso = '$offlineExamSchedule/change_coso';
  static const String changeDay = '$offlineExamSchedule/change_day';
  static const String dangKyThi = '$offlineExamSchedule/dang_ky';

  //Bài tập + báo báo cáo học tập + feedback
  static const String baiTap = '$hocvienUrl/bai_tap';
  static const String detailBaiTap = '$hocvienUrl/mycourse/detail_exercise';
  static const String reportExercise = '$hocvienUrl/bao_cao_hoc_tap';
  static const String listFeedback = '$hocvienUrl/danh_gia';
  static const String detailFeedback = '$hocvienUrl/detail_danh_gia';
  //TKB
  static const String calendar = '$hocvienUrl/calendar';
  static const String listFeeback = '$hocvienUrl/danh_gia';
  static const String detailsFeedback = '$hocvienUrl/detail_danh_gia';
  //Khóa học của tôi khoa hoc
  static const String myCourse = '$hocvienUrl/mycourse';
  static const String detailMyCourse = '$myCourse/detail';
  static const String detailBaoCao = '$myCourse/detail/bao_cao';
  static const String myCoursedetailBaiTap = '$myCourse/detail/bai_tap';
  //Chi tiet khoa hoc
  static const String coureDetail = '$hocvienUrl/course/detail';
  //Xin nghi
  static const String xinNghi = '$myCourse/xin_nghi';
  static const String detailBuoihoc = '$myCourse/detail/buoi_hoc';
  static const String baiTapKhoahoc = '$myCourse/detail/bai_tap';
  static const String detailBaitap = '$myCourse/detail_exercise';
  static const String submitExeTL = '$myCourse/submit_exercise_tu_luan';

  //payment
  static const String payment = '$hocvienUrl/payment';

  //api do oneSignal cung cấp
  // static const String oneSignal =
  //     'https://api.onesignal.com/notifications?app_id=1f643336-9d73-4c65-ac00-38d499b8c462';
}
