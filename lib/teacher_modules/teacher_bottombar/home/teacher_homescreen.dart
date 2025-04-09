import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:german_room/modules/chat/screen/list_conversation_screen.dart';
import 'package:german_room/modules/notification/notification.dart';
import 'package:german_room/student_models/chat_models.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/student_repo/chat_repo.dart';
import 'package:german_room/teacher/teacher_model/home_teacher_model.dart';
import 'package:german_room/teacher/teacher_model/teacher_class_model.dart';
import 'package:german_room/teacher/teacher_repo/teacher_class_repo.dart';
import 'package:german_room/teacher/teacher_repo/teacher_repo.dart';
import 'package:german_room/teacher_modules/teacher_bottombar/home/lichhen_screen.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../teacher_class/teacher_detail_lesson.dart';

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen(
      {super.key, required this.infoModel, required this.teacherProfileModel});
  final TeacherHomeModel infoModel;
  final TeacherProfileModel teacherProfileModel;
  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: 390.w,
          height: 844.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/home_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 68.h,
              ),
              const _AvatarRow(),
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.h),
                child: Text(
                  widget.teacherProfileModel.fullName,
                  style: defaultText16B.copyWith(
                      fontSize: 24.sp, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 2.h),
                child: Text(
                  'Today, ${DateFormat("dd-MM-yyyy").format(DateTime.now())}',
                  style: defaultText16Re.copyWith(
                    fontSize: 16.sp,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 28.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Text(
                            'Lịch dạy gần nhất',
                            style: defaultText16B,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.r),
                              ),
                              child: SizedBox(
                                height: 218.h,
                                width: 370.w,
                                child: PageView.builder(
                                  padEnds: false,
                                  controller: controller,
                                  itemCount: widget.infoModel.lichhoc.length > 3
                                      ? 3
                                      : widget.infoModel.lichhoc.length,
                                  itemBuilder: (_, index) {
                                    return _CommingSchedule(
                                      lichHocModel:
                                          widget.infoModel.lichhoc[index],
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            SmoothPageIndicator(
                              controller: controller,
                              count: widget.infoModel.lichhoc.length > 3
                                  ? 3
                                  : widget.infoModel.lichhoc.isEmpty
                                      ? 1
                                      : widget.infoModel.lichhoc.length,
                              effect: CustomizableEffect(
                                activeDotDecoration: DotDecoration(
                                  width: 20.w,
                                  height: 8.h,
                                  color: const Color(0xff00AEEF),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                dotDecoration: DotDecoration(
                                  width: 8.w,
                                  height: 8.h,
                                  color: const Color(0xff00AEEF)
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  verticalOffset: 0,
                                ),
                                spacing: 6.0,
                              ),
                              onDotClicked: (index) {
                                controller.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              },
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            Container(
                              width: 390.w,
                              height: 390.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32.r),
                                  topRight: Radius.circular(32.r),
                                ),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/images/bottom_background.png"),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50.h,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        pushWithoutNavBar(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LichHenScreen(
                                                      listLichHen: widget
                                                          .infoModel.lichhen,
                                                    )));
                                      },
                                      child: AppointmentCard(
                                        count: widget.infoModel.lichhen.length,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class _AvatarRow extends StatelessWidget {
  const _AvatarRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16.w,
        ),
        Image.asset(
          'assets/images/avatar.png',
          height: 48.h,
          width: 48.w,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            List<ChatModel> listConversation =
                await ChatRepo().getTeacherListConversation();
            if (!context.mounted) return;
            pushWithoutNavBar(
              context,
              MaterialPageRoute(
                builder: (context) => ListConversationScreen(
                  listConversation: listConversation,
                ),
              ),
            );
          },
          child: Image.asset(
            'assets/images/mess.png',
            height: 45.h,
            width: 45.w,
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        GestureDetector(
          onTap: () async {
            List<NotiModel> listNoti = await TeacherRepo().getListNoti();
            if (!context.mounted) return;
            pushWithoutNavBar(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationScreen(
                  listNoti: listNoti,
                ),
              ),
            );
          },
          child: Image.asset(
            'assets/images/noti.png',
            height: 45.h,
            width: 45.w,
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
      ],
    );
  }
}

class _CommingSchedule extends StatelessWidget {
  const _CommingSchedule({required this.lichHocModel});
  final LichHocModel lichHocModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<DiemDanhHSModel> listDiemDanh = await TeacherClassRepo()
            .getListDiemDanh(
                courseScheduleId: lichHocModel.courseScheduleId,
                id: lichHocModel.id);
        List<ExamModel> listBaiTap = await TeacherClassRepo().getlistExam(
            courseScheduleId: lichHocModel.courseScheduleId,
            id: lichHocModel.id,
            type: 1);
        List<ExamModel> listDeThi = await TeacherClassRepo().getlistExam(
            courseScheduleId: lichHocModel.courseScheduleId,
            id: lichHocModel.id,
            type: 2);
        if (!context.mounted) return;
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => LessonDetail(
                      listDiemDanh: listDiemDanh,
                      title:
                          "${lichHocModel.name} ${lichHocModel.dayOfWeek} ${DateFormat('dd/MM/yyyy').format(lichHocModel.day)}",
                      listBaiTap: listBaiTap,
                      listDeThi: listDeThi,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 10.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff163065).withValues(alpha: 0.12),
              spreadRadius: 0,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff00AEEF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        lichHocModel.day.day.toString(),
                        style: defaultText16B.copyWith(
                            color: Colors.white, fontSize: 26.sp),
                      ),
                      Text(
                        'Tháng ${lichHocModel.day.month}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Text(lichHocModel.name, style: defaultText18B),
                    ),
                    const SizedBox(height: 5),
                    Text(lichHocModel.dayOfWeek, style: defaultText14M),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            RichText(
              text: TextSpan(
                text: 'Phòng học : ',
                style: defaultText16M,
                children: [
                  TextSpan(
                      text: lichHocModel.phongHoc,
                      style: defaultText16B.copyWith(
                          color: const Color(0xff00AEEF))),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                text: 'Chi nhánh : ',
                style: defaultText16M,
                children: [
                  TextSpan(
                      text: lichHocModel.coSo,
                      style: defaultText16B.copyWith(
                          color: const Color(0xff00AEEF))),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key, required this.count});
  final int count; // Số lượng thông báo
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon lịch hẹn
          Row(
            children: [
              Image.asset(
                'assets/images/schedule.png', // Đổi thành đường dẫn ảnh của bạn
                width: 40.w,
                height: 40.h,
              ),
              const SizedBox(width: 12),
              const Text(
                "Lịch hẹn học viên",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          // Badge thông báo số lượng
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xffED1C24),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withValues(alpha: 0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Text(
              count.toString(), // Số lượng thông báo
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
