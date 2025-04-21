import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({
    super.key,
    required this.detailMyCourse,
    required this.type,
  });
  final CourseVideoModel detailMyCourse;
  final int type;
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
                        model.detailClassModel.name,
                        style: defaultText20B.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 0.h,
                //   left: 250.w,
                //   child: Image.asset(
                //     'assets/images/course_icon.png',
                //     width: 115.w,
                //     height: 92.h,
                //     fit: BoxFit.fill,
                //   ),
                // )
              ],
            ),
          ),
          Container(
            width: 350.w,
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
                return LessonItem(
                  index: index,
                  topicModel: model.listTopical[index],
                  type: widget.type,
                );
              }),
        ],
      ),
    );
  }
}

class LessonItem extends StatefulWidget {
  const LessonItem(
      {super.key,
      required this.index,
      required this.topicModel,
      required this.type});
  final int index;
  final TopicalModel topicModel;
  final int type;
  @override
  State<LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  bool isExpanded = false;
  List<LessonVideoModel> listLessonVideoModels = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 12.h,
        ),
        InkWell(
          onTap: () async {
            if (listLessonVideoModels.isEmpty) {
              listLessonVideoModels = await MycourseRepo().getlistLessonVideo(
                topicalId: widget.topicModel.topicalId,
                settingCoureTypeId: widget.topicModel.settingCourseTypeId,
                type: widget.type,
              );
            }

            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Row(
            children: [
              SizedBox(
                width: 16.w,
              ),
              Container(
                height: 34.h,
                width: 34.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xff2F9CD3),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    '${widget.index + 1}',
                    style: defaultText14M.copyWith(
                      color: const Color(0xff2F9CD3),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 260.w,
                    child: Text(
                      widget.topicModel.nameTopical,
                      style: defaultText16M.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.topicModel.numLLessson} bài',
                    style: defaultText12M.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff3C3C3C).withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_right_outlined),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
        ),
        Divider(
          indent: 20.w,
          endIndent: 20.w,
        ),
        if (isExpanded)
          Column(
            children: listLessonVideoModels
                .map((e) => GestureDetector(
                      // onTap: () async {
                      //   String link = await VideoRepository().getLinkVideo(
                      //       lessonId: e.lessonsId,
                      //       settingCoureTypeId: e.settingCourseTypeId,
                      //       lessonType: e.lessonType);
                      //   pushWithoutNavBar(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: ((context) => WebViewScreen(
                      //                 link: link,
                      //                 title: e.name,
                      //               )
                      //           // AnimationPlayer(
                      //           //       link: link,
                      //           //     )
                      //           ),
                      //     ),
                      //   );
                      // },
                      onTap: () async {
                        String link = await MycourseRepo().getLinkVideo(
                          lessonId: e.lessonsId,
                          settingCoureTypeId: e.settingCourseTypeId,
                          lessonType: e.lessonType,
                          type: 1,
                        );
                        if (!await launchUrl(Uri.parse(link))) {
                          throw Exception('Could not launch ');
                        }
                      },
                      child: DetailItem(
                        title: e.name,
                        index: listLessonVideoModels.indexOf(e),
                      ),
                    ))
                .toList(),
          ),
      ],
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem({super.key, required this.title, required this.index});
  final String title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 16.w,
        ),
        Column(
          children: [
            SvgPicture.asset(
              'assets/icons/green_tick.svg',
              height: 12.h,
              width: 12.w,
            ),
            Container(
              height: 32.h,
              width: 1.w,
              margin: EdgeInsets.symmetric(vertical: 8.h),
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 16.w,
        ),
        Image.asset(
          'assets/images/video.png',
          height: 24.h,
          width: 24.w,
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: 16.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 267.w,
              child: Text(
                title,
                style: defaultText14M,
              ),
            ),
            SizedBox(
              width: 267.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bài giảng',
                    style: defaultText12M.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff3C3C3C).withValues(alpha: 0.6),
                    ),
                  ),
                  Text(
                    '10 Phút',
                    style: defaultText12M.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff3C3C3C).withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.h,
              width: 267.w,
              margin: EdgeInsets.symmetric(vertical: 4.h),
              decoration: const BoxDecoration(
                color: Color(0xffEDEDED),
              ),
            )
          ],
        ),
      ],
    );
  }
}
