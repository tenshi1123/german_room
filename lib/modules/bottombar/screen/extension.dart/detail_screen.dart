import 'dart:io';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:german_room/modules/course/point_excercise.dart';
import 'package:german_room/student_models/schedule_model.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.detailLesson,
  });
  final DetaiLessonModel detailLesson;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff296142),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Center(
          child: Text(
            'Chi tiết buổi học          ',
            style: defaultText18B.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.detailLesson.infoLesson.linkZoom == ''
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(Uri.parse(
                            widget.detailLesson.infoLesson.linkZoom ?? ''))) {
                          throw Exception('Could not launch ');
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 12.w,
                            ),
                            decoration: BoxDecoration(
                                color: const Color(0xff296142),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r))),
                            child: Text(
                              ('Vào Phòng học zoom'),
                              style: defaultText20B.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      ),
                    ),

              Text(
                widget.detailLesson.infoLesson.nameLesson,
                style: defaultText14B.copyWith(color: const Color(0xff296142)),
              ),
              SizedBox(height: 12.h),
              widget.detailLesson.infoLesson.topic == ''
                  ? const SizedBox()
                  : Text(
                      widget.detailLesson.infoLesson.topic,
                      style: defaultText16B.copyWith(
                          color: const Color(0xff296142)),
                    ),
              SizedBox(height: 12.h),
              Text(
                'Nội dung buổi học: ${widget.detailLesson.infoLesson.lessonContent}',
                style: defaultText14M.copyWith(color: const Color(0xff296142)),
              ),
              SizedBox(height: 12.h),
              // Expanded(
              //   child: NestedTabBar(
              //     detailLesson: widget.detailLesson,
              //   ),
              // )
              SizedBox(
                height: 600.h,
                width: 343.w,
                child: NestedTabBar(
                  detailLesson: widget.detailLesson,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NestedTabBar extends StatefulWidget {
  const NestedTabBar({super.key, required this.detailLesson});
  final DetaiLessonModel detailLesson;
  @override
  State<NestedTabBar> createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late DetaiLessonModel _detailLesson;
  int activeTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _detailLesson = widget.detailLesson;
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(() {
      setState(() {
        activeTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(
              8.r,
            ),
            //color: const Color(0xff296142),
          ),
          isScrollable: false,
          automaticIndicatorColorAdjustment: false,
          dividerColor: Colors.white,
          labelStyle: defaultText14M,
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xff296142),
          tabs: [
            Tab(
              child: Container(
                height: 34.h,
                width: 108.w,
                decoration: BoxDecoration(
                    color: activeTabIndex == 0
                        ? const Color(0xff296142)
                        : const Color(0xFFEFF1F7),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Bài tập"),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 34.h,
                width: 108.w,
                decoration: BoxDecoration(
                    color: activeTabIndex == 1
                        ? const Color(0xff296142)
                        : const Color(0xFFEFF1F7),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Tài liệu"),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 34.h,
                width: 108.w,
                decoration: BoxDecoration(
                    color: activeTabIndex == 2
                        ? const Color(0xff296142)
                        : const Color(0xFFEFF1F7),
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Đánh giá"),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: _detailLesson.listHomeWorks.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 234.h,
                    width: 343.w,
                    margin: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(50),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              //icon exercise
                              Icon(
                                Icons.assignment,
                                color: const Color(0xff296142),
                                size: 20.h,
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Text(
                                  _detailLesson.listHomeWorks[index].name,
                                  style: defaultText20B,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                            ],
                          ),
                          const Divider(thickness: 1),
                          Text(
                            'Giáo viên : ${_detailLesson.listHomeWorks[index].nameTeacher}',
                            style: defaultText16M,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          // GestureDetector(
                          //   onTap: () async {
                          //     if (!await launchUrl(
                          //       Uri.parse(
                          //         _detailLesson.listHomeWorks[index].image,
                          //       ),
                          //     )) {
                          //       throw Exception('Could not launch ');
                          //     }
                          //   },
                          //   child: Stack(
                          //     children: [
                          //       Container(
                          //         width: 120.w,
                          //         height: 80.h,
                          //         decoration: BoxDecoration(
                          //           color: Colors.blue.shade100,
                          //           gradient: LinearGradient(
                          //               begin: FractionalOffset.topCenter,
                          //               end: FractionalOffset.bottomCenter,
                          //               colors: [
                          //                 Colors.grey.withOpacity(0.0),
                          //                 Colors.black,
                          //               ],
                          //               stops: const [
                          //                 0.0,
                          //                 1.0,
                          //               ]),
                          //         ),
                          //         child: Image.network(
                          //             'https://t4.ftcdn.net/jpg/02/71/07/33/360_F_271073385_A6geLjwkrty3xkDPxaf7lcaEiNMtMwjN.jpg'),
                          //       ),
                          //       Container(
                          //         width: 120.w,
                          //         height: 80.h,
                          //         decoration: BoxDecoration(
                          //           gradient: LinearGradient(
                          //               begin: FractionalOffset.topCenter,
                          //               end: FractionalOffset.bottomCenter,
                          //               colors: [
                          //                 Colors.white,
                          //                 Colors.black.withAlpha(40),
                          //               ],
                          //               stops: const [
                          //                 0.0,
                          //                 1.0,
                          //               ]),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Text(
                            'Hạn nộp bài: ${_detailLesson.listHomeWorks[index].timeDeadline}',
                            style: defaultText14B,
                          ),
                          buildActionRow(
                            context: null,
                            label: 'Xem đề bài',
                            icon: Icons.description,
                            onTap: () {
                              if (_detailLesson
                                  .listHomeWorks[index].image.isNotEmpty) {
                                launchURL(
                                    _detailLesson.listHomeWorks[index].image);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Đề bài không có sẵn.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                          buildActionRow(
                            context: null,
                            label: 'Nộp bài',
                            icon: Icons.upload_file,
                            onTap: () {
                              pickImageFromGallery(
                                context,
                                _detailLesson.listHomeWorks[index].documentId,
                              );
                            },
                          ),
                          buildActionRow(
                            context: null,
                            label: 'Xem bài đã nộp',
                            icon: Icons.cloud_done,
                            onTap: () {
                              if (_detailLesson
                                      .listHomeWorks[index].baiTapDaNop !=
                                  null) {
                                launchURL(_detailLesson
                                        .listHomeWorks[index].baiTapDaNop ??
                                    '');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Không có sẵn.'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                          Text(
                            _detailLesson.listHomeWorks[index].note,
                            style: defaultText16M,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              //Tai lieu
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: _detailLesson.listDocument.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        if (!await launchUrl(
                          Uri.parse(
                            _detailLesson.listDocument[index].point,
                          ),
                        )) {
                          throw Exception('Could not launch ');
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        child: Row(
                          children: [
                            Image(
                              image: const AssetImage(
                                  'assets/images/ducoment.png'),
                              height: 48.h,
                              width: 48.w,
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                              child: Text(
                                _detailLesson.listDocument[index].name,
                                style: defaultText16B,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

              Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  HtmlWidget(
                    normalizeFeedback(_detailLesson.feedback),
                    textStyle: defaultText14B,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String normalizeFeedback(String html) {
  if (html.trim().isEmpty) return 'Chưa có đánh giá nào';
  final cleaned = html.replaceAll(RegExp(r'<[^>]+>'), '').trim();
  if (cleaned.isEmpty ||
      cleaned.contains(RegExp(r'\d{2}:\d{2}\s\d{2}-\d{2}-\d{4}'))) {
    return 'Chưa có đánh giá nào';
  }

  return html;
}

Future pickImageFromGallery(
  BuildContext context,
  final String classLessonDocumentId,
) async {
  final returnedImage = await ImagePicker().pickMultiImage();

  if (returnedImage.isNotEmpty) {
    List<File> photos = List<File>.from(returnedImage.map((e) => File(e.path)));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified_user_outlined,
                              color: Colors.blue),
                          const SizedBox(width: 8),
                          Text('Xem trước', style: defaultText14M),
                          const Spacer(),
                          const CloseButton(
                            color: Colors.black,
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ),
                      ...photos.asMap().entries.map(
                        (entry) {
                          int index = entry.key;
                          File photo = entry.value;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    photo,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setStateDialog(() {
                                        photos.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // OutlinedButton.icon(
                      //   onPressed: () async {
                      //     final moreImages =
                      //         await ImagePicker().pickMultiImage();
                      //     setStateDialog(() {
                      //       photos.addAll(moreImages.map((e) => File(e.path)));
                      //     });
                      //   },
                      //   icon: const Icon(Icons.add),
                      //   label: const Text('Tải thêm ảnh lên'),
                      //   style: OutlinedButton.styleFrom(
                      //     side: const BorderSide(color: Colors.blue),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () async {
                          //gọi api
                          bool success = await MycourseRepo().uploadHomework(
                            classLessonDocumentId: classLessonDocumentId,
                            photos: photos,
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Thông báo',
                                  style: defaultText16B,
                                ),
                                content: Text(
                                  success
                                      ? 'Yêu cầu nộp bài đã được gửi thành công!'
                                      : 'Không thể nộp bài.',
                                  style: defaultText14M,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 16.w, bottom: 26.h, top: 16.h, right: 16.w),
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: 16.w,
                            vertical: 12.w,
                          ),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF25AAE1),
                                Color(0xFF004071),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 1.0],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                              child: Text(
                            'Nộp bài',
                            style: defaultText14B.copyWith(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
