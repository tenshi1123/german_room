// xin nghi dialog
import 'package:flutter/material.dart';
import 'package:german_room/student_repo/customer_repo.dart';
import 'package:german_room/utils/constants/styles.dart';

class LeaveRequestDialog extends StatelessWidget {
  const LeaveRequestDialog(
      {super.key,
      required this.checkinOffId,
      required this.lichhoc,
      required this.onConfirm});
  final String checkinOffId;
  final String lichhoc;
  final VoidCallback onConfirm;
  @override
  Widget build(BuildContext context) {
    TextEditingController reasonController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lịch học: $lichhoc',
              style: defaultText16M,
            ),
            const SizedBox(height: 16),
            Text(
              'Lý do xin nghỉ',
              style: defaultText16M,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: reasonController,
              style: defaultText14M,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập lý do nghỉ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 59, 54, 54),
                      backgroundColor: const Color(0xFFF7F4F6),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Hủy'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Handle confirmation logic
                      await CustomerRepo().leaveSchedule(
                          checkinOffId: checkinOffId,
                          reason: reasonController.text);
                      onConfirm();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã gửi yêu cầu nghỉ học'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF7C98B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Xác nhận'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CancelLeaveReqDialog extends StatelessWidget {
  const CancelLeaveReqDialog(
      {super.key,
      required this.checkinOffId,
      required this.lichhoc,
      required this.onConfirm,
      required this.mettingId});
  final String checkinOffId;
  final String mettingId;
  final String lichhoc;
  final VoidCallback onConfirm;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lịch học: $lichhoc',
              style: defaultText16M,
            ),
            const SizedBox(height: 16),
            Text(
              'Bạn chắc chắn muốn hủy yêu cầu nghỉ học này?',
              style: defaultText16M,
            ),
            const SizedBox(height: 8),
            // TextField(
            //   controller: reasonController,
            //   maxLines: 3,
            //   decoration: InputDecoration(
            //     hintText: 'Nhập lý do nghỉ',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     contentPadding: const EdgeInsets.all(12),
            //   ),
            // ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: const Color(0xFFF7F4F6),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Hủy'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Handle confirmation logic
                      await CustomerRepo().cancleSchedule(
                        checkinOffId: checkinOffId,
                        mettingId: mettingId,
                      );
                      onConfirm();
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Đã hủy yêu cầu nghỉ học'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffED1C24),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Xác nhận'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
