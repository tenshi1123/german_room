import 'package:flutter/material.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/schedule_screen.dart';
import 'package:german_room/student_models/schedule_model.dart';

class ListLessonScreen extends StatefulWidget {
  const ListLessonScreen({
    super.key,
    required this.listLessonModel,
    required this.title,
  });
  final List<ScheduleModel> listLessonModel;
  final String title;

  @override
  State<ListLessonScreen> createState() => _ListLessonScreenState();
}

class _ListLessonScreenState extends State<ListLessonScreen> {
  late final List<ScheduleModel> _listLessonModel;

  @override
  void initState() {
    _listLessonModel = widget.listLessonModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Lịch học ${widget.title}'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: _listLessonModel.length,
          itemBuilder: (context, index) {
            return ItemTableCalender(
              model: _listLessonModel[index],
            );
          },
        ));
  }
}
