import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:number_paginator/number_paginator.dart';

extension Substrings on String {
  /// Drops the last n characters.
  String dropLast(int n) {
    return n > length ? "" : substring(0, length - n);
  }
}

class TestDetailScreen extends StatefulWidget {
  const TestDetailScreen({
    super.key,
  });

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  int _currentPage = 0;
  var countdownDuration = const Duration(minutes: 15);
  Duration duration = const Duration();
  Timer? timer;
  Timer? timer1;
  bool countDown = true;
  bool countDown1 = true;
  bool? isChecked = false;
  final ValueNotifier<Map<int, int>> _counter =
      ValueNotifier<Map<int, int>>({});
  @override
  void initState() {
    int hours1;
    int mints1;
    int secs1;
    hours1 = int.parse("00");
    mints1 = int.parse("15");
    secs1 = int.parse("00");
    countdownDuration =
        Duration(hours: hours1, minutes: mints1, seconds: secs1);
    startTimer();
    reset();
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void stopTimer() {
    setState(
      () {
        timer1?.cancel();
      },
    );
  }

  void addTime() {
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds - addSeconds;
      if (seconds < 0) {
        timer1?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pages = List.generate(
      10,
      (index) => SizedBox(
        height: 600.h,
        child: ValueListenableBuilder(
          valueListenable: _counter,
          builder: (BuildContext context, value, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 21.h,
                        width: 21.w,
                        decoration: BoxDecoration(
                          color: key1Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: defaultText16M.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 304.w,
                        child: Text(
                          '$index question',
                          style: defaultText16M,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 390.w,
                    //height: 400.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                        //itemExtent: 90,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int answer) {
                          return GestureDetector(
                            onTap: () {
                              // dùng tạm cách này đi
                              //_counter.value[index] = answer;
                              _counter.value.addAll({index: answer});
                              _counter.notifyListeners();
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10.h),
                              decoration: BoxDecoration(
                                // border: Border.all(),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.r),
                                ),
                                color: _counter.value[index] == answer
                                    ? const Color(0xff66D5FF)
                                        .withValues(alpha: 0.3)
                                    : Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Checkbox(
                                    //tristate: true,
                                    value: _counter.value[index] == answer,
                                    shape: const CircleBorder(),
                                    onChanged: (bool? value) {},
                                  ),
                                  SizedBox(
                                    width: 304.w,
                                    child:
                                        //check type of answer
                                        Text(
                                      'Answer $answer',
                                      style: defaultText16M,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: mainGradient,
          ),
        ),
        title: Text(
          'Test 8: Reading',
          style: defaultText18B.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(children: [
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thời gian còn lại',
                  style: defaultText16B,
                ),
                buildTime1(),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text('Bạn có chắc chắn muốn nộp bài'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: Text('Đồng ý', style: defaultText20B),
                          onPressed: () {
                            stopTimer();
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: Text('Hủy', style: defaultText20B),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  },
                );
              },
              child: Container(
                height: 35.h,
                width: 74.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10.r,
                    ),
                  ),
                  color: sub1Color,
                ),
                child: Center(
                  child: Text(
                    'Nộp bài',
                    style: defaultText16B.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        // Container(
        //   width: 350.w,
        //   height: 110.h,
        //   padding: EdgeInsets.symmetric(horizontal: 10.w),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.all(Radius.circular(8.r)),
        //     boxShadow: [
        //       BoxShadow(
        //         color: kPrimaryColor.withOpacity(0.2),
        //         spreadRadius: 5,
        //         blurRadius: 7,
        //         offset: const Offset(4, 7), // changes position of shadow
        //       ),
        //     ],
        //     color: Colors.white,
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //         'Đề bài:',
        //         style: defaultBoldText,
        //       ),
        //     ],
        //   ),
        // ),
        SizedBox(
          height: 20.h,
        ),
        pages[_currentPage],
      ]),
      // card for elevation
      bottomNavigationBar: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        child: NumberPaginator(
          // by default, the paginator shows numbers as center content
          numberPages: 10,
          onPageChange: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }

  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(
        time: hours,
      ),
      Text(
        ':',
        style: defaultText20B.copyWith(
          color: sub1Color,
          fontSize: 20.sp,
        ),
      ),
      buildTimeCard(
        time: minutes,
      ),
      Text(
        ':',
        style: defaultText20B.copyWith(
          color: sub1Color,
          fontSize: 20.sp,
        ),
      ),
      buildTimeCard(
        time: seconds,
      ),
    ]);
  }

  Widget buildTimeCard({
    required String time,
  }) =>
      Text(
        time,
        style: defaultText20B.copyWith(
          color: sub1Color,
        ),
      );
}

class Answer extends StatefulWidget {
  const Answer({super.key, required this.title});
  final String title;
  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Checkbox(
          //tristate: true,
          value: isChecked,
          shape: const CircleBorder(),
          onChanged: (bool? value) {
            setState(() {
              isChecked = value;
            });
          },
        ),
        SizedBox(
          width: 304.w,
          child: Text(
            widget.title,
            style: defaultText16B,
          ),
        ),
      ],
    );
  }
}
