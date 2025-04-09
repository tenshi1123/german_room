import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key, required this.listPayments});
  final List<PaymentModel> listPayments;
  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Lịch sử thanh toán',
          style: defaultText18B.copyWith(
            color: Colors.white,
          ),
        ),
        toolbarHeight: 60.h,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: key1Color,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.listPayments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                    width: 350.w,
                    height: 235.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150.h,
                          width: 350.w,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      'Khóa học',
                                      style: defaultText12Re,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      'Tình trạng thanh toán',
                                      style: defaultText12M,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      widget.listPayments[index].courseName,
                                      style: defaultText14B,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      '${widget.listPayments[index].tinhTrang}%',
                                      style: defaultText14B.copyWith(
                                          color: main1Color),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      'Chi phí',
                                      style: defaultText12Re,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      NumberFormat("#,###", "vi_VN").format(
                                          int.tryParse(widget
                                              .listPayments[index].totalPrice)),
                                      style: defaultText14B,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      'Đã thanh toán',
                                      style: defaultText12Re,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      NumberFormat("#,###", "vi_VN").format(
                                          int.tryParse(widget
                                              .listPayments[index].totalPaid)),
                                      style: defaultText14B.copyWith(
                                          color: main1Color),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      'Còn thiếu',
                                      style: defaultText12Re,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150.w,
                                    child: Text(
                                      '${widget.listPayments[index].conthieu}%',
                                      style: defaultText12M,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          indent: 15.w,
                          endIndent: 15.w,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            SvgPicture.asset('assets/icons/timer.svg'),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              'Lịch sử thanh toán',
                              style: defaultText14Re,
                            ),
                            SizedBox(
                              width: 120.w,
                            ),
                            SvgPicture.asset('assets/icons/dropdown.svg'),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
