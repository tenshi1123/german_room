import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:german_room/utils/widget/custom_dialog.dart';
import 'package:intl/intl.dart';
import 'package:german_room/modules/chat/screen/list_conversation_screen.dart';
import 'package:german_room/modules/course/recomment_course.dart';
import 'package:german_room/modules/feature_home/academic_report_screen.dart';
import 'package:german_room/modules/feature_home/evaluate/evaluate_screen.dart';
import 'package:german_room/modules/lesson/detail_lesson_screen.dart';
import 'package:german_room/modules/notification/notification.dart';
import 'package:german_room/student_models/chat_models.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/student_repo/chat_repo.dart';
import 'package:german_room/student_repo/customer_repo.dart';
import 'package:german_room/student_repo/extension_repo.dart';
import 'package:german_room/student_repo/home_repo.dart';
import 'package:german_room/student_models/customer_models.dart';
import 'package:german_room/student_models/home_model.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/student_models/review_models.dart';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

import '../../feature_home/exercise/exercise_screen.dart';
import 'extension.dart/schedule_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.infomodel,
  });
  final StudentHomeModel infomodel;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StudentHomeModel infomodel;
  @override
  void initState() {
    infomodel = widget.infomodel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 390.w,
            height: 120.h,
            decoration: BoxDecoration(gradient: mainGradient),
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      CircleAvatar(
                        radius: 24.r,
                        backgroundImage:
                            NetworkImage(infomodel.customerInfoModel.img),
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Chào mừng trở lại !',
                            style:
                                defaultText14Re.copyWith(color: Colors.white),
                          ),
                          Text(
                            infomodel.customerInfoModel.fullName,
                            style: defaultText18B.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          List<ChatModel> listConversation =
                              await ChatRepo().getListConversation();
                          if (!context.mounted) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ListConversationScreen(
                                listConversation: listConversation,
                              ),
                            ),
                          );
                        },
                        child: _chatNoti(icon: 'assets/icons/chat.svg'),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      GestureDetector(
                        onTap: () async {
                          List<NotiModel> listNoti =
                              await CustomerRepo().getListNoti();
                          if (!context.mounted) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(
                                listNoti: listNoti,
                              ),
                            ),
                          );
                        },
                        child: _chatNoti(icon: 'assets/icons/ring.svg'),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CalenderScreen(
                                type: 1,
                              )),
                    );
                  },
                  child: _homeIcon(
                      title: 'Lịch học', image: 'assets/images/lich_thi.png')),
              GestureDetector(
                  onTap: () async {
                    ListExcerciseModel model = await HomeRepo().getListBaiTap();
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExerciseScreen(
                          model: model,
                        ),
                      ),
                    );
                  },
                  child: _homeIcon(
                      title: 'Lịch sử', image: 'assets/images/bai_tap.png')),
              GestureDetector(
                onTap: () async {
                  BaoCaoHocTapModel model = await HomeRepo().getBaoCaoDiem();
                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcademicReportScreen(
                        model: model,
                      ),
                    ),
                  );
                },
                child: _homeIcon(
                    title: 'Báo cáo', image: 'assets/images/bao_cao_diem.png'),
              ),
              // Nút đánh giá
              GestureDetector(
                  onTap: () async {
                    List<ReviewModels> listReview =
                        await ExtensionRepo().getListReview();
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EvaluateScreen(
                          listReview: listReview,
                        ),
                      ),
                    );
                  },
                  child: _homeIcon(
                      title: 'Tự học', image: 'assets/images/danh_gia.png')),
            ],
          ),
          // Học phí
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          //   height: 44.h,
          //   width: 349.w,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(8.r),
          //       ),
          //       color: sub2Color),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Text(
          //         'Học phí chờ thanh toán',
          //         style: defaultText16M.copyWith(color: Colors.white),
          //       ),
          //       const SizedBox(
          //         width: 1,
          //       ),
          //       Text(
          //         '3.345.000đ',
          //         style: defaultText16M.copyWith(color: Colors.white),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '    Lịch học gần nhất',
            style: defaultText16B,
          ),
          SizedBox(
            width: 380.w,
            height: 250.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              //itemExtent: 390.0.w,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              itemCount: infomodel.lichHocSapToi.length,
              itemBuilder: (BuildContext context, int index) {
                return _Upcoming(
                  model: infomodel.lichHocSapToi[index],
                );
              },
            ),
          ),
          //Text(''),
          Text(
            '    Khóa học ',
            style: defaultText16B,
          ),
          SizedBox(
            width: 380.w,
            height: 230.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              //itemExtent: 390.0.w,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              itemCount: infomodel.listCourse.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecommentCourse(),
                        ),
                      );
                    },
                    child: _reComment(model: infomodel.listCourse[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _homeIcon({required String title, required String image}) {
  return SizedBox(
    //height: 96.h,
    width: 80.w,
    child: Column(
      children: [
        SizedBox(
          height: 65.h,
          width: 65.w,
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 62.h,
                  width: 62.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, gradient: mainGradient2),
                ),
              ),
              Center(
                  child: Image.asset(
                image,
                width: 65.w,
                height: 62.h,
                fit: BoxFit.fill,
              )),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Center(
          child: Text(
            title,
            style: defaultText12M,
          ),
        ),
      ],
    ),
  );
}

Widget _reComment({required CourseModels model}) {
  return Container(
    height: 228.h,
    width: 242.w,
    padding: EdgeInsets.symmetric(horizontal: 10.w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //Image.asset('assets/images/recomment.png'),
        ClipRRect(
            borderRadius:
                BorderRadius.circular(15.r), // Adjust the radius as needed
            child: Image.network(
              model.img,
              fit: BoxFit.cover,
              width: 222.w,
              height: 141.h,
            )),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
          decoration: BoxDecoration(
            color: sub2Color.withValues(alpha: 0.5),
          ),
          child: Center(
            child: Text(
              model.categoryName,
              style: defaultText14M.copyWith(
                color: sub1Color,
              ),
            ),
          ),
        ),
        Text(
          model.name,
          style: defaultText14M,
        ),
        Text(
          'Lộ trình: ${model.soBuoiHoc}',
          style: defaultText12Re,
        ),
      ],
    ),
  );
}

Widget _chatNoti({
  required String icon,
}) {
  return SizedBox(
    height: 33.h,
    width: 33.w,
    child: Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            height: 33.h,
            width: 33.w,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: main2Color,
            ),
            child: SvgPicture.asset(icon),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 8.h,
            width: 8.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: sub2Color,
            ),
          ),
        ),
      ],
    ),
  );
}

//widget lịch học sắp tới
class _Upcoming extends StatelessWidget {
  const _Upcoming({required this.model});
  final CalendarModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        VideoLessonModel videoLesson =
            await MycourseRepo().getVideoLesson(id: model.id);
        if (!context.mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailLessonScreen(
              videoLessonModel: videoLesson,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        //height: 222.h,
        width: 349.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  //height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                    gradient: mainGradient2,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.r),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: (Text(
                    model.courseScheduleAlias,
                    style: defaultText16B.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )),
                ),
                SizedBox(
                  width: 15.w,
                ),
                SizedBox(
                  //height: 70.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        model.name,
                        style: defaultText16B,
                      ),
                      Text(
                        DateFormat("dd/MM/yyyy").format(model.day),
                        style: defaultText14Re,
                      ),
                      Text(
                        '${model.timeStart.substring(0, 4)} - ${model.timeEnd.substring(0, 4)}',
                        style: defaultText14Re,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              //height: 74.h,
              width: 325.w,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: key1Color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          'Phòng học',
                          style: defaultText14Re,
                        ),
                      ),
                      Text(
                        model.phongHocName,
                        style: defaultText14B,
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: Text(
                          'Địa chỉ',
                          style: defaultText14Re,
                        ),
                      ),
                      SizedBox(
                        width: 220.w,
                        child: Text(
                          model.cosoAddress,
                          style: defaultText14B,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 12.w,
                ),
                Container(
                  height: 14.h,
                  width: 14.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  model.status,
                  style: defaultText14M,
                ),
                SizedBox(
                  width: 80.w,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const LeaveRequestDialog(),
                    );
                  },
                  child: Container(
                    height: 29.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: sub2Color,
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Xin nghỉ',
                        style: defaultText14B.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
