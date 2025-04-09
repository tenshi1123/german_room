import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailNewsScreen extends StatelessWidget {
  const DetailNewsScreen({super.key, required this.model});
  final DetailPostModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chi tiết ',
          style: defaultText14M,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //height: 93.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  color: main2Color),
              child: Center(
                  child: Image.network(
                model.thumbnail,
                fit: BoxFit.fitWidth,
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    model.postTitle,
                    style: defaultText16B,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    DateFormat("HH:mm dd/MM/yyyy").format(model.postDate),
                    style: defaultText16M,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                      onPressed: () async {
                        if (!await launchUrl(Uri.parse(model.guid))) {
                          throw Exception('Could not launch');
                        }
                      },
                      child: const Text('Mở trên web')),
                  HtmlWidget(
                    model.postContent,
                    textStyle: defaultText14M,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
