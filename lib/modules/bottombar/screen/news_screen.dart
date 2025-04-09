import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:german_room/modules/bottombar/screen/details_new_screen.dart';
import 'package:german_room/student_repo/home_repo.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'dart:async';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<PostModel> items = []; // Danh sách dữ liệu
  bool isLoading = false; // Trạng thái loading
  int page = 1; // Trang dữ liệu

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchData(); // Load dữ liệu lần đầu
    _scrollController.addListener(_scrollListener); // Lắng nghe sự kiện cuộn
  }

  // Hàm gọi API (giả lập)
  Future<void> _fetchData() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    // Giả lập gọi API (delay 2 giây)
    await Future.delayed(const Duration(seconds: 2));
    List<PostModel> newItems = await HomeRepo().getlistPost(page);
    setState(() {
      items.addAll(newItems);
      isLoading = false;
      page++;
    });
  }

  // Lắng nghe sự kiện cuộn để tải thêm dữ liệu
  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !isLoading) {
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 160.h,
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
                  left: 22.w,
                  child: Text(
                    'Tin tức German Room ',
                    style: defaultText20B.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.h,
                  left: 250.w,
                  child: Image.asset(
                    'assets/images/news.png',
                    width: 133.w,
                    height: 125.h,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: items.length + 1, // +1 để hiển thị loading
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox(); // Không hiển thị gì nếu không loading
                }
                return CourseItem(
                  model: items[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Giải phóng bộ nhớ
    super.dispose();
  }
}

class CourseItem extends StatelessWidget {
  const CourseItem({super.key, required this.model});
  final PostModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DetailPostModel detailPostModel =
            await HomeRepo().getDetailPost(id: model.id);
        if (!context.mounted) return;
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => DetailNewsScreen(
                      model: detailPostModel,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
        height: 93.h,
        width: 350.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ClipRRect(
            //   borderRadius: const BorderRadius.only(
            //     topLeft: Radius.circular(16),
            //     topRight: Radius.circular(16),
            //   ),
            //   child: Image.asset('assets/images/course_image.png'),
            // ),

            Container(
              height: 93.h,
              width: 103.w,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  color: main2Color),
              child: Center(
                  child: Image.network(
                model.img,
                fit: BoxFit.fill,
              )),
            ),
            SizedBox(
              width: 10.w,
            ),
            SizedBox(
              height: 93.h,
              width: 227.w,
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    height: 60.h,
                    child: Text(
                      model.name,
                      style: defaultText14B,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.categories,
                        style: defaultText12Re,
                      ),
                      Text(
                        DateFormat("dd.MM.yyyy").format(model.postDate),
                        style: defaultText12Re,
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }
}
