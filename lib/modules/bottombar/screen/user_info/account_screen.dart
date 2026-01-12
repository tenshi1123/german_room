import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/bottombar/screen/user_info/change_pass_screen.dart';
import 'package:german_room/modules/login/login_screen.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/student_repo/customer_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key, required this.profileModel});
  final ProfileModel profileModel;
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _avatarFile;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        _avatarFile = File(pickedFile.path);
      });
      bool status = await CustomerRepo().changeAvatar(_avatarFile!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            status
                ? 'Đổi ảnh đại diện thành công!'
                : 'Đổi ảnh đại diện thất bại!',
          ),
        ),
      );
    }
  }

  void _showPickImageDialog() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(
                  'Chọn từ thư viện',
                  style: defaultText14M,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  'Chụp ảnh',
                  style: defaultText14M,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390.w,
      height: 844.h,
      decoration: BoxDecoration(gradient: asdjajsdhasjidas),
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          SizedBox(
            height: 250.h,
            width: 349.w,
            child: Stack(
              children: [
                Positioned(
                  top: 50.h,
                  child: Container(
                    //height: 242.h,
                    width: 349.w,
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 120.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 160.w,
                                  child: Text(
                                    widget.profileModel.fullName,
                                    style: defaultText18B,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  'Mã học viên: ${widget.profileModel.id}',
                                  style: defaultText12Re.copyWith(
                                    color: key1Color,
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //             const EditInfoScreen(),
                            //       ),
                            //     );
                            //   },
                            //   child: Container(
                            //     height: 25.h,
                            //     width: 25.w,
                            //     padding: const EdgeInsets.all(3),
                            //     decoration: BoxDecoration(
                            //       shape: BoxShape.circle,
                            //       gradient: mainGradient2,
                            //     ),
                            //     child:
                            //         SvgPicture.asset('assets/icons/pencil.svg'),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Divider(
                          thickness: 1,
                          // indent: 15.w,
                          // endIndent: 15.w,
                          color: Colors.black.withValues(alpha: 0.5),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Họ và tên',
                              style: defaultText14Re,
                            ),
                            SizedBox(
                              width: 202.w,
                              child: Text(
                                widget.profileModel.fullName,
                                style: defaultText14M,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ngày sinh',
                              style: defaultText14Re,
                            ),
                            SizedBox(
                              width: 202.w,
                              child: Text(
                                widget.profileModel.birthday,
                                style: defaultText14M,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Số điện thoại',
                              style: defaultText14Re,
                            ),
                            SizedBox(
                              width: 202.w,
                              child: Text(
                                widget.profileModel.phone,
                                style: defaultText14M,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Giới tính',
                              style: defaultText14Re,
                            ),
                            SizedBox(
                              //height: 38.h,
                              width: 202.w,
                              child: Text(
                                widget.profileModel.gender,
                                style: defaultText14B,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 15.w,
                  child: GestureDetector(
                    onTap: _showPickImageDialog,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 56.r,
                          backgroundColor: Colors.grey.shade200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(56.r),
                            child: _avatarFile != null
                                ? Image.file(
                                    _avatarFile!,
                                  )
                                : Image.network(
                                    widget.profileModel.avatar,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.person,
                                      size: 40,
                                    ),
                                  ),
                          ),
                        ),

                        /// ICON CAMERA
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            padding: EdgeInsets.all(6.r),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 18.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            //height: 133.h,
            width: 350.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Quản lý tài khoản',
                  style: defaultText14M,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Mật khẩu',
                //       style: defaultText14M,
                //     ),
                //     Icon(
                //       Icons.keyboard_arrow_right,
                //       size: 30.h,
                //       color: key1Color,
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Thông báo',
                //       style: defaultText14M,
                //     ),
                //     Icon(
                //       Icons.keyboard_arrow_right,
                //       size: 30.h,
                //       color: key1Color,
                //     ),
                //   ],
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePassScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mật khẩu',
                        style: defaultText14M,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 30.h,
                        color: key1Color,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _makePhoneCall('19008978');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hotline hỗ trợ',
                        style: defaultText14M,
                      ),
                      Text(
                        '077 457 2930',
                        style: defaultText14M.copyWith(
                          color: sub1Color,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () => _dialogBuilder(context),
                  child: Container(
                    height: 49.h,
                    width: 315.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: state1,
                    ),
                    child: Center(
                      child: Text(
                        'Đăng xuất',
                        style: defaultText14M,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Đăng xuất',
          style: defaultText14M,
        ),
        content: Text(
          'Bạn có chắc muốn đăng xuất ?',
          style: defaultText14M,
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Xác nhận'),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('token');
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const LoginScreen()),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
