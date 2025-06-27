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
  int? expandedIndex;
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
              height: detailLearingModel.listVideo.isEmpty ? 10.h : 0,
            ),
            detailLearingModel.listVideo.isEmpty
                ? Text(
                    'Không có video nào',
                    style: defaultText16B.copyWith(color: key2Color),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true, // ✅ cần thiết khi đặt trong scroll view
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: detailLearingModel.listVideo.length,
                    itemBuilder: (context, index) {
                      final video = detailLearingModel.listVideo[index];
                      return ListTile(
                        title: Text(video.name, style: defaultText16B),
                        leading: Icon(Icons.play_circle,
                            size: 40.sp, color: Colors.grey),
                        onTap: () async {
                          if (!await launchUrl(Uri.parse(video.link))) {
                            throw Exception('Could not launch ');
                          }
                        },
                      );
                    },
                  ),
            // List of questions
            SizedBox(
              height: 16.h,
            ),
            Text(
              'Danh sách câu hỏi',
              style: defaultText20B.copyWith(
                color: key1Color,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: detailLearingModel.listQuestion.length,
              itemBuilder: (context, index) {
                final question = detailLearingModel.listQuestion[index];
                final isExpanded = expandedIndex == index;

                return Container(
                  margin:
                      EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                  decoration: BoxDecoration(
                    color: isExpanded ? const Color(0xfff3faff) : Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      key: Key(index.toString()), // để giữ trạng thái mở
                      tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          expandedIndex = expanded ? index : null;
                        });
                      },
                      title:
                          Text('Übungen ${index + 1}', style: defaultText16B),
                      trailing: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 20.sp,
                        color: Colors.black,
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question.title,
                                style: defaultText14M.copyWith(
                                    color: Colors.grey[800]),
                              ),
                              SizedBox(height: 12.h),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    String url =
                                        await HocLieuRepo().getLinkQuestion(
                                      partId: question.partLearningMaterialsId,
                                      questionId: question
                                          .questionsPartLearningMaterialId,
                                    );
                                    if (!await launchUrl(Uri.parse(url))) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF00BFA6),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 10.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  child: Text('Làm bài',
                                      style: defaultText14B.copyWith(
                                          color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
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
