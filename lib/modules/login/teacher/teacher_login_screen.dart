import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:german_room/student_repo/login_repo.dart';
import 'package:german_room/teacher/teacher_model/home_teacher_model.dart';
import 'package:german_room/teacher/teacher_repo/teacher_repo.dart';
import 'package:german_room/teacher_modules/teacher_bottombar/teacher_bottombar.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';

class TeacherLogin extends StatefulWidget {
  const TeacherLogin({super.key});

  @override
  State<TeacherLogin> createState() => _TeacherLoginState();
}

class _TeacherLoginState extends State<TeacherLogin> {
  bool _obscurePassword = true;
  final TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 82.h,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    "assets/images/back_icon.png",
                    width: 48.w,
                    height: 48.h,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Xin chào!',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: key1Color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(children: [
                  SvgPicture.asset('assets/icons/wave_hand.svg'),
                  SizedBox(
                    height: 16.h,
                  )
                ]),
              ],
            ),
            Text(
              'Chào mừng đã trở lại, hãy đăng nhập',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xff163065).withValues(alpha: 60),
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
              ),
              overflow: TextOverflow.clip,
            ),
            SizedBox(
              height: 32.h,
            ),
            _buildTextField(
              label: "Email",
              icon: Icons.person,
              isPassword: false,
              controller: emailController,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              label: "Mật khẩu",
              icon: Icons.lock,
              isPassword: true,
              controller: passwordController,
            ),
            const SizedBox(height: 12),
            //_buildRememberPassword(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Xử lý đăng nhập
                  bool loged = await LoginRepo().loginTeacher(
                      emailController.text, passwordController.text);

                  if (loged == true) {
                    TeacherHomeModel? infoModel =
                        await TeacherRepo().getHomeInfo();
                    TeacherProfileModel teacherProfileModel =
                        await TeacherRepo().getCustomerProfile();
                    if (!context.mounted) return;
                    if (infoModel != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherBottomBar(
                            infoModel: infoModel,
                            teacherProfileModel: teacherProfileModel,
                          ),
                        ),
                      );
                    }
                  } else {
                    if (!context.mounted) return;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text('Vui lòng thử lại'),
                          content: const Text(
                              'Vui lòng kiểm tra lại mã học sinh và mật khẩu của bạn'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: Text(
                                'Đồng ý',
                                style:
                                    TextStyle(fontSize: 20, color: key1Color),
                              ),
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).pop(
                                  (_) => false,
                                );
                              },
                            )
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff28B4E9),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text(
                  "Đăng nhập",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required bool isPassword,
    required TextEditingController controller,
  }) {
    return TextField(
      obscureText: isPassword ? _obscurePassword : false,
      style: defaultText14M,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF5F7FA),
        hintText: label,
        prefixIcon: Icon(icon, color: Colors.blue),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blue),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
}
