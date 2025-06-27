import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:german_room/modules/course/point_excercise.dart';
import 'package:german_room/student_models/home_model.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/student_repo/home_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class AcademicReportScreen extends StatelessWidget {
  const AcademicReportScreen({super.key, required this.model});
  final List<MyCourseModel> model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160.h,
            width: 390.w,
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
                  bottom: 30.h,
                  left: 20.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_left,
                          size: 30.h,
                          color: Colors.white,
                        ),
                        Text(
                          'Báo cáo học tập',
                          style: defaultText20B.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/bao_cao_diem.png',
                    width: 180.w,
                    height: 107.h,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: model.length,
              itemBuilder: (BuildContext context, int index) {
                return _BaoCaoHocTapItem(
                  model: model[index],
                );
              }),
        ],
      ),
    );
  }
}

class _BaoCaoHocTapItem extends StatelessWidget {
  const _BaoCaoHocTapItem({
    required this.model,
  });
  final MyCourseModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PointScreen(
              courseScheduleId: model.courseScheduleId,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
        child: Container(
          width: 350.w,
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 6.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              12.r,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                model.courseScheduleName,
                style: defaultText16B,
              ),
              Divider(
                color: key1Color,
                thickness: 1,
                indent: 15.w,
                endIndent: 15.w,
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailReportScreen extends StatelessWidget {
  const DetailReportScreen({super.key, required this.feedback});
  final String feedback;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160.h,
            width: 390.w,
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
                  bottom: 30.h,
                  left: 20.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_left,
                          size: 30.h,
                          color: Colors.white,
                        ),
                        Text(
                          'Chi tiết báo cáo',
                          style: defaultText20B.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/bao_cao_diem.png',
                    width: 180.w,
                    height: 107.h,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: HtmlWidget(
              feedback,
              textStyle: defaultText14B,
            ),
          ),
        ],
      ),
    );
  }
}
