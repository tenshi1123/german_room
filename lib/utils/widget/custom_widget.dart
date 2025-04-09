import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:german_room/modules/chat/screen/chat_screen.dart';
import 'package:german_room/modules/feature_home/exercise/detail_exam_screen.dart';
import 'package:german_room/modules/feature_home/exercise/exercise_detail_screen.dart';
import 'package:german_room/student_models/chat_models.dart';
import 'package:german_room/student_models/home_model.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/student_repo/chat_repo.dart';
import 'package:german_room/student_repo/home_repo.dart';
import 'package:german_room/teacher/teacher_model/home_teacher_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Lesson extends StatelessWidget {
  const Lesson(
      {super.key,
      required this.title1,
      required this.title2,
      required this.title3});
  final String title1;
  final String title2;
  final String title3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const DetailLessonScreen(),
        //   ),
        // );
      },
      child: Container(
        height: 100.h,
        width: 350.w,
        margin: EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Container(
              height: 70.h,
              width: 70.w,
              decoration: BoxDecoration(
                gradient: mainGradient2,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '21',
                    style: defaultText20B.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    'Tháng 5',
                    style: defaultText16M.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              height: 70.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'TOEIC 4 kỹ năng - Buổi 3',
                    style: defaultText16B,
                  ),
                  Text(
                    '21/05/2024',
                    style: defaultText14Re,
                  ),
                  Text(
                    '08:00 - 11:00 ~ 3 tiếng',
                    style: defaultText14Re,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ExamDay extends StatelessWidget {
  const ExamDay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ExcerciseItem extends StatelessWidget {
  const ExcerciseItem(
      {super.key, required this.isComplete, this.model, this.courseID});
  final bool isComplete;
  final BaiTapValueModel? model;
  final String? courseID;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DetailExcerciseModel detailExcerciseModel =
            await HomeRepo().getDetailExsercise(
          id: model?.id ?? '',
          customerCourseScheduleId: courseID ?? '',
        );
        if (!context.mounted) return;
        if (model?.type == '1') {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TestScreen(
              excerciseModel: detailExcerciseModel,
            ),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailTuLuanScreen(
              documentModel: detailExcerciseModel.document,
              valueModel: detailExcerciseModel.valueModel,
            ),
          ));
        }
      },
      child: Container(
        height: 66.h,
        width: 350.w,
        margin:
            EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w, top: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Container(
              height: 45.h,
              width: 45.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isComplete ? mainGradient2 : mainGradient4,
              ),
              child: SvgPicture.asset(
                'assets/icons/excercise.svg',
                height: 18.h,
                width: 18.w,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              height: 70.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model?.name ?? 'Bai tap',
                    style: defaultText16B,
                  ),
                  Text(
                    'Hạn nộp: ${DateFormat("dd-MM-yyyy").format(model?.timeDeadline ?? DateTime.now())}',
                    style: defaultText14Re,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget homeTab(
    {required String title,
    bool isSeprator = true,
    bool hasNumber = true,
    int number = 10,
    int count = 0}) {
  return Tab(
    child: Container(
      //width: 70.w,
      height: 50.h,
      decoration: isSeprator
          ? const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 3.w,
          ),
          SizedBox(
            width: 77.w,
            child: Center(
              child: Text(
                title,
              ),
            ),
          ),
          hasNumber
              ? Container(
                  decoration: BoxDecoration(
                    color: keyBlack,
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  ),
                  height: 20.h,
                  padding: EdgeInsets.symmetric(horizontal: 4.h),
                  child: Center(
                    child: Text(
                      number.toString(),
                      style: defaultText12B.copyWith(color: Colors.white),
                    ),
                  ),
                )
              : SizedBox(
                  width: 10.w,
                ),
        ],
      ),
    ),
  );
}

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
    required this.model,
  });
  final ChatModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ConverastionModel conversationModel =
            await ChatRepo().getConversationDetail(model.chatId);
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              model: conversationModel,
            ),
          ),
        );
      },
      child: Container(
        height: 73.h,
        width: 350.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 21.r,
              backgroundImage: NetworkImage(model.teacherAvatar),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              width: 220.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.teacherName,
                    style: defaultText14B,
                  ),
                  Text(
                    model.content,
                    style: defaultText12M,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget chartItem({
  required int width,
  required int percents,
  required String title,
}) {
  return Container(
    height: 34.h,
    width: width.w,
    margin: EdgeInsets.only(bottom: 10.h),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.r),
      color: state2,
    ),
    child: Stack(
      children: [
        Positioned(
            left: 0,
            child: Container(
              height: 34.h,
              width: width.w * percents / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                gradient: mainGradient,
              ),
            )),
        Positioned(
          left: 10.w,
          right: 10.w,
          child: SizedBox(
            height: 34.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: defaultText14B,
                ),
                Text(
                  '$percents%',
                  style: defaultText14B,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class InfoLichhen extends StatefulWidget {
  const InfoLichhen({super.key, required this.model});
  final LichHenModel model;

  @override
  State<InfoLichhen> createState() => _InfoLichhenState();
}

class _InfoLichhenState extends State<InfoLichhen> {
  late final LichHenModel _model;
  @override
  void initState() {
    super.initState();
    _model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            // boxShadow: const [
            //   BoxShadow(
            //     color: Colors.black,
            //     offset: Offset(6, 6),
            //     spreadRadius: 2,
            //     blurStyle: BlurStyle.solid,
            //   ),
            // ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff00AEEF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thông tin lịch hẹn',
                        style: defaultText16B.copyWith(color: Colors.white),
                      ),
                      const CloseButton(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              _InfoItem(title1: 'Cơ sở', title2: ': ${_model.cosoName}'),
              SizedBox(
                height: 8.h,
              ),
              _InfoItem(
                title1: 'Học viên',
                title2: ': ${_model.fullName}',
              ),
              SizedBox(
                height: 8.h,
              ),
              _InfoItem(
                title1: 'SĐT : ',
                title2: ': ${_model.phone}',
              ),
              SizedBox(
                height: 8.h,
              ),
              _InfoItem(
                title1: 'email : ',
                title2: ': ${_model.email}',
              ),
              SizedBox(
                height: 8.h,
              ),
              _InfoItem(
                title1: 'CM: ',
                title2: ': ${_model.teacherName}',
              ),
              SizedBox(
                height: 8.h,
              ),
              _InfoItem(
                title1: 'Thời gian: ',
                title2:
                    ': ${DateFormat('HH:mm dd-MM-yyyy').format(_model.appointmentDate)}',
              ),

              // Padding(
              //   padding: EdgeInsets.only(
              //     left: 12.w,
              //     top: 10.h,
              //     right: 12.w,
              //   ),
              //   child: Container(
              //       width: 310.w,
              //       height: 120.h,
              //       padding: EdgeInsets.only(
              //         left: 16.w,
              //         top: 10.h,
              //       ),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(12.r)),
              //         color: const Color(0xffF5F7FA),
              //       ), //
              //       child: Text(
              //         'Khách hẹn đến trung tâm',
              //         style: defaultText14M.copyWith(
              //           color: const Color(0xff09204E),
              //         ),
              //       )),
              // ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class DocumentItem extends StatelessWidget {
  const DocumentItem({super.key, required this.model});
  final DeValueModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!await launchUrl(Uri.parse(model.urlFile))) {
          throw Exception('Could not launch ');
        }
      },
      child: Container(
        height: 66.h,
        width: 350.w,
        margin: EdgeInsets.only(bottom: 10.h, right: 10.w, left: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Container(
              height: 45.h,
              width: 45.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: key1Color.withValues(alpha: 0.3),
              ),
              child: SvgPicture.asset(
                'assets/icons/excercise.svg',
                height: 18.h,
                width: 18.w,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            SizedBox(
              height: 70.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model.name,
                    style: defaultText16B,
                  ),
                  Text(
                    'Xem',
                    style: defaultText14Re,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.title1, required this.title2});
  final String title1;
  final String title2;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16.w,
        ),
        SizedBox(
          width: 90.w,
          child: Text(
            title1,
            style: defaultText16B.copyWith(
                color: const Color(0xff09204E).withValues(alpha: 0.48)),
          ),
        ),
        SizedBox(
          width: 180.w,
          child: Text(
            title2,
            style: defaultText16B.copyWith(color: const Color(0xff09204E)),
          ),
        ),
      ],
    );
  }
}
