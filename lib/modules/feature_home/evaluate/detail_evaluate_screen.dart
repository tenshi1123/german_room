import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class DetailEvaluateScreen extends StatelessWidget {
  const DetailEvaluateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Chi tiết đánh giá',
          style: defaultText18B.copyWith(
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: mainGradient,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Text(
              'Đánh giá định kỳ tháng 7',
              style: defaultText18B,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(
                    'Giảng viên',
                    style: defaultText14Re,
                  ),
                ),
                SizedBox(
                  width: 160.w,
                  child: Text(
                    'Nguyễn Phú',
                    style: defaultText14B,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(
                    'Khóa học',
                    style: defaultText14Re,
                  ),
                ),
                SizedBox(
                  width: 160.w,
                  child: Text(
                    'TOEIC 4 kỹ năng',
                    style: defaultText14B,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(
                    'Lớp',
                    style: defaultText14Re,
                  ),
                ),
                SizedBox(
                  width: 160.w,
                  child: Text(
                    'TTH001',
                    style: defaultText14B,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 10.h,
            ),
            // Text(
            //   'Nhận xét chung',
            //   style: defaultText18B,
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Container(
            //   width: 350.w,
            //   height: 170.h,
            //   decoration: BoxDecoration(
            //     color: baseColor,
            //   ),
            //   child: Row(
            //     children: [
            //       SizedBox(
            //         width: 167.w,
            //         child: Padding(
            //           padding: EdgeInsets.only(
            //             left: 10.w,
            //             top: 6.h,
            //           ),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'Điểm mạnh',
            //                 style: defaultText16B.copyWith(color: main1Color),
            //               ),
            //               Text(
            //                 'Một ngày mới khi ánh năng lên gió khẽ đưa trên bông lúa xanh, và tình yêu trong tim có em gần bên anh, dịu dành anh đưa em qua thắng năm',
            //                 style: defaultText14Re.copyWith(
            //                   fontWeight: FontWeight.w400,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       VerticalDivider(
            //         color: Colors.white,
            //         thickness: 2,
            //         indent: 10.h,
            //         endIndent: 10.h,
            //       ),
            //       SizedBox(
            //         width: 167.w,
            //         child: Padding(
            //           padding: EdgeInsets.only(
            //             left: 10.w,
            //             top: 6.h,
            //           ),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 'Cần cải thiện',
            //                 style: defaultText16B.copyWith(color: sub2Color),
            //               ),
            //               Text(
            //                 'Từng ngày dịu dàng trôi qua mau, nhẹ trôi êm đềm',
            //                 style: defaultText14Re,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.2),
            //         spreadRadius: 5,
            //         blurRadius: 7,
            //         offset: const Offset(0, 2), // changes position of shadow
            //       ),
            //     ],
            //     color: Colors.white,
            //   ),
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 6.h,
            //       ),
            //       Text(
            //         'Đề xuất',
            //         style: defaultText18B.copyWith(
            //           color: key2Color,
            //         ),
            //       ),
            //       Padding(
            //         padding: EdgeInsets.only(
            //           left: 10.w,
            //           right: 5.w,
            //         ),
            //         child: Text(
            //           'Qua bao nhiêu năm qua bao nhiêu kiếp người bao nhiêu con người đã qua, bao nhiêu nụ cười trẻ thơ ',
            //           style: defaultText14Re.copyWith(
            //             color: key2Color,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 10.h,
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Text(
            //   'Đánh giá chi tiết',
            //   style: defaultText16M.copyWith(
            //     color: key2Color,
            //   ),
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // chartItem(width: 350, percents: 92, title: 'Chuyên cần'),
            // chartItem(width: 350, percents: 75, title: 'Bài tập'),
            // chartItem(width: 350, percents: 100, title: 'Thái độ'),
            Text(
              'Đạt được',
              style: defaultText18B.copyWith(color: main1Color),
            ),
            SizedBox(
              height: 5.h,
            ),
            const UnorderedList(
              [
                "What conclusions can we draw from the implementation?",
                "Are there any changes that need to be introduced permanently?"
              ],
              icon: 1,
            ),
            const Divider(),
            Text(
              'Cải thiện',
              style: defaultText18B.copyWith(color: sub2Color),
            ),
            SizedBox(
              height: 5.h,
            ),
            const UnorderedList(
              ["Kỹ năng nói và viết còn kém", "Vốn từ còn ít"],
              icon: 0,
            ),
            const Divider(),
            Text(
              'Dặn dò',
              style: defaultText18B,
            ),
            SizedBox(
              height: 5.h,
            ),
            const UnorderedList(
              [
                "Em cần tự ti tin hơn trong giao tiếp",
                "Em cần chăm chỉ học từ vực hơn"
              ],
              icon: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class UnorderedList extends StatelessWidget {
  const UnorderedList(this.texts, {super.key, required this.icon});
  final List<String> texts;
  final int icon;
  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(
        text,
        icon: icon,
      ));
      // Add space between items
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  const UnorderedListItem(this.text, {super.key, required this.icon});
  final String text;
  final int icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "• ",
          style: defaultText14M,
        ),
        Expanded(
          child: Text(
            text,
            style: defaultText14M,
          ),
        ),
        (icon == 1)
            ? const Icon(
                Icons.done,
                color: Colors.green,
              )
            : const SizedBox()
      ],
    );
  }
}
