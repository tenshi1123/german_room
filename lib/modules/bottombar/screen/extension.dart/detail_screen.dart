import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
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
              Text(
                widget.detailLesson.infoLesson.topic,
                style: defaultText16B.copyWith(color: const Color(0xff296142)),
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
        // TabBar.secondary(
        //   tabAlignment: TabAlignment.start,
        //   padding: EdgeInsets.zero,
        //   indicatorPadding: EdgeInsets.zero,
        //   labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
        //   isScrollable: true,
        //   indicatorColor: keyBlack,
        //   indicatorSize: TabBarIndicatorSize.label,
        //   indicator: UnderlineTabIndicator(
        //     borderSide: BorderSide(width: 2.w), //hight of indicator
        //     insets: EdgeInsets.symmetric(
        //         horizontal:
        //             20.w), //give some padding to reduce the size of indicator
        //   ),
        //   unselectedLabelColor: keyBlack.withOpacity(0.3),
        //   labelStyle: defaultText14M,
        //   labelColor: keyBlack,
        //   controller: _tabController,
        //   tabs: <Widget>[
        //     homeTab(title: 'Toàn bộ', isSeprator: false),
        //     homeTab(title: 'Chưa làm'),
        //     homeTab(title: 'Hoàn thành'),
        //   ],
        // ),
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
                    height: 367.h,
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
                            // Text(
                            //   'chọn bài tập bạn muốn xem',
                            //   style: defaultText14Re.copyWith(
                            //     color: Colors.black.withAlpha(60),
                            //   ),
                            // ),
                          ],
                        ),
                        const Divider(thickness: 1),
                        Text(
                          'Hạn nộp bài: ${_detailLesson.listHomeWorks[index].timeDeadline}',
                          style: defaultText14B,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (!await launchUrl(
                              Uri.parse(
                                _detailLesson.listHomeWorks[index].image,
                              ),
                            )) {
                              throw Exception('Could not launch ');
                            }
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 120.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.grey.withOpacity(0.0),
                                        Colors.black,
                                      ],
                                      stops: const [
                                        0.0,
                                        1.0,
                                      ]),
                                ),
                                child: Image.network(
                                    _detailLesson.listHomeWorks[index].image),
                              ),
                              Container(
                                width: 120.w,
                                height: 80.h,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      colors: [
                                        Colors.white,
                                        Colors.black.withAlpha(40),
                                      ],
                                      stops: const [
                                        0.0,
                                        1.0,
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: Text(
                            _detailLesson.listHomeWorks[index].note,
                            style: defaultText16M,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Giáo viên : ${_detailLesson.listHomeWorks[index].nameTeacher}',
                            style: defaultText16M,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
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
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   PageRouteBuilder(
                        //     opaque: false,
                        //     barrierColor: Colors.black,
                        //     pageBuilder: (BuildContext context, _, __) {
                        //       return FullScreenPage(
                        //         dark: true,
                        //         child: Image.network(
                        //           _detailLesson.listDocument[index].point,
                        //           width: 100.w,
                        //           height: 90.h,
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        child: Row(
                          children: [
                            Image(
                              image: const AssetImage(
                                  'assets/images/icon_file.png'),
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
                            // Text(
                            //   'chọn bài tập bạn muốn xem',
                            //   style: defaultText14Re.copyWith(
                            //     color: Colors.black.withAlpha(60),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  }),
              // Column(
              //   children: [
              //     SizedBox(
              //       width: 343.w,
              //       height: 80.h,
              //       child: Row(
              //         children: [
              //           Text('Không có tài liệu', style: defaultText16M)
              //         ],
              //       ),
              //     )
              //   ],
              // ),
              Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  HtmlWidget(
                    _detailLesson.feedback,
                    textStyle: defaultText14B,
                  ),
                ],
              ),
              // Column(
              //   children: [
              //     SizedBox(
              //       width: 343.w,
              //       height: 80.h,
              //       child: Row(
              //         children: [
              //           Text('Không có đánh giá', style: defaultText16M)
              //         ],
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
