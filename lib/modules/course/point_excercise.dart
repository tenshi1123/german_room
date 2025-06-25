import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/student_models/my_course_model.dart';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:german_room/utils/constants/color.dart';

class PointScreen extends StatefulWidget {
  const PointScreen({super.key, required this.courseScheduleId});
  final String courseScheduleId;
  @override
  State<PointScreen> createState() => _PointScreenState();
}

class _PointScreenState extends State<PointScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late PointModel _pointModel;
  bool _isLoading = true;
  bool _isError = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await MycourseRepo().getPoint(id: widget.courseScheduleId);
      setState(() {
        _pointModel = response;
        _isLoading = false;
        _isError = false;
      });
    } catch (e) {
      debugPrint('Lỗi khi gọi API: $e');
      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Điểm số'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: mainGradient,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            TabBar.secondary(
              controller: _tabController,
              tabs: const <Widget>[
                Tab(text: 'Bài tập bổ trợ'),
                Tab(text: 'Đề thi')
              ],
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _isError
                    ? const Center(
                        child: Text(
                          'Không có dữ liệu. Vui lòng thử lại sau.',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            (_pointModel.baiTapBoTro.isEmpty)
                                ? const Center(
                                    child: Text('Không có bài tập bổ trợ nào.'))
                                : ListView.builder(
                                    padding: EdgeInsets.only(
                                        left: 20.w, right: 20.w, top: 10.h),
                                    itemCount: _pointModel.baiTapBoTro
                                        .expand((element) => element)
                                        .toList()
                                        .length,
                                    itemBuilder: (context, index) {
                                      final baiTap = _pointModel.baiTapBoTro
                                          .expand((element) => element)
                                          .toList()[index];
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildInfoRow(
                                                  'TÊN BÀI TẬP:', baiTap.name,
                                                  isTitle: true),
                                              const Divider(),
                                              _buildInfoRow(
                                                  'THỜI HẠN NỘP:',
                                                  _formatDateTime(
                                                      baiTap.timeDeadline)),
                                              _buildInfoRow(
                                                  'THỜI GIAN NỘP:',
                                                  _formatDateTime(baiTap
                                                      .createdAtCustomer)),
                                              _buildInfoRow('GHI CHÚ HỌC VIÊN:',
                                                  baiTap.noteCustomer),
                                              _buildInfoRow(
                                                  'GHI CHÚ GIÁO VIÊN:',
                                                  baiTap.noteLecturers),
                                              _buildInfoRow(
                                                  'ĐIỂM:',
                                                  baiTap.finalMark ??
                                                      'Chưa có'),
                                              _buildActionRow(
                                                context:
                                                    null, // Context sẽ được cung cấp từ widget cha khi sử dụng
                                                label: 'Xem đề bài',
                                                icon: Icons.description,
                                                onTap: () {
                                                  if (baiTap
                                                      .urlFile.isNotEmpty) {
                                                    _launchURL(baiTap.urlFile);
                                                  } else {
                                                    _showSnackBar(context,
                                                        'Đề bài không có sẵn.');
                                                  }
                                                },
                                              ),
                                              _buildActionRow(
                                                context:
                                                    null, // Context sẽ được cung cấp từ widget cha khi sử dụng
                                                label: 'Xem bài đã nộp',
                                                icon: Icons.cloud_upload,
                                                onTap: () {
                                                  if (baiTap.urlFileCustomer
                                                      .isNotEmpty) {
                                                    _launchURL(
                                                        baiTap.urlFileCustomer);
                                                  } else {
                                                    _showSnackBar(context,
                                                        'Bạn chưa nộp bài hoặc bài nộp không có sẵn.');
                                                  }
                                                },
                                              ),
                                              _buildActionRow(
                                                context:
                                                    null, // Context sẽ được cung cấp từ widget cha khi sử dụng
                                                label: 'Xem đáp án',
                                                icon: Icons.school,
                                                onTap: () {
                                                  if (baiTap.urlFileLecturers !=
                                                          null &&
                                                      baiTap.urlFileLecturers!
                                                          .isNotEmpty) {
                                                    _launchURL(baiTap
                                                        .urlFileLecturers!);
                                                  } else {
                                                    _showSnackBar(context,
                                                        'Không có file đáp án.');
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            (_pointModel.exercise.isEmpty)
                                ? const Center(
                                    child: Text('Không có bài tập bổ trợ nào.'))
                                : ListView.builder(
                                    padding: EdgeInsets.only(
                                        left: 20.w, right: 20.w, top: 10.h),
                                    itemCount: _pointModel.exercise
                                        .expand((element) => element)
                                        .toList()
                                        .length,
                                    itemBuilder: (context, index) {
                                      final baiTap = _pointModel.exercise
                                          .expand((element) => element)
                                          .toList()[index];
                                      return Card(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildInfoRow(
                                                  'TÊN ĐỀ THI:', baiTap.name,
                                                  isTitle: true),
                                              const Divider(),
                                              _buildInfoRow(
                                                  'THỜI HẠN NỘP:',
                                                  _formatDateTime(
                                                      baiTap.timeDeadline)),
                                              _buildInfoRow(
                                                  'THỜI GIAN NỘP:',
                                                  _formatDateTime(
                                                      baiTap.updateAt)),
                                              _buildInfoRow(
                                                  'ĐIỂM:',
                                                  baiTap.finalMark ??
                                                      'Chưa có'),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ],
                        ),
                      ),
          ],
        ));
  }
}

Widget _buildInfoRow(String label, String value, {bool isTitle = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTitle ? 16 : 14,
            color: isTitle ? Colors.black87 : Colors.black54,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          // Để giá trị có thể tràn ra nếu dài
          child: Text(
            value,
            style: TextStyle(
              fontSize: isTitle ? 16 : 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

String _formatDateTime(String dateTimeString) {
  try {
    final DateTime dateTime = DateTime.parse(dateTimeString);

    return '${_addLeadingZero(dateTime.day)}-${_addLeadingZero(dateTime.month)}-${dateTime.year} ${_addLeadingZero(dateTime.hour)}:${_addLeadingZero(dateTime.minute)}';
  } catch (e) {
    return dateTimeString;
  }
}

String _addLeadingZero(int number) {
  return number.toString().padLeft(2, '0');
}

// --- HÀM TIỆN ÍCH CHO CÁC HÀNG HÀNH ĐỘNG (DÒNG MỚI THÊM VÀO) ---
Widget _buildActionRow({
  required BuildContext?
      context, // Đặt là nullable để ví dụ main() chạy được mà không cần context thực
  required String label,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return InkWell(
    // Giúp cho toàn bộ hàng có thể nhấn được
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF296142)), // Icon màu xanh
          const SizedBox(width: 12.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue, // Màu xanh để biểu thị là liên kết/hành động
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(), // Đẩy icon mũi tên sang phải
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    ),
  );
}

// Hàm giả lập mở URL (trong thực tế bạn sẽ dùng package url_launcher)
void _launchURL(String url) async {
  // Thêm package url_launcher vào pubspec.yaml:
  // dependencies:
  //   url_launcher: ^6.0.0 (hoặc phiên bản mới nhất)
  //
  // Sau đó import:
  // import 'package:url_launcher/url_launcher.dart';
  //
  // và sử dụng như sau:
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   print('Không thể mở URL: $url');
  //   // Hiển thị thông báo lỗi cho người dùng
  // }
  print('Đã cố gắng mở URL: $url');
  // Trong ví dụ này chỉ in ra console
}

// Hàm hiển thị SnackBar (thông báo nhỏ ở cuối màn hình)
void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}
