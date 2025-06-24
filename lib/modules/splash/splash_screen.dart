import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/splash/onboarding.dart';
import 'package:german_room/student_repo/customer_repo.dart';
import 'package:german_room/router/app_pages.dart';
import 'package:german_room/router/app_router.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splshscreen extends StatefulWidget {
  const Splshscreen({super.key});

  @override
  State<Splshscreen> createState() => _SplshscreenState();
}

class _SplshscreenState extends State<Splshscreen> {
  bool checked = false;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      checked = (token != null && token != '');
      if (checked) {
        ProfileModel? profileModel = await CustomerRepo().getCustomerProfile();
        if (profileModel != null) {
          AppRouter.toPage(context, AppPages.BottomNavBarPage, arguments: {
            'profileModel': profileModel,
          });
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Onbonding(),
            ),
          );
        }

        // } else {
        //   TeacherHomeModel? infoModel = await TeacherRepo().getHomeInfo();
        //   TeacherProfileModel teacherProfileModel =
        //       await TeacherRepo().getCustomerProfile();
        //   if (infoModel != null) {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => TeacherBottomBar(
        //           infoModel: infoModel,
        //           teacherProfileModel: teacherProfileModel,
        //         ),
        //       ),
        //     );
        //   }
        // }
        // } else {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const Onbonding(),
        //     ),
        //   );
        // }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Onbonding(),
          ),
        );
      }
    });
    // Timer(
    //   const Duration(seconds: 2),
    //   () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const Onbonding(),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Image.asset(
        "assets/images/splash.png",
        height: 844.h,
        width: 390.w,
        fit: BoxFit.fill,
      ),
    );
  }
}
