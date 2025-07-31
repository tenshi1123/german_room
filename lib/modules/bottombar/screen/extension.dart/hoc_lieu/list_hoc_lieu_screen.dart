import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/hoc_lieu/detail_learning_screen.dart';
import 'package:german_room/student_models/hoclieu_model.dart';
import 'package:german_room/student_repo/hoc_lieu_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class TopicListScreen extends StatelessWidget {
  final List<HocLieuModel> topics;
  final String imageUrl;
  const TopicListScreen(
      {super.key, required this.topics, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chi tiết khóa học',
          style: defaultText16B,
        ),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return ExpansionTile(
            title: Row(
              children: [
                Icon(Icons.description, color: main1Color, size: 20.w),
                SizedBox(width: 8.w),
                Text(topic.name, style: defaultText16M),
              ],
            ),
            children: topic.menuItems.map((menuItem) {
              return ListTile(
                title: Row(
                  children: [
                    SizedBox(width: 8.w),
                    Icon(Icons.touch_app, color: main1Color, size: 16.w),
                    SizedBox(width: 8.w),
                    Text(
                      menuItem.name,
                      style: defaultText14M,
                    ),
                  ],
                ),
                onTap: () async {
                  DetailLearingModel detailLearingModel =
                      await HocLieuRepo().getDetailLearing(
                    learningMaterialsId: topic.learningMaterialsId,
                    partId: menuItem.partId,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailLearingScreen(
                        detailearningModel: detailLearingModel,
                        url: imageUrl,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
