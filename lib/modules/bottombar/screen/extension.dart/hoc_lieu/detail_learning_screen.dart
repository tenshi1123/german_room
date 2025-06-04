import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/hoc_lieu/list_hoc_lieu_screen.dart';
import 'package:german_room/student_models/hoclieu_model.dart';
import 'package:german_room/student_repo/hoc_lieu_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailLearingScreen extends StatefulWidget {
  const DetailLearingScreen({
    super.key,
    required this.detailearningModel,
  });
  final DetailLearingModel detailearningModel;

  @override
  State<DetailLearingScreen> createState() => _DetailLearingScreenState();
}

class _DetailLearingScreenState extends State<DetailLearingScreen> {
  late DetailLearingModel detailLearingModel;
  @override
  void initState() {
    super.initState();
    detailLearingModel = widget.detailearningModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                          'Chi tiết Bài học',
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
            Text(
              detailLearingModel.detailModel.name,
              style: defaultText20B.copyWith(
                color: key1Color,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Html(
                data: detailLearingModel.detailModel.detail,
                style: {
                  "body": Style(
                    fontSize: FontSize(16.sp),
                    color: key1Color,
                    textAlign: TextAlign.justify,
                  ),
                },
              ),
            ),
            // List of videos
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Danh sách Video',
              style: defaultText20B.copyWith(
                color: key1Color,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            detailLearingModel.listVideo.isEmpty
                ? Text(
                    'Không có video nào',
                    style: defaultText16B.copyWith(color: key2Color),
                  )
                : ListView.builder(
                    shrinkWrap: true, // ✅ cần thiết khi đặt trong scroll view
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: detailLearingModel.listVideo.length,
                    itemBuilder: (context, index) {
                      final video = detailLearingModel.listVideo[index];
                      return ListTile(
                        title: Text(video.name, style: defaultText16B),
                        onTap: () async {
                          //open web brower
                          // You can use a package like url_launcher to open the video link
                          // For example:
                          if (!await launchUrl(Uri.parse(video.link))) {
                            // If the URL cannot be launched, show an error message
                            throw Exception('Could not launch ');
                          }
                        },
                      );
                    },
                  ),
            // List of questions
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Danh sách câu hỏi',
              style: defaultText20B.copyWith(
                color: key1Color,
              ),
            ),

            ListView.builder(
              shrinkWrap: true, // ✅ cần thiết khi đặt trong scroll view
              physics: const NeverScrollableScrollPhysics(),
              itemCount: detailLearingModel.listQuestion.length,
              itemBuilder: (context, index) {
                final question = detailLearingModel.listQuestion[index];
                return ListTile(
                  title: Text(question.title, style: defaultText16B),
                  onTap: () async {
                    String url = await HocLieuRepo().getLinkQuestion(
                        partId: question.partLearningMaterialsId,
                        questionId: question.questionsPartLearningMaterialId);
                    //open web brower
                    if (!await launchUrl(Uri.parse(url))) {
                      // If the URL cannot be launched, show an error message
                      throw Exception('Could not launch $url');
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CourseItem extends StatelessWidget {
  const _CourseItem({required this.index, required this.model});
  final int index;
  final KhoaHocModel model;
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
                  ' Khóa học : ${model.name}',
                  style: TextStyle(
                    color: key1Color,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () async {
              List<HocLieuModel> listHoclieuModel =
                  await HocLieuRepo().getDsCap3(courseId: model.courseId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopicListScreen(
                    topics: listHoclieuModel,
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
          Divider(
            color: key2Color,
            thickness: 1.h,
          )
        ],
      ),
    );
  }
}
