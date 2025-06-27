import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_room/modules/bottombar/screen/extension.dart/detail_screen.dart';
import 'package:german_room/student_models/schedule_model.dart';
import 'package:german_room/student_repo/mycourse_repo.dart';
import 'package:german_room/utils/widget/custom_dialog.dart';
import 'package:intl/intl.dart';
import 'package:german_room/modules/bottombar/utils.dart';
import 'package:german_room/student_repo/customer_repo.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key, required this.type});
  final int type;
  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  late final ValueNotifier<List<ScheduleModel>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late List<ScheduleModel> _listLichHoc;
  final Map<DateTime, List<ScheduleModel>> _events = {};
  final Set<String> _loadedMonths = {};
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _listLichHoc = [];
    _selectedEvents = ValueNotifier(_getEventsForRange(
        DateTime(_focusedDay.year, _focusedDay.month, 1),
        DateTime(_focusedDay.year, _focusedDay.month + 1, 0)));
    _fetchEventsForMonth(_focusedDay);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  Future<void> _fetchEventsForMonth(DateTime date) async {
    final key = '${date.year}-${date.month.toString().padLeft(2, '0')}';
    if (_loadedMonths.contains(key)) return;

    final start = DateTime(date.year, date.month, 1);
    final end = DateTime(date.year, date.month + 1, 0);

    final fetchedEvents = await CustomerRepo().getScheduleList(
      DateFormat('dd-MM-yyyy').format(start),
      DateFormat('dd-MM-yyyy').format(end),
    );
    if (fetchedEvents.isEmpty) return;
    setState(() {
      for (final e in fetchedEvents) {
        final day = DateTime(
            e.createdDate.year, e.createdDate.month, e.createdDate.day);
        _events.putIfAbsent(day, () => []).add(e);
      }
      _loadedMonths.add(key);
      if (_selectedDay != null) {
        _selectedEvents.value = _events[_selectedDay!] ?? [];
      }
    });
  }

  Future<void> getSchedule(
      {required String dayStart, required String dayEnd}) async {
    _listLichHoc = await CustomerRepo().getScheduleList(dayStart, dayEnd);
    _selectedEvents.value = _listLichHoc;
  }

  List<ScheduleModel> _getEventsForDay(DateTime day) {
    // Implementation example
    getSchedule(
        dayStart: DateFormat('dd-MM-yyyy').format(day),
        dayEnd:
            DateFormat('dd-MM-yyyy').format(day.add(const Duration(days: 1))));
    return _listLichHoc;
  }

  List<ScheduleModel> _getEventsForRange(DateTime start, DateTime end) {
    getSchedule(
      dayStart: DateFormat('dd-MM-yyyy').format(start),
      dayEnd: DateFormat('dd-MM-yyyy').format(end),
    );
    return _listLichHoc;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: const Color(0xff296142),
      //   automaticallyImplyLeading: false,
      //   title: Center(
      //     child: Text(
      //       'Lịch học',
      //       style: defaultText18B.copyWith(
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 180.h,
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
                      bottom: 70.h,
                      left: 10.w,
                      //back button
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: (widget.type == 1)
                            ? Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                                size: 24.sp,
                              )
                            : const SizedBox(),
                      ),
                    ),
                    Positioned(
                      bottom: 70.h,
                      left: 40.w,
                      child: Text(
                        'Thời khóa biểu',
                        style: defaultText20B.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30.h,
                      left: 250.w,
                      child: Image.asset(
                        'assets/images/schedule_icon.png',
                        width: 115.w,
                        height: 92.h,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                //height: 403.h,
                width: 350.w,
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.r),
                  ),
                ),
                child: TableCalendar<ScheduleModel>(
                  locale: 'vi_VI',
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  headerStyle: HeaderStyle(titleTextStyle: defaultText16M),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: defaultText14M,
                    weekendStyle: defaultText14M.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  daysOfWeekHeight: 36.h,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: (day) {
                    final d = DateTime(day.year, day.month, day.day);
                    return _events[d] ?? [];
                  },
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, date, events) {
                      return events.isNotEmpty
                          ? _buildEventsMarkerNum(events)
                          : const SizedBox();
                    },
                  ),
                  calendarStyle: CalendarStyle(
                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: true,
                    defaultTextStyle: defaultText14M,
                    weekendTextStyle:
                        defaultText14M.copyWith(color: Colors.red),
                    todayTextStyle:
                        defaultText14M.copyWith(color: Colors.white),
                  ),
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                    _fetchEventsForMonth(focusedDay);
                    _selectedEvents.value = _getEventsForRange(
                        DateTime(_focusedDay.year, _focusedDay.month, 1),
                        DateTime(_focusedDay.year, _focusedDay.month + 1, 0));
                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Chọn ngày trên lịch để xem lịch học',
                style: defaultText16B,
              ),
              ValueListenableBuilder<List<ScheduleModel>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return value.isEmpty
                      ? Center(
                          child: Text(
                            'Không có lịch học',
                            style: defaultText16B,
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return ItemTableCalender(
                              model: value[index],
                            );
                          },
                        );
                },
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      }),
    );
  }
}

Widget _buildEventsMarkerNum(List events) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [buildCalendarDayMarker(backColor: main1Color)]);
}

AnimatedContainer buildCalendarDayMarker({
  required Color backColor,
}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: backColor,
    ),
    width: 5.w,
    height: 5.h,
  );
}

class ItemTableCalender extends StatefulWidget {
  final ScheduleModel model;
  const ItemTableCalender({super.key, required this.model});

  @override
  State<ItemTableCalender> createState() => _ItemTableCalenderState();
}

class _ItemTableCalenderState extends State<ItemTableCalender> {
  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DetaiLessonModel listExcercise = await MycourseRepo().getDetailSchedule(
          checkinOffId: widget.model.checkinOffId,
          typeLearn: widget.model.typeLearn,
          meetingId: widget.model.meetingId,
        );
        pushWithoutNavBar(
          context,
          MaterialPageRoute(
            builder: ((context) => DetailScreen(
                  detailLesson: listExcercise,
                )),
          ),
        );
      },
      child: _isLoading
          ? SizedBox(
              height: 136.h,
              width: 343.w,
              child: Center(
                child: SizedBox(
                  width: 40.w,
                  height: 40.h,
                  child: const CircularProgressIndicator(),
                ),
              ),
            )
          : Container(
              margin: EdgeInsets.only(
                  top: 16.h, bottom: 10.h, left: 16.w, right: 16.w),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              width: 343.w,
              //height: 136.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 79, 107, 92),
                    blurRadius: 16,
                    spreadRadius: 0,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Container(
                        //width: 90.w,
                        //height: 90.h,
                        decoration: BoxDecoration(
                          color: main2Color,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.r),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              widget.model.createdDate.day.toString(),
                              style: defaultText16B.copyWith(
                                  color: Colors.white, fontSize: 24.sp),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Text(
                              '  Tháng ${widget.model.createdDate.month}  ',
                              style: defaultText16B.copyWith(
                                  color: Colors.white, fontSize: 24.sp),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.model.courseName,
                            style: defaultText18B,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            widget.model.courseAlias,
                            style: defaultText18B,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Buổi học:    ',
                          style: defaultText16M,
                          children: [
                            TextSpan(
                                text: widget.model.buoiHoc,
                                style:
                                    defaultText16B.copyWith(color: main1Color)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Bắt đầu:     ',
                          style: defaultText16M,
                          children: [
                            TextSpan(
                                text: DateFormat('kk:mm– dd/MM/yyyy')
                                    .format(widget.model.timeStart),
                                style:
                                    defaultText16B.copyWith(color: main1Color)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Kết thúc:    ',
                          style: defaultText16M,
                          children: [
                            TextSpan(
                                text: DateFormat('kk:mm – dd/MM/yyyy')
                                    .format(widget.model.timeEnd),
                                style:
                                    defaultText16B.copyWith(color: main1Color)),
                          ],
                        ),
                      ),
                      widget.model.customerLeaveReason == null
                          ? const SizedBox()
                          : Text(
                              'Lịch sử nghỉ học \nLý do: ${widget.model.customerLeaveReason}',
                              style: defaultText14M.copyWith(
                                  color: const Color(0xffED1C24)),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  (widget.model.createdDate.isBefore(DateTime.now()))
                      ? const SizedBox()
                      : Row(
                          children: [
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                (widget.model.customerLeaveReason == null)
                                    ? showDialog(
                                        context: context,
                                        builder: (context) =>
                                            LeaveRequestDialog(
                                          checkinOffId: widget.model
                                              .meetingCustomerZoomGoogleOfflineId,
                                          lichhoc: DateFormat(
                                                  'kk:mm– dd/MM/yyyy')
                                              .format(widget.model.timeStart),
                                          onConfirm: () {
                                            setState(() {
                                              widget.model.customerLeaveReason =
                                                  'Chọn lại ngày này để xem lý do xin nghỉ';
                                            });
                                          },
                                        ),
                                      )
                                    : showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CancelLeaveReqDialog(
                                          checkinOffId: widget.model
                                              .meetingCustomerZoomGoogleOfflineId,
                                          lichhoc: DateFormat(
                                                  'kk:mm– dd/MM/yyyy')
                                              .format(widget.model.timeStart),
                                          onConfirm: () {
                                            setState(() {
                                              widget.model.customerLeaveReason =
                                                  null;
                                            });
                                          },
                                          mettingId:
                                              widget.model.meetingId ?? '',
                                        ),
                                      );
                              },
                              child: Container(
                                height: 29.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  color:
                                      widget.model.customerLeaveReason == null
                                          ? sub2Color
                                          : const Color(0xffED1C24),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    widget.model.customerLeaveReason == null
                                        ? 'Xin nghỉ'
                                        : 'Hủy xin nghỉ',
                                    style: defaultText14B.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
    );
  }
}
