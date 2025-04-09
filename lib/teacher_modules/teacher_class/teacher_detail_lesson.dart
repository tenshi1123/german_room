import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/teacher/teacher_model/teacher_class_model.dart';
import 'package:german_room/teacher/teacher_repo/teacher_class_repo.dart';

import '../../utils/constants/styles.dart';
import 'student_list.dart';

class LessonDetail extends StatefulWidget {
  const LessonDetail(
      {super.key,
      required this.listDiemDanh,
      required this.title,
      required this.listBaiTap,
      required this.listDeThi});
  final List<DiemDanhHSModel> listDiemDanh;
  final List<ExamModel> listBaiTap;
  final List<ExamModel> listDeThi;
  final String title;
  @override
  State<LessonDetail> createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {
  final ValueNotifier<int> _pickValue = ValueNotifier<int>(0);

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
          '    Chi tiết buổi học',
          style: defaultText18B.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: ValueListenableBuilder<int>(
        builder: (BuildContext context, int value, Widget? child) {
          return Column(
            children: [
              //title
              Container(
                width: 390.w,
                height: 60.h,
                decoration: const BoxDecoration(
                  color: Color(0xff00AEEF),
                ),
                padding: EdgeInsets.only(left: 16.w, top: 20.h),
                child: Text(
                  widget.title,
                  style: defaultText18B.copyWith(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 50.h,
                color: const Color(0xff00AEEF),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickValue.value = 0;
                      },
                      child: Container(
                        width: 127.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                          color: value == 0
                              ? Colors.white
                              : const Color(0xffF4F6FA),
                        ),
                        child: Center(
                          child: Text(
                            'Điểm danh',
                            style: defaultText16B.copyWith(
                              color: value == 0
                                  ? const Color(0xff09204E)
                                  : const Color(0xff09204E)
                                      .withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickValue.value = 1;
                      },
                      child: Container(
                        width: 127.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                          color: value == 1
                              ? Colors.white
                              : const Color(0xffF4F6FA),
                        ),
                        child: Center(
                          child: Text(
                            'Bài tập',
                            style: defaultText16B.copyWith(
                              color: value == 1
                                  ? const Color(0xff09204E)
                                  : const Color(0xff09204E)
                                      .withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickValue.value = 2;
                      },
                      child: Container(
                        width: 127.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            topRight: Radius.circular(20.r),
                          ),
                          color: value == 2
                              ? Colors.white
                              : const Color(0xffF4F6FA),
                        ),
                        child: Center(
                          child: Text(
                            'Đề thi',
                            style: defaultText16B.copyWith(
                              color: value == 2
                                  ? const Color(0xff09204E)
                                  : const Color(0xff09204E)
                                      .withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              value == 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: widget.listDiemDanh.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _RollCallItem(
                          model: widget.listDiemDanh[index],
                        );
                      })
                  : value == 1
                      ? _ListExam(
                          listExam: widget.listBaiTap,
                        )
                      : _ListExam(
                          listExam: widget.listDeThi,
                        ),
            ],
          );
        },
        valueListenable: _pickValue,
      ),
    );
  }
}

class _RollCallItem extends StatelessWidget {
  const _RollCallItem({required this.model});

  final DiemDanhHSModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
          color: const Color(0xffF5F7FA)),
      child: Row(
        children: [
          Image.asset(
            'assets/images/little_avatar.png',
            width: 28.w,
            height: 28.h,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            model.name,
            style: defaultText16M,
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
              color: model.status == '0'
                  ? const Color(0xffFF6B6B)
                  : model.status == '1'
                      ? const Color(0xffFFA94D)
                      : model.status == '2'
                          ? const Color(0xffF9D30A)
                          : const Color(0xff51CF66),
            ),
            child: Text(
              model.status == '0'
                  ? 'Vắng mặt'
                  : model.status == '1'
                      ? 'Xin nghỉ'
                      : model.status == '2'
                          ? 'Đi muộn'
                          : 'Đúng giờ',
              style: defaultText12M.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ListExam extends StatelessWidget {
  const _ListExam({required this.listExam});
  final List<ExamModel> listExam;
  @override
  Widget build(BuildContext context) {
    return listExam.isEmpty
        ? Center(
            child: Image.asset(
              'assets/images/empty2.png',
              scale: 2,
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: listExam.length,
            itemBuilder: (BuildContext context, int index) {
              return _ExcerciseItem(listExam[index]);
            });
  }
}

class _ExcerciseItem extends StatelessWidget {
  const _ExcerciseItem(this.model);
  final ExamModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DetailedExamModel detailedExamModel =
            await TeacherClassRepo().getDetailedExam(id: model.id);
        if (!context.mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StudentList(
              model: detailedExamModel,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
            border: Border.all(color: const Color(0xff00AEEF)),
            color: const Color(0xffF5F7FA)),
        child: Row(
          children: [
            Image.asset(
              'assets/images/exercise.png',
              width: 40.w,
              height: 40.h,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              model.name,
              style: defaultText16M.copyWith(color: Colors.black),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
