import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/diemdanh/diem_danh_screen.dart';
import 'package:german_room/student_models/diem_danh_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:german_room/utils/widget/custom_widget.dart';

class AttendanceDetails extends StatelessWidget {
  const AttendanceDetails({super.key, required this.infoModel});
  final InfoDiemDanh infoModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   title: Text('Chi tiết điểm danh',
      //       textAlign: TextAlign.right,
      //       style: defaultText20B.copyWith(color: Colors.white)),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.h,
                width: 390.w,
                decoration: BoxDecoration(gradient: mainGradient),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text('Chi tiết điểm danh',
                        textAlign: TextAlign.right,
                        style: defaultText20B.copyWith(color: Colors.white)),

                    //SvgPicture.asset('assets/icons/three_dots_icon.svg'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 20.h),
                child: Text(
                  infoModel.courseName,
                  style: defaultText16B,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 120.h,
                    width: 120.h,
                    child: PieChart(
                      percent: 100 -
                          (infoModel.totalChuahoc *
                              100 ~/
                              int.parse(infoModel.total)),
                      attended: infoModel.totalAttended,
                      abstract: infoModel.totalAbsent,
                      total: infoModel.totalChuahoc.toString(),
                    ),
                  ),
                  SizedBox(
                    height: 90.h,
                    width: 130.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lớp',
                              style: defaultText12Re,
                            ),
                            Text(
                              infoModel.alias,
                              style: defaultText12B,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bắt đầu',
                              style: defaultText12Re,
                            ),
                            Text(
                              infoModel.startDate,
                              style: defaultText12B,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kết thúc',
                              style: defaultText12Re,
                            ),
                            Text(
                              infoModel.expiryDate,
                              style: defaultText12B,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  SizedBox(
                    height: 90.h,
                    width: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tham gia',
                              style: defaultText14Re,
                            ),
                            Container(
                              //height: 17.h,
                              width: 24.w,
                              decoration: BoxDecoration(
                                gradient: mainGradient,
                              ),
                              child: Center(
                                child: Text(
                                  infoModel.totalAttended,
                                  style: defaultText14B.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vắng',
                              style: defaultText14Re,
                            ),
                            Container(
                              //height: 17.h,
                              //width: 24.w,
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: sub2Color,
                              ),
                              child: Center(
                                child: Text(
                                  infoModel.totalAbsent,
                                  style: defaultText14B.copyWith(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chưa học',
                              style: defaultText14Re,
                            ),
                            Container(
                              //height: 17.h,
                              width: 24.w,
                              decoration: BoxDecoration(
                                color: key1Color.withValues(alpha: 0.3),
                              ),
                              child: Center(
                                child: Text(
                                  infoModel.totalChuahoc.toString(),
                                  style: defaultText14B.copyWith(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _TabSection(infoModel),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabSection extends StatelessWidget {
  const _TabSection(this.infoModel);
  final InfoDiemDanh infoModel;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
              unselectedLabelColor: keyBlack.withValues(alpha: 0.3),
              labelColor: main1Color,
              labelStyle: defaultText14B,
              indicatorColor: main1Color,
              //indicatorSize: TabBarIndicatorSize(),
              tabs: [
                homeTab(
                  title: "Đã qua",
                  isSeprator: false,
                  number: infoModel.daqua.length,
                ),
                homeTab(
                  title: "Sắp tới",
                  number: infoModel.saptoi.length,
                ),
              ]),
          SizedBox(
            //Add this to give height
            height: MediaQuery.of(context).size.height * 0.8,
            child: TabBarView(children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: infoModel.daqua.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CaseStudy(
                      index: index,
                      isCompleted: true,
                      detailModel: infoModel.daqua[index],
                    );
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: infoModel.saptoi.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CaseStudy(
                      index: index,
                      isCompleted: false,
                      detailModel: infoModel.saptoi[index],
                    );
                  }),
            ]),
          ),
        ],
      ),
    );
  }
}

class CaseStudy extends StatelessWidget {
  const CaseStudy({
    super.key,
    required this.index,
    required this.isCompleted,
    required this.detailModel,
  });
  final int index;
  final bool isCompleted;
  final DetailDiemDanh detailModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      width: 390.w,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SizedBox(width: 20.w),
              SizedBox(
                height: 60.h,
                width: 90.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detailModel.day,
                      style: defaultText14B,
                    ),
                    const Spacer(),
                    Text(
                      'Ca học',
                      style: defaultText14Re,
                    ),
                    Text(
                      'Giảng viên',
                      style: defaultText14Re,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              SizedBox(
                height: 60.h,
                width: 200.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      detailModel.time,
                      style: defaultText14B,
                    ),
                    Text(
                      detailModel.teacherName,
                      style: defaultText14B,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Image.asset(
                (detailModel.gvStatus == '3')
                    ? 'assets/images/complete.png'
                    : (detailModel.gvStatus == '0')
                        ? 'assets/images/miss.png'
                        : 'assets/images/iscomming.png',
                width: 36.w,
                height: 36.h,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 20.w,
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            thickness: 1,
            indent: 15.w,
            endIndent: 15.w,
            height: 1,
            color: Colors.black.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}
