import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:german_room/modules/bottombar/utils.dart';
import 'package:german_room/teacher/teacher_model/home_teacher_model.dart';
import 'package:german_room/teacher/teacher_model/teacher_class_model.dart';
import 'package:german_room/teacher/teacher_repo/teacher_class_repo.dart';
import 'package:german_room/teacher/teacher_repo/teacher_repo.dart';
import 'package:german_room/teacher_modules/teacher_class/teacher_detail_lesson.dart';
import 'package:german_room/utils/constants/color.dart';
import 'package:german_room/utils/constants/styles.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ValueNotifier<List<LichHocModel>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late List<LichHocModel> _listLichHoc;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _listLichHoc = [];
    _selectedEvents = ValueNotifier(_getEventsForRange(
        DateTime(_focusedDay.year, _focusedDay.month, 1),
        DateTime(_focusedDay.year, _focusedDay.month + 1, 0)));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  Future<void> getSchedule(
      {required String dayStart, required String dayEnd}) async {
    _listLichHoc = await TeacherRepo().getLichDay(day1: dayStart, day2: dayEnd);
    _selectedEvents.value = _listLichHoc;
  }

  List<LichHocModel> _getEventsForDay(DateTime day) {
    // Implementation example
    getSchedule(
        dayStart: DateFormat('yyyy-MM-dd').format(day),
        dayEnd: DateFormat('yyyy-MM-dd').format(day));
    return _listLichHoc;
  }

  // List<ScheduleModel> _getEventLoad(DateTime day) {
  //   List<ScheduleModel> test = [
  //     ..._listFullLich.where((e) => e.createdDate.day == day.day)
  //   ];
  //   return test;
  // }

  List<LichHocModel> _getEventsForRange(DateTime start, DateTime end) {
    getSchedule(
      dayStart: DateFormat('yyyy-MM-dd').format(start),
      dayEnd: DateFormat('yyyy-MM-dd').format(end),
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
      appBar: AppBar(
        backgroundColor: const Color(0xff273D8C),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Lịch học',
            style: defaultText18B.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 403.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: main2Color.withValues(alpha: 0.24),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.r),
                    ),
                  ),
                  child: TableCalendar<LichHocModel>(
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
                    // eventLoader: _getEventLoad,
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
                    },
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Lịch học của bạn',
                  style: defaultText16B,
                ),
                ValueListenableBuilder<List<LichHocModel>>(
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
          ),
        );
      }),
    );
  }
}

Widget _buildEventsMarkerNum(List events) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [buildCalendarDayMarker(backColor: Colors.black)]);
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
  final LichHocModel model;
  const ItemTableCalender({super.key, required this.model});

  @override
  State<ItemTableCalender> createState() => _ItemTableCalenderState();
}

class _ItemTableCalenderState extends State<ItemTableCalender> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        List<DiemDanhHSModel> listDiemDanh = await TeacherClassRepo()
            .getListDiemDanh(
                courseScheduleId: widget.model.courseScheduleId,
                id: widget.model.id);
        List<ExamModel> listBaiTap = await TeacherClassRepo().getlistExam(
            courseScheduleId: widget.model.courseScheduleId,
            id: widget.model.id,
            type: 1);
        List<ExamModel> listDeThi = await TeacherClassRepo().getlistExam(
            courseScheduleId: widget.model.courseScheduleId,
            id: widget.model.id,
            type: 2);
        if (!context.mounted) return;
        pushWithoutNavBar(
            context,
            MaterialPageRoute(
                builder: (context) => LessonDetail(
                      listDiemDanh: listDiemDanh,
                      title:
                          "${widget.model.name} ${widget.model.dayOfWeek} ${DateFormat('dd/MM/yyyy').format(widget.model.day)}",
                      listBaiTap: listBaiTap,
                      listDeThi: listDeThi,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 10.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff163065).withValues(alpha: 0.12),
              spreadRadius: 0,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 15.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff00AEEF),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.model.day.day.toString(),
                        style: defaultText16B.copyWith(
                            color: Colors.white, fontSize: 26.sp),
                      ),
                      Text(
                        'Tháng ${widget.model.day.month}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Text(widget.model.name, style: defaultText18B),
                    ),
                    const SizedBox(height: 5),
                    Text(widget.model.dayOfWeek, style: defaultText14M),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            RichText(
              text: TextSpan(
                text: 'Phòng học : ',
                style: defaultText16M,
                children: [
                  TextSpan(
                      text: widget.model.phongHoc,
                      style: defaultText16B.copyWith(
                          color: const Color(0xff00AEEF))),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            RichText(
              text: TextSpan(
                text: 'Chi nhánh : ',
                style: defaultText16M,
                children: [
                  TextSpan(
                      text: widget.model.coSo,
                      style: defaultText16B.copyWith(
                          color: const Color(0xff00AEEF))),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
