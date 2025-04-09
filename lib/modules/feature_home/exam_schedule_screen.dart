import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/student_repo/lichthi_repo.dart';
import 'package:german_room/student_models/lichthi_models.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class ExamScheduleScreen extends StatefulWidget {
  const ExamScheduleScreen({super.key, required this.lichthiModel});
  final LichthiModel lichthiModel;
  @override
  State<ExamScheduleScreen> createState() => _ExamScheduleScreenState();
}

// enum IconLabel {
//   smile('Smile', Icons.sentiment_satisfied_outlined),
//   cloud(
//     'Cloud',
//     Icons.cloud_outlined,
//   ),
//   brush('Brush', Icons.brush_outlined),
//   heart('Heart', Icons.favorite);

//   const IconLabel(this.label, this.icon);
//   final String label;
//   final IconData icon;
// }

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  final TextEditingController cosoController = TextEditingController();
  final TextEditingController ngaythiController = TextEditingController();
  final TextEditingController cathiController = TextEditingController();
  final ValueNotifier<int> _format = ValueNotifier(1);
  CoSoModel? selectedCoso;
  String? selectedNgay;
  ValueModel? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                            'Lịch thi',
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
                    right: 20,
                    child: Image.asset(
                      'assets/images/lich_thi.png',
                      width: 156.w,
                      height: 118.h,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 350.w,
              height: 306.h,
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
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Đăng kí thi thử tháng 9/2024',
                    style: defaultText16B,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ValueListenableBuilder(
                    valueListenable: _format,
                    builder: (context, value, child) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _format.value = 1;
                            },
                            child: Container(
                              width: 60.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: _format.value == 1
                                    ? main1Color
                                    : key1Color.withValues(alpha: 0.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                              ),
                              child: Center(
                                child: Text(
                                  'Toeic',
                                  style: defaultText14B.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              _format.value = 2;
                            },
                            child: Container(
                              width: 60.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: _format.value == 2
                                    ? main1Color
                                    : key1Color.withValues(alpha: 0.2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                              ),
                              child: Center(
                                child: Text(
                                  'Ielts',
                                  style: defaultText14B.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DropdownMenu<CoSoModel>(
                    controller: cosoController,
                    enableFilter: true,
                    requestFocusOnTap: true,
                    label: Text(
                      'Chọn cơ sở',
                      style: defaultText14Re,
                    ),
                    textStyle: defaultText14M,
                    width: 310.w,
                    inputDecorationTheme: InputDecorationTheme(
                      //filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      constraints: BoxConstraints.tight(
                        Size.fromHeight(40.h),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onSelected: (CoSoModel? coso) {
                      setState(() {
                        selectedCoso = coso;
                      });
                    },
                    dropdownMenuEntries: widget.lichthiModel.cosos
                        .map<DropdownMenuEntry<CoSoModel>>(
                      (CoSoModel coso) {
                        return DropdownMenuEntry<CoSoModel>(
                          value: coso,
                          label: coso.name,
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  selectedCoso == null
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(
                            left: 12.w,
                            top: 18.h,
                            right: 12.w,
                          ),
                          child: FutureBuilder<List<String>>(
                            future: ExamScheduleRepo().changeCoso(
                                cosoId: selectedCoso?.id ?? '1',
                                type: _format.value),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownMenu<String>(
                                  controller: ngaythiController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  label: Text(
                                    'Chọn ngày thi',
                                    style: defaultText14Re,
                                  ),
                                  textStyle: defaultText14M,
                                  width: 310.w,
                                  inputDecorationTheme: InputDecorationTheme(
                                    //filled: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    constraints: BoxConstraints.tight(
                                      Size.fromHeight(40.h),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onSelected: (String? day) {
                                    setState(() {
                                      selectedNgay = day;
                                    });
                                  },
                                  dropdownMenuEntries: snapshot.data!
                                      .map<DropdownMenuEntry<String>>(
                                    (String day) {
                                      return DropdownMenuEntry<String>(
                                        value: day,
                                        label: day,
                                      );
                                    },
                                  ).toList(),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                  selectedNgay == null
                      ? const SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(
                            left: 12.w,
                            top: 18.h,
                            right: 12.w,
                          ),
                          child: FutureBuilder<List<ValueModel>>(
                            future: ExamScheduleRepo().changeDay(
                              cosoId: selectedCoso?.id ?? '1',
                              type: _format.value,
                              day: selectedNgay ?? '',
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return DropdownMenu<ValueModel>(
                                  controller: cathiController,
                                  enableFilter: true,
                                  requestFocusOnTap: true,
                                  label: Text(
                                    'Chọn ca thi',
                                    style: defaultText14Re,
                                  ),
                                  textStyle: defaultText14M,
                                  width: 310.w,
                                  inputDecorationTheme: InputDecorationTheme(
                                    //filled: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    constraints: BoxConstraints.tight(
                                      Size.fromHeight(40.h),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onSelected: (ValueModel? value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  dropdownMenuEntries: snapshot.data!
                                      .map<DropdownMenuEntry<ValueModel>>(
                                    (ValueModel value) {
                                      return DropdownMenuEntry<ValueModel>(
                                        value: value,
                                        label: value.name,
                                      );
                                    },
                                  ).toList(),
                                );
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 130.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      gradient: mainGradient,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoAlertDialog(
                              title: Text(
                                'Bạn có chắc chắn muốn đăng kí tham gia buổi thi này',
                                style: defaultText14M,
                              ),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: Text(
                                    'Chắc chắn',
                                    style: TextStyle(
                                        fontSize: 20, color: key1Color),
                                  ),
                                  onPressed: () {
                                    if (selectedValue != null) {
                                      ExamScheduleRepo()
                                          .dkiThi(id: selectedValue!.id);
                                    }

                                    Navigator.of(context, rootNavigator: true)
                                        .pop(
                                      (_) => false,
                                    );
                                  },
                                ),
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: Text(
                                    'Hủy',
                                    style: TextStyle(
                                        fontSize: 20, color: key1Color),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop(
                                      (_) => false,
                                    );
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Center(
                        child: Text(
                          'Đăng kí tham gia',
                          style: defaultText14B.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Lịch thi của tôi',
              style: defaultText16B,
            ),
            SizedBox(
              height: 330.h,
              width: 390.w,
              child: _LichThi(
                listLichthi: widget.lichthiModel.lichCuaToi,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LichThi extends StatefulWidget {
  const _LichThi({required this.listLichthi});

  final List<LichCuaToiModels> listLichthi;
  @override
  State<_LichThi> createState() => _LichThiState();
}

class _LichThiState extends State<_LichThi> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // bỏ comment cái dưới và cmt cái này nhé
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: widget.listLichthi.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  // height: 182.h,
                  width: 349.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
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
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Container(
                            //height: 70.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                              gradient: mainGradient2,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              child: (Text(
                                widget.listLichthi[index].typeName,
                                style: defaultText16B.copyWith(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                widget.listLichthi[index].name,
                                style: defaultText16B,
                              ),
                              Text(
                                widget.listLichthi[index].day,
                                style: defaultText14Re,
                              ),
                              Text(
                                widget.listLichthi[index].description,
                                style: defaultText14Re,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 74.h,
                        width: 325.w,
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: key1Color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.r),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 80.w,
                                  child: Text(
                                    'Cơ sở',
                                    style: defaultText14Re,
                                  ),
                                ),
                                Text(
                                  'P101 - Giáo viên 1',
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
                                  width: 80.w,
                                  child: Text(
                                    'Hình thức',
                                    style: defaultText14Re,
                                  ),
                                ),
                                Text(
                                  'Offline',
                                  style: defaultText14B,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
