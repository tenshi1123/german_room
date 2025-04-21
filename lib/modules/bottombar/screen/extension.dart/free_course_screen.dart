import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/course/course_details_screen.dart';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class FreeCourseScreen extends StatefulWidget {
  const FreeCourseScreen({super.key});

  @override
  State<FreeCourseScreen> createState() => _FreeCourseScreenState();
}

class _FreeCourseScreenState extends State<FreeCourseScreen> {
  late List<FreeCourseModel> listFreeCourse = [];
  List<MyCourseModel> listMyCourse = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    listFreeCourse = await MycourseRepo().getLessonFree();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 130.h,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    width: 390.w,
                    height: 120.h,
                    decoration: BoxDecoration(gradient: mainGradient),
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  left: 22.w,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        'Tự học',
                        style: defaultText20B.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.h,
                  left: 250.w,
                  child: Image.asset(
                    'assets/images/course_icon.png',
                    width: 115.w,
                    height: 92.h,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Text(
                'Danh sách khóa học miễn phí',
                style: defaultText20B,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: listFreeCourse.length,
                itemBuilder: (BuildContext context, int index) {
                  return _FreeCourseItem(
                    index: index,
                    model: listFreeCourse[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _FreeCourseItem extends StatelessWidget {
  const _FreeCourseItem({required this.index, required this.model});
  final int index;
  final FreeCourseModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
      //height: 402.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              model.courseImg,
              width: 350.w,
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            width: 330.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' Khóa học : ${model.courseName}',
                  style: TextStyle(
                    color: key1Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            ' Số buổi học: ${model.lessonNumber} buổi',
            style: defaultText14M,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            ' ${model.metaDescription}',
            style: defaultText14M.copyWith(
              color: key1Color.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),

          SizedBox(
            height: 10.h,
          ),
          // LinearPercentIndicator(
          //   //width: 332.w,
          //   animation: true,
          //   lineHeight: 20.0,
          //   animationDuration: 2000,
          //   percent: model.totalAttended / model.totalBuoiHoc,
          //   barRadius: const Radius.circular(16),
          //   linearGradient: mainGradient,
          //   backgroundColor: state2,
          // ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () async {
              CourseVideoModel detailClassModel =
                  await MycourseRepo().getListTopical(
                typeId: '',
                scheduleId: '',
                courseId: model.courseId,
                type: 2,
              );
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetails(
                    detailMyCourse: detailClassModel,
                    type: 2,
                  ),
                ),
              );
            },
            child: Container(
              height: 39.h,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: key2Color,
                  )),
              child: Center(
                child: Text(
                  'Chi tiết',
                  style: TextStyle(
                    color: key1Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
