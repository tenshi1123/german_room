// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/login/login_screen.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import '../../../utils/constants/mediaqury.dart';
import '../../../utils/constants/vn_languegua.dart';

class Onbonding extends StatefulWidget {
  const Onbonding({super.key});

  @override
  _OnbondingState createState() => _OnbondingState();
}

class _OnbondingState extends State<Onbonding> {
  final int _numPages = 3;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  late bool isLoading;

  @override
  void initState() {
    isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 4.h,
      width: 26.w,
      decoration: BoxDecoration(
        color: isActive ? key2Color : main2Color,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: height,
                    child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/onboard1.png",
                                      width: 390.w,
                                      height: 560.h,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(height: 5.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.w),
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              'Khám phá thế giới cùng tiếng Đức tại ',
                                          style: TextStyle(
                                              color: key1Color,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'German Room Huế',
                                              style: TextStyle(
                                                  color: main1Color,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height / 40),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/onboard2.png",
                                      width: 390.w,
                                      height: 560.h,
                                    ),
                                    SizedBox(height: 5.h),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 18.w),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Xây dựng nền tảng ',
                                          style: TextStyle(
                                              color: key1Color,
                                              fontSize: 32.sp,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'ngôn ngữ ',
                                              style: TextStyle(
                                                  color: main1Color,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextSpan(
                                              text: 'vững vàng',
                                              style: TextStyle(
                                                  color: key1Color,
                                                  fontSize: 32.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height / 40),
                                    Text(
                                      VnString.thaksforfunevent,
                                      textAlign: TextAlign.center,
                                      style: defaultText16M,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/onboard3.png",
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.w),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Đội ngũ giáo viên ',
                                    style: TextStyle(
                                        color: key1Color,
                                        fontSize: 32.sp,
                                        fontWeight: FontWeight.bold),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'giàu kinh nghiệm',
                                        style: TextStyle(
                                            color: main1Color,
                                            fontSize: 32.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // TextSpan(
                                      //   text: 'vững vàng',
                                      //   style: TextStyle(
                                      //       color: key1Color,
                                      //       fontSize: 32.sp,
                                      //       fontWeight: FontWeight.bold),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: height / 40),
                              Text(
                                VnString.withtimelynotification,
                                textAlign: TextAlign.center,
                                style: defaultText16M,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // _currentPage != _numPages - 1
            //     ? Column(
            //         children: [
            //           SizedBox(height: height / 1.12),
            //           Container(
            //             color: Colors.transparent,
            //             height: height / 11,
            //             child: Align(
            //               child: Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 22.w),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: <Widget>[

            //                     Container(
            //                       color: Colors.transparent,
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: _buildPageIndicator(),
            //                       ),
            //                     ),
            //                     GestureDetector(
            //                       onTap: () {
            //                         _pageController.nextPage(
            //                             duration:
            //                                 const Duration(microseconds: 300),
            //                             curve: Curves.easeIn);
            //                       },
            //                       child: Container(
            //                           height: 42.h,
            //                           width: 42.w,
            //                           decoration: BoxDecoration(
            //                               color: sub1Color,
            //                               borderRadius: BorderRadius.all(
            //                                   Radius.circular(16.r))),
            //                           child: Center(
            //                             child: Icon(
            //                               Icons.keyboard_arrow_right,
            //                               size: 30.h,
            //                               color: wihitecolor,
            //                             ),
            //                           )),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       )
            //     :
            Column(
              children: [
                SizedBox(height: height / 1.12),
                Container(
                  color: Colors.transparent,
                  height: height / 11,
                  child: Align(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _buildPageIndicator(),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //tips and trick
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const LoginScreen()),
                                ),
                              );
                            },
                            child: Container(
                              height: 42.h,
                              width: 42.w,
                              decoration: BoxDecoration(
                                  color: sub1Color,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.r))),
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 30.h,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
