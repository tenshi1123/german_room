import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/class_screen.dart';
import 'package:german_room/modules/course/course_details_screen.dart';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ClassHistoryScreen extends StatefulWidget {
  const ClassHistoryScreen({super.key});

  @override
  State<ClassHistoryScreen> createState() => _ClassHistoryScreenState();
}

class _ClassHistoryScreenState extends State<ClassHistoryScreen> {
  List<MyCourseModel> listMyCourse = [];
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    listMyCourse = await MycourseRepo().getListMyCourse();
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
                        'Lịch sử học tập',
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
                'Danh sách lớp học',
                style: defaultText20B,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: listMyCourse.length,
                itemBuilder: (BuildContext context, int index) {
                  return _CourseItem(
                    index: index,
                    model: listMyCourse[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _CourseItem extends StatelessWidget {
  const _CourseItem({super.key, required this.index, required this.model});
  final int index;
  final MyCourseModel model;
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    gradient: mainGradient,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.r),
                    ),
                  ),
                  child: Text(
                    model.settingCourseTypeName,
                    style: defaultText12B.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            'Lớp: ${model.courseScheduleName} ',
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
          GestureDetector(
            onTap: () async {
              ClassDetailModel detailClassModel =
                  await MycourseRepo().getListLesson(
                typeId: model.settingCourseTypeId,
                scheduleId: model.courseScheduleId,
              );
              pushWithoutNavBar(
                context,
                MaterialPageRoute(
                  builder: ((context) => ClassScreen(
                        detailClassModel: detailClassModel,
                      )),
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
