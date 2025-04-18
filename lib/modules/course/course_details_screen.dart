import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/utils/constants/styles.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    super.key,
    required this.detailMyCourse,
  });
  final CourseVideoModel detailMyCourse;
  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  late final CourseVideoModel model;

  @override
  void initState() {
    model = widget.detailMyCourse;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          model.detailClassModel.name,
          style: defaultText14M,
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: 390.w,
            height: 180.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  model.detailClassModel.courseImg,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withValues(alpha: 0.5),
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              '\n${model.detailClassModel.metaDescription}\n',
              style: defaultText14M,
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: model.listTopical.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () async {
                    // String detailFeedBack =
                    //     await HomeRepo().getDetailFeedback(
                    //   model.schedules[index].meetingId,
                    //   model.schedules[index].typeLearn,
                    //   model.schedules[index].meetingId,
                    // );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: ((context) => DetailReportScreen(
                    //           feedback: detailFeedBack,
                    //         )),
                    //   ),
                    // );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 32.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 8.h,
                          ),
                          SizedBox(
                            width: 120.w,
                            child: Text(
                              model.listTopical[index].nameTopical,
                              style: defaultText14B,
                            ),
                          ),
                          Text(
                            '${model.listTopical[index].numLLessson} buổi',
                            style: defaultText14Re,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ],
                      ),
                      Container(
                        height: 30.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Center(
                            child: Icon(Icons.keyboard_arrow_right_outlined)),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
