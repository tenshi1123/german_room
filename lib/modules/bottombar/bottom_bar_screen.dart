import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/schedule_screen.dart';
import 'package:german_room/modules/bottombar/screen/user_info/account_screen.dart';
import 'package:german_room/student_models/profile_model.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'screen/course_screen.dart';
import 'screen/home_screen.dart';

class Bottombar extends StatefulWidget {
  final int index;

  final ProfileModel profileModel;
  const Bottombar({
    super.key,
    required this.index,
    required this.profileModel,
  });

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.index);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        // logic
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: key1Color,
          backgroundColor: Colors.white,
          selectedLabelStyle: defaultText12M,
          fixedColor: key1Color,
          //unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy_Medium'),
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                // backgroundColor: notifire.getprimerycolor,
                icon: SvgPicture.asset(
                  _selectedIndex == 0
                      ? 'assets/icons/home_gradient.svg'
                      : 'assets/icons/home_icon.svg',
                ),
                label: 'Trang chủ'),
            BottomNavigationBarItem(
                // backgroundColor: notifire.getprimerycolor,
                icon: SvgPicture.asset(
                  _selectedIndex == 1
                      ? 'assets/icons/course_gradient.svg'
                      : 'assets/icons/course_icon.svg',
                  height: 30.h,
                ),
                label: 'Video'),
            BottomNavigationBarItem(
                // backgroundColor: notifire.getprimerycolor,
                icon: SvgPicture.asset(
                  _selectedIndex == 2
                      ? 'assets/icons/schedule_gradient.svg'
                      : 'assets/icons/schedule_icon.svg',
                  height: 30.h,
                ),
                label: 'Thời khóa biểu'),
            BottomNavigationBarItem(
              // backgroundColor: notifire.getprimerycolor,
              icon: SvgPicture.asset(
                _selectedIndex == 3
                    ? 'assets/icons/account_gradient.svg'
                    : 'assets/icons/account_icon.svg',
                height: 30.h,
                fit: BoxFit.fitHeight,
                //color: _selectedIndex == 3 ? main1Color : key1Color,
              ),
              label: 'Tài khoản',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: [
          HomeScreen(
            infomodel: widget.profileModel,
          ),
          const CourseScreen(),
          const CalenderScreen(
            type: 0,
          ),
          AccountScreen(
            profileModel: widget.profileModel,
          ),
        ][_selectedIndex],
      ),
    );
  }
}
