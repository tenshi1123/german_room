import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/detail_screen.dart';
import 'package:german_room/student_models/my_course_model.dart'
    as mycourse_model;
import 'package:german_room/student_models/schedule_model.dart';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({
    super.key,
    required this.detailClassModel,
  });
  final mycourse_model.ClassDetailModel detailClassModel;

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  List<mycourse_model.InfoLessonModel> listLesson = [];
  @override
  void initState() {
    super.initState();
    // List<InfoLessonModel> pastEvents = widget.detailClassModel.listLesson
    //     .where((e) => e.createdDate.isBefore(DateTime.now()))
    //     .toList();
    // List<InfoLessonModel> futureEvents = widget.detailClassModel.listLesson
    //     .where((e) => e.createdDate.isAfter(DateTime.now()))
    //     .toList();
    // pastEvents.sort((a, b) => b.createdDate.compareTo(a.createdDate));
    // futureEvents.sort((a, b) => a.createdDate.compareTo(b.createdDate));
    // listLesson.addAll(pastEvents);
    // listLesson.addAll(futureEvents);
    listLesson = widget.detailClassModel.listLesson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Center(
          child: Text(
            'Danh sách buổi học        ',
            style: defaultText18B.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: mainGradient),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                color: Colors.white,
              ),
              child: Image.network(
                widget.detailClassModel.detailClassModel.courseImg,
                width: 343.w,
                //height: 160.h,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 32.h,
              width: 226.w,
              margin: EdgeInsets.only(top: 8.h, left: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: const Color(0xff28B4E9),
              ),
              child: Center(
                child: Text(
                  widget
                      .detailClassModel.detailClassModel.settingCourseTypeName,
                  style: defaultText16M.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 16.w),
              child: Text(
                widget.detailClassModel.detailClassModel.name,
                style: defaultText20B.copyWith(
                  color: const Color(0xff273D8C),
                ),
              ),
            ),
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 16.w),
                      height: 8.h,
                      width: 296.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: const Color(0xffEDEDED),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 16.w),
                      height: 8.h,
                      width: (296 *
                              widget.detailClassModel.detailClassModel
                                  .percentLearning /
                              100)
                          .w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        color: const Color(0xff28B4E9),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${widget.detailClassModel.detailClassModel.percentLearning}%',
                  style: defaultText16B.copyWith(
                    color: const Color(0xff28B4E9),
                  ),
                ),
              ],
            ),
            listLesson.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Image.asset(
                          'assets/images/empty.png',
                          height: 200.h,
                          width: 200.w,
                        ),
                        Text(
                          'Học sinh chưa có lớp học',
                          style: defaultText16B,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: listLesson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () async {
                          DetaiLessonModel listExcercise =
                              await MycourseRepo().getDetailSchedule(
                            checkinOffId: listLesson[index].checkId,
                            typeLearn: listLesson[index].typeLearn,
                            meetingId: listLesson[index].meetingId,
                          );

                          pushWithoutNavBar(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => DetailScreen(
                                    detailLesson: listExcercise,
                                  )),
                            ),
                          );
                        },
                        child: Container(
                            width: 343.w,
                            margin: EdgeInsets.only(top: 16.h),
                            padding: EdgeInsets.symmetric(
                                vertical: 16.h, horizontal: 16.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff273D8C).withAlpha(80),
                                  spreadRadius: 0,
                                  blurRadius: 8,
                                  offset: const Offset(
                                      0, 4), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${DateFormat("dd-MM-yyyy").format(listLesson[index].createdDate)} ${listLesson[index].cosoName}",
                                  style: defaultText14M.copyWith(
                                      color: const Color(0xff273D8C)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  listLesson[index].name,
                                  style: defaultText16B.copyWith(
                                      color: const Color(0xff273D8C)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  'Nội dung buổi học: ${listLesson[index].topic}',
                                  style: defaultText14M.copyWith(
                                      color: const Color(0xff273D8C)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                listLesson[index].leaveReason == ''
                                    ? const SizedBox()
                                    : Text(
                                        'Lịch sử nghỉ học \nLý do: ${listLesson[index].leaveReason}',
                                        style: defaultText14M.copyWith(
                                            color: const Color(0xffED1C24)),
                                      ),
                              ],
                            )),
                      );
                    }),
            SizedBox(
              height: 80.h,
            ),
          ],
        ),
      ),
    );
  }
}
