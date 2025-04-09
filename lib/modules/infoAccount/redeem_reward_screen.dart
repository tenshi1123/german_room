import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class RedeemRewardScreen extends StatefulWidget {
  const RedeemRewardScreen({super.key});

  @override
  State<RedeemRewardScreen> createState() => _RedeemRewardScreenState();
}

class _RedeemRewardScreenState extends State<RedeemRewardScreen> {
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Đổi điểm thưởng',
          style: defaultText18B,
        ),
        toolbarHeight: 60.h,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: key1Color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                width: 390.w,
                height: 84.h,
                child: Stack(
                  children: [
                    Positioned(
                      right: 20.w,
                      child: Image.asset(
                        'assets/images/redeem.png',
                        height: 84.h,
                        width: 350.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 20.h,
                      right: 40.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Điểm thưởng của tôi',
                            style: defaultText14Re.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '30 điểm',
                            style: defaultText20B.copyWith(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 390.w,
                height: 600.h,
                child: GridView.count(
                  crossAxisCount: 2,
                  //childAspectRatio: (1 / .35),
                  //shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    8,
                    (i) {
                      return const PresentItem();
                    },
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              margin: EdgeInsets.only(bottom: 6.h),
              height: 60.h,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Đã chọn',
                          style: defaultText16Re,
                          children: <TextSpan>[
                            TextSpan(
                              text: ' 02',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: main1Color),
                            ),
                            const TextSpan(text: ' phần thưởng!'),
                          ],
                        ),
                      ),
                      Text(
                        'Tiêu hao: 24 điểm',
                        style: defaultText14Re.copyWith(
                          color: key1Color.withValues(alpha: 0.5),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: RichText(
                            text: TextSpan(
                              text: 'Bạn xác nhận đổi ',
                              style: defaultText14Re,
                              children: [
                                TextSpan(
                                  text: '24 điểm thưởng',
                                  style: defaultText14M.copyWith(
                                    color: main1Color,
                                  ),
                                ),
                                const TextSpan(text: ' lấy phần quà'),
                                TextSpan(
                                  text: ' Gấu bông, bình giữ nhiệt',
                                  style: defaultText14M.copyWith(
                                    color: main1Color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Hủy'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('Xác nhận'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      width: 131.w,
                      height: 43.h,
                      decoration: BoxDecoration(
                        gradient: mainGradient2,
                        borderRadius: BorderRadius.all(
                          Radius.circular(36.r),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Xác nhận đổi',
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
          )
        ],
      ),
    );
  }
}

class PresentItem extends StatefulWidget {
  const PresentItem({super.key});

  @override
  State<PresentItem> createState() => _PresentItemState();
}

class _PresentItemState extends State<PresentItem> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 162.w,
      height: 162.h,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),
              Text(
                'Còn (11)',
                style: defaultText12Re,
              ),
            ],
          ),
          Image.asset(
            'assets/images/bear.png',
            height: 88.h,
            fit: BoxFit.fitHeight,
          ),
          Text(
            'Gấu bông',
            style: defaultText12Re,
          ),
          Text(
            '12 điểm',
            style: defaultText16B.copyWith(
              color: sub2Color,
            ),
          ),
        ],
      ),
    );
  }
}
