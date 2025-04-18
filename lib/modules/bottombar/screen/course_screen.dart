import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/course/course_details_screen.dart';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = [
    // const Tab(text: 'Tất cả'),
    const Tab(text: 'Trả phí'),
    const Tab(text: 'Miễn phí'),
  ];
  late List<FreeCourseModel> listFreeCourse = [];
  List<MyCourseModel> listMyCourse = [];
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    listFreeCourse = await MycourseRepo().getLessonFree();
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
            height: 180.h,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    width: 390.w,
                    height: 140.h,
                    decoration: BoxDecoration(gradient: mainGradient),
                  ),
                ),
                Positioned(
                  top: 115.h,
                  left: 20.h,
                  bottom: 5.h,
                  child: Container(
                    width: 350.w,
                    height: 66.h,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        gradient: mainGradient2,
                      ),
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: _tabs,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 72.h,
                  left: 22.w,
                  child: Text(
                    'Khóa học của bạn',
                    style: defaultText20B.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60.h,
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
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: const ClampingScrollPhysics(),
                //     itemCount: listMyCourse.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return CourseItem(
                //         index: index,
                //         model: listMyCourse[index],
                //       );
                //     }),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: listMyCourse.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CourseItem(
                        index: index,
                        model: listMyCourse[index],
                      );
                    }),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: listFreeCourse.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _FreeCourseItem(
                        index: index,
                        model: listFreeCourse[index],
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseItem extends StatelessWidget {
  const CourseItem({super.key, required this.index, required this.model});
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
              CourseVideoModel detailClassModel =
                  await MycourseRepo().getListTopical(
                typeId: model.settingCourseTypeId,
                scheduleId: model.courseScheduleId,
                courseId: model.courseId,
                type: 1,
              );
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CourseDetails(
                    detailMyCourse: detailClassModel,
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
