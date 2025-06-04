import 'package:flutter/material.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/hoc_lieu/detail_learning_screen.dart';
import 'package:german_room/student_models/hoclieu_model.dart';
import 'package:german_room/student_repo/hoc_lieu_repo.dart';
import 'package:german_room/utils/constants/styles.dart';

class TopicListScreen extends StatelessWidget {
  final List<HocLieuModel> topics;

  const TopicListScreen({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chi tiết khóa học',
          style: defaultText16M,
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
            title: Text(topic.name, style: defaultText16B),
            children: topic.menuItems.map((menuItem) {
              return ListTile(
                title: Text(menuItem.name),
                onTap: () async {
                  // Xử lý khi người dùng chọn menu con
                  // Ví dụ: chuyển trang hoặc hiển thị chi tiết
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
