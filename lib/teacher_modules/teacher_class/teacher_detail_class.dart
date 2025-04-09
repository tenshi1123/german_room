import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:german_room/teacher/teacher_model/teacher_class_model.dart';
import 'package:german_room/teacher/teacher_repo/teacher_class_repo.dart';
import 'package:german_room/utils/constants/styles.dart';

import 'teacher_detail_lesson.dart';

class TeacherDetail extends StatefulWidget {
  const TeacherDetail({super.key, required this.detailClass});
  final DetailClass detailClass;
  @override
  State<TeacherDetail> createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int activeTabIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff00AEEF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        title: Text(
          '    Chi tiết lớp học',
          style: defaultText18B.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(0xff00AEEF),
            child: Container(
              width: 390.w,
              height: 128.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _detailItem(
                      title1: 'Tên lớp:', title2: widget.detailClass.name),
                  _detailItem(
                      title1: 'Hình thức:',
                      title2: widget.detailClass.hinhThucHoc),
                  _detailItem(
                      title1: 'Khóa học:', title2: widget.detailClass.alias),
                ],
              ),
            ),
          ),
          Container(
            width: 390.w,
            height: 6.h,
            color: const Color(0xfff6f6f6),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              top: 16.h,
              bottom: 16.h,
            ),
            child: Text(
              'Danh sách buổi học',
              style: defaultText16B,
            ),
          ),
          Container(
            width: 390.w,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: kToolbarHeight,
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xffEFEFEF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: TabBar.secondary(
                    padding: EdgeInsets.zero,
                    controller: _tabController,
                    indicator: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(50),
                            blurRadius: 4,
                            offset: const Offset(0, 4), // Shadow position
                          ),
                        ],
                        color: Colors.white),
                    labelColor: Colors.black,
                    unselectedLabelColor: const Color(0xff292929).withAlpha(84),
                    tabs: const [
                      Tab(
                        text: "Chưa học",
                      ),
                      Tab(
                        text: "Đã học",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  width: 375.w,
                  margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 6.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: widget.detailClass.dsBuoiHoc
                          .where((e) => e.day.isAfter(DateTime.now()))
                          .toList()
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListFbDaily(
                          model: widget.detailClass.dsBuoiHoc
                              .where((e) => e.day.isAfter(DateTime.now()))
                              .toList()[index],
                          courseScheduleId: widget.detailClass.id,
                        );
                      }),
                ),
                Container(
                  width: 343.w,
                  margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 6.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: widget.detailClass.dsBuoiHoc
                          .where((e) => e.day.isBefore(DateTime.now()))
                          .toList()
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListFbDaily(
                          model: widget.detailClass.dsBuoiHoc
                              .where((e) => e.day.isBefore(DateTime.now()))
                              .toList()[index],
                          courseScheduleId: widget.detailClass.id,
                        );
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}

class ListFbDaily extends StatelessWidget {
  const ListFbDaily({
    super.key,
    required this.model,
    required this.courseScheduleId,
  });

  final DetailBuoiHoc model;
  final String courseScheduleId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<DiemDanhHSModel> listDiemDanh = await TeacherClassRepo()
            .getListDiemDanh(courseScheduleId: courseScheduleId, id: model.id);
        List<ExamModel> listBaiTap = await TeacherClassRepo().getlistExam(
            courseScheduleId: courseScheduleId, id: model.id, type: 1);
        List<ExamModel> listDeThi = await TeacherClassRepo().getlistExam(
            courseScheduleId: courseScheduleId, id: model.id, type: 2);
        if (!context.mounted) return;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LessonDetail(
                  listDiemDanh: listDiemDanh,
                  title:
                      "${model.name} ${DateFormat('dd/MM/yyyy').format(model.day)}",
                  listBaiTap: listBaiTap,
                  listDeThi: listDeThi,
                )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8.h,
          ),
          // print day (datetime to string)
          Text(
            DateFormat('dd/MM/yyyy').format(model.day),
            style: defaultText14M.copyWith(
                color: const Color(0xff09204E).withValues(
              alpha: 0.48,
            )),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 263.w,
                child: Text(
                  model.name,
                  style:
                      defaultText16B.copyWith(color: const Color(0xff09204E)),
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/next.png',
                height: 20.h,
                width: 20.w,
              )
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class ListFbDinhKy extends StatelessWidget {
  const ListFbDinhKy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 16.h,
            bottom: 12.h,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Lớp',
              style: defaultText20B.copyWith(
                color: const Color(0xff273D8C),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _detailItem({required String title1, required String title2}) {
  return Row(
    children: [
      SizedBox(
        width: 18.w,
      ),
      SizedBox(
        width: 120.w,
        child: Text(
          title1,
          style: defaultText16M,
        ),
      ),
      SizedBox(
        width: 240.w,
        child: Text(
          title2,
          style: defaultText16B,
        ),
      )
    ],
  );
}
