import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class RecommentCourse extends StatefulWidget {
  const RecommentCourse({super.key});

  @override
  State<RecommentCourse> createState() => _RecommentCourseState();
}

class _RecommentCourseState extends State<RecommentCourse>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 259.h,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: Container(
                            width: 390.w,
                            height: 259.h,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/course_image.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 52.h,
                          left: 20.w,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 43.h,
                              width: 43.w,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(
                                Icons.arrow_back,
                                color: key1Color,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 350.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'TOEIC 4 kỹ năng',
                          style: defaultText20B,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Đầu ra: TOEIC Nghe Đọc 650+',
                          style: defaultText14M,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 166.w,
                              height: 86.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ]),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SvgPicture.asset(
                                      'assets/icons/learning_path.svg'),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Lộ trình học',
                                        style: defaultText14B,
                                      ),
                                      Text(
                                        '60 buổi',
                                        style: defaultText14Re.copyWith(
                                          color:
                                              key1Color.withValues(alpha: 0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 166.w,
                              height: 86.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ]),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SvgPicture.asset(
                                      'assets/icons/subcriber.svg'),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Đã đăng ký',
                                        style: defaultText14B,
                                      ),
                                      Text(
                                        '312 người',
                                        style: defaultText14Re.copyWith(
                                          color:
                                              key1Color.withValues(alpha: 0.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),

                        Text(
                          'Mô tả',
                          style: defaultText18B,
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Một người như thế đấy yêu là yêu đến hết đời này, em không là thế giới ấy em thật là nhỏ bé thôi tại sao em mãi cứ ôm mãi không bao giờ nói ra có lẽ em yêu anh nhiều quá nên là em chẳng dám buông ra có lẽ anh thấy em mạnh mẽ nên là anh chẳng muốn vỗ về',
                                style: defaultText14Re,
                                maxLines: isExpanded ? 11 : 4,
                                softWrap: true,
                                // overflow: TextOverflow.fade,
                              ),
                            ),
                            'Một người như thế đấy yêu là yêu đến hết đời này, em không là thế giới ấy em thật là nhỏ bé thôi tại sao em mãi cứ ôm mãi không bao giờ nói ra có lẽ em yêu anh nhiều quá nên là em chẳng dám buông ra có lẽ anh thấy em mạnh mẽ nên là anh chẳng muốn vỗ về'
                                        .length <
                                    197
                                ? const SizedBox()
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        isExpanded == false
                                            ? 'Xem thêm'
                                            : 'Rút gọn',
                                        style: defaultText14B.copyWith(
                                            color: main1Color),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Lịch khai giảng',
                          style: defaultText18M,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 155.h,
                          width: 390.w,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              physics: const ClampingScrollPhysics(),
                              // itemExtent: 160.h,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                    right: 20.w,
                                    left: 10.w,
                                    top: 5.h,
                                    bottom: 5.h,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.grey.withValues(alpha: 0.2),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 2), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  height: 145.h,
                                  width: 317.w,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Mã lớp',
                                              style: defaultText12M,
                                            ),
                                            Text(
                                              'THH 449',
                                              style: defaultText14B.copyWith(
                                                color: main1Color,
                                              ),
                                            ),
                                            Text(
                                              'Lịch học',
                                              style: defaultText12M,
                                            ),
                                            Text(
                                              '17h40 -19h20 (T3, T5, T7)',
                                              style: defaultText14B.copyWith(
                                                color: main1Color,
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.black,
                                              thickness: 1,
                                            ),
                                            Text(
                                              'Tình trạng',
                                              style: defaultText12M,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 80.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Khai giảng',
                                              style: defaultText12M,
                                            ),
                                            Text(
                                              '11/07/2024',
                                              style: defaultText14B.copyWith(
                                                color: main1Color,
                                              ),
                                            ),
                                            Text(
                                              'Cơ sở',
                                              style: defaultText12M,
                                            ),
                                            Text(
                                              'Lê Văn Việt',
                                              style: defaultText14B.copyWith(
                                                color: main1Color,
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.black,
                                              thickness: 1,
                                            ),
                                            Text(
                                              'Đã hết',
                                              style: defaultText14B.copyWith(
                                                color: key1Color.withValues(
                                                    alpha: 0.3),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Đánh giá từ học viên',
                          style: defaultText18M,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        // Container(
                        //   width: 350.w,
                        //   height: 157.h,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.2),
                        //         spreadRadius: 5,
                        //         blurRadius: 7,
                        //         offset: const Offset(
                        //             0, 2), // changes position of shadow
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 84.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 84.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 84.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Học phí',
                            style: defaultText14M,
                          ),
                          Text(
                            '4.500.000 VND',
                            style: defaultText20B.copyWith(
                              color: main1Color,
                            ),
                          ),
                        ]),
                    GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'Đăng ký thành công',
                                style: defaultText14M,
                              ),
                              content: Text(
                                'Nhân viên tư vấn sẽ liên hệ với bạn trong thời gian sớm nhất',
                                style: defaultText14M,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                  ),
                                  child: const Text('ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 43.h,
                        width: 122.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(36.r),
                          gradient: mainGradient,
                        ),
                        child: Center(
                          child: Text(
                            'Đăng ký ngay',
                            style: defaultText14B.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
