import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:german_room/student_models/home_model.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:german_room/utils/widget/custom_widget.dart';

class DetailLessonScreen extends StatelessWidget {
  const DetailLessonScreen({super.key, required this.videoLessonModel});
  final VideoLessonModel videoLessonModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 6.w,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '  Chi tiết buổi học ',
                      style: defaultText16M,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(
                    width: 200.w,
                  ),
                  //SvgPicture.asset('assets/icons/three_dots_icon.svg'),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 300.h,
                width: 350.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "${videoLessonModel.name} ${videoLessonModel.teachingContent}",
                      style: defaultText18B,
                    ),
                    Divider(
                      color: Colors.black,
                      endIndent: 200.w,
                      height: 20,
                      thickness: 2,
                    ),
                    Text(
                      'Nội dung',
                      style: defaultText14B,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      //height: 120.h,
                      width: 326.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.r),
                          ),
                          color: baseColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 120.w,
                                child: Text(
                                  'Phòng học',
                                  style: defaultText14Re,
                                ),
                              ),
                              SizedBox(
                                width: 180.w,
                                child: Text(
                                  videoLessonModel.phongHoc,
                                  style: defaultText14B,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 120.w,
                                child: Text(
                                  'Giảng viên',
                                  style: defaultText14Re,
                                ),
                              ),
                              Text(
                                videoLessonModel.teacherFullName,
                                style: defaultText14B,
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 120.w,
                                child: Text(
                                  'Ca học',
                                  style: defaultText14Re,
                                ),
                              ),
                              Text(
                                '${DateFormat("hh:mm a").format(videoLessonModel.timeStart)} - ${DateFormat("hh:mm a").format(videoLessonModel.timeEnd)}',
                                style: defaultText14B,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 500.h,
                width: 390.w,
                child: DetailLessonTabbar(
                  videoLessonModel: videoLessonModel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailLessonTabbar extends StatefulWidget {
  const DetailLessonTabbar({super.key, required this.videoLessonModel});
  final VideoLessonModel videoLessonModel;

  @override
  State<DetailLessonTabbar> createState() => _DetailLessonTabbarState();
}

class _DetailLessonTabbarState extends State<DetailLessonTabbar>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late List<DeValueModel> listdoc = [];
  EvaluationModel? evaModel;
  @override
  void initState() {
    super.initState();
    _fetchData();
    // Khởi tạo TabController với số lượng tab
    // và vsync là this (đối tượng hiện tại của State)
    _tabController = TabController(length: 4, vsync: this);
  }

  Future<void> _fetchData() async {
    listdoc = await MycourseRepo().getDocument(id: widget.videoLessonModel.id);
    evaModel =
        await MycourseRepo().getEvaluation(id: widget.videoLessonModel.id);
    setState(() {
      // Cập nhật trạng thái để hiển thị dữ liệu mới
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TabBar.secondary(
          tabAlignment: TabAlignment.start,
          padding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          labelPadding: const EdgeInsets.symmetric(horizontal: 0),
          isScrollable: true,
          indicatorColor: keyBlack,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.w), //hight of indicator
            insets: EdgeInsets.symmetric(
              horizontal: 6.w,
            ), //give some padding to reduce the size of indicator
          ),
          unselectedLabelColor: keyBlack.withValues(alpha: 0.3),
          labelColor: keyBlack,
          labelStyle: defaultText12M,
          controller: _tabController,
          tabs: <Widget>[
            homeTab(
              title: 'Video',
              isSeprator: false,
              hasNumber: false,
            ),
            homeTab(
              title: 'Bài tập',
              hasNumber: false,
            ),
            homeTab(
              title: 'Tài liệu',
              hasNumber: false,
            ),
            homeTab(
              title: 'Đánh giá',
              hasNumber: false,
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _VideoWidget(
                videoLessonModel: widget.videoLessonModel,
              ),
              ExerciseItem(
                id: widget.videoLessonModel.id,
                courseID: widget.videoLessonModel.customerCourseScheduleId,
              ),
              _DocumentItem(
                listdoc: listdoc,
              ),
              Column(children: [
                SizedBox(
                  height: 10.h,
                ),
                _FeedbackItem(evaModel),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

//hai người đàn bà và một con vịt thành cái chợ
class _VideoWidget extends StatelessWidget {
  const _VideoWidget({required this.videoLessonModel});
  final VideoLessonModel videoLessonModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Image.asset('assets/images/demoVideo.png'),
        Row(
          children: [
            const Icon(
              Icons.hourglass_top,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            Text(
              videoLessonModel.noteVideo,
              style: defaultText14M.copyWith(
                color: main1Color,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class _FeedbackItem extends StatelessWidget {
  const _FeedbackItem(this.evaModel);
  final EvaluationModel? evaModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      //height: 166.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: evaModel != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                  width: 310.w,
                  child: Row(
                    children: [
                      Image.network(
                        evaModel?.avatar ?? '',
                        width: 40.w,
                        height: 40.h,
                        fit: BoxFit.fill,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Text('N/A');
                        },
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            evaModel?.fullName ?? 'Nguyễn Văn A',
                            style: defaultText14B,
                          ),
                          Text(
                            'Giảng viên',
                            style: defaultText12Re,
                          )
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.star,
                        color: const Color(0xffFFCF68),
                        size: 24.dg,
                      ),
                      Icon(
                        Icons.star,
                        color: const Color(0xffFFCF68),
                        size: 24.dg,
                      ),
                      Icon(
                        Icons.star_border_outlined,
                        color: const Color(0xffFFCF68),
                        size: 24.dg,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                Text(
                  'Nhận xét:',
                  style: defaultText12B,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: evaModel!.value
                      .map(
                        (e) => Text(
                          '- $e\n',
                          style: defaultText12B,
                        ),
                      )
                      .toList(),
                ),
              ],
            )
          : Center(
              child: Image.asset(
                'assets/images/empty2.png',
                scale: 2,
              ),
            ),
    );
  }
}

class ExerciseItem extends StatefulWidget {
  const ExerciseItem({
    super.key,
    required this.id,
    required this.courseID,
  });
  final String id;
  final String courseID;
  @override
  State<ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  late List<BaiTapValueModel> baiTapValueModel = [];

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  Future<void> _fetchData() async {
    baiTapValueModel = await MycourseRepo().getExerciseLesson(id: widget.id);
    setState(() {
      // Cập nhật trạng thái để hiển thị dữ liệu mới
    });
  }

  @override
  Widget build(BuildContext context) {
    return baiTapValueModel.isEmpty
        ? Center(
            child: Image.asset(
              'assets/images/empty2.png',
              scale: 2,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: baiTapValueModel.length,
            itemBuilder: (BuildContext context, int index) {
              return ExcerciseItem(
                isComplete: true,
                model: baiTapValueModel[index],
                courseID: widget.courseID,
              );
            });
  }
}

class _DocumentItem extends StatelessWidget {
  const _DocumentItem({required this.listdoc});
  final List<DeValueModel> listdoc;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: listdoc.length,
        itemBuilder: (BuildContext context, int index) {
          return DocumentItem(
            model: listdoc[index],
          );
        });
  }
}
