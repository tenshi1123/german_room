import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/student_models/home_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class AcademicReportScreen extends StatelessWidget {
  const AcademicReportScreen({super.key, required this.model});
  final BaoCaoHocTapModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160.h,
            width: 390.w,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                    width: 390.w,
                    height: 140.h,
                    decoration: BoxDecoration(gradient: mainGradient),
                  ),
                ),
                Positioned(
                  bottom: 30.h,
                  left: 20.w,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.keyboard_arrow_left,
                          size: 30.h,
                          color: Colors.white,
                        ),
                        Text(
                          'Báo cáo học tập',
                          style: defaultText20B.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/bao_cao_diem.png',
                    width: 180.w,
                    height: 107.h,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tổng quan',
                  style: defaultText16B,
                ),
                Container(
                  width: 350.w,
                  height: 144.h,
                  margin: EdgeInsets.only(top: 10.h, bottom: 6.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 34.h,
                        width: 318.w,
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
                                  width: 318.w * model.chuyenCan / 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    gradient: mainGradient,
                                  ),
                                )),
                            Positioned(
                              left: 10.w,
                              child: SizedBox(
                                width: 298.w,
                                height: 34.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Chuyên cần',
                                      style: defaultText14B,
                                    ),
                                    Text(
                                      '${model.chuyenCan}%',
                                      style: defaultText14B,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 34.h,
                        width: 318.w,
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
                                  width: 318.w * model.baitap / 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    gradient: mainGradient,
                                  ),
                                )),
                            Positioned(
                              left: 10.w,
                              child: SizedBox(
                                width: 298.w,
                                height: 34.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Điểm bài tập',
                                      style: defaultText14B,
                                    ),
                                    Text(
                                      '${model.baitap}%',
                                      style: defaultText14B,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 34.h,
                        width: 318.w,
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
                                  width: 318.w * model.tichCuc / 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    gradient: mainGradient,
                                  ),
                                )),
                            Positioned(
                              left: 10.w,
                              child: SizedBox(
                                width: 298.w,
                                height: 34.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tích cực',
                                      style: defaultText14B,
                                    ),
                                    Text(
                                      '${model.tichCuc}%',
                                      style: defaultText14B,
                                    ),
                                  ],
                                ),
                              ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Báo cáo thi thử',
                      style: defaultText16B,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: sub2Color,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Center(
                        child: Text(
                          'Mục tiêu cá nhân: 650',
                          style: defaultText14B.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //còn cái biểu đồ nữa chưa tìm thấy thư viện phù hợp tạm thời đang tìm hiểu fl_chart
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 350.w,
                  margin: EdgeInsets.only(top: 10.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Chi tiết bài thi',
                        style: defaultText16B,
                      ),
                      Divider(
                        color: key1Color,
                        thickness: 1,
                        indent: 15.w,
                        endIndent: 15.w,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 56.h,
                            width: 56.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '680',
                                style: defaultText20B.copyWith(
                                  color: main2Color,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Thi thử tháng 12',
                                style: defaultText14B,
                              ),
                              Text(
                                '21/12/2024',
                                style: defaultText14Re,
                              ),
                              Text(
                                'Báo cáo kết quả',
                                style: defaultText12Re.copyWith(
                                  color: main1Color,
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
