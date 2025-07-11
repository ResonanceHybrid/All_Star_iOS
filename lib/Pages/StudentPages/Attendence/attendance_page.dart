import 'dart:developer';

import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
// import 'package:all_star_learning/new/features/qr/domain/entities/qr_attendance_type_entity.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_cubit.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_state.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:all_star_learning/widgets/teacher/search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as c;

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  CustomMethods cm = CustomMethods();
  bool isLoadingEvents = true;
  bool isLoadingBio = true;
  String error = '';
  Map<String, dynamic> calendarData = {};
  int? presentDays;
  int? absentDays;
  List months = [];
  List totalDayList = [];
  var currentMonth = c.NepaliDateTime.now().month;
  String selectedEventDetails = '';
  Map<String, dynamic>? selectedEvent;
  String bioAttendanceData = "";

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    final qrCubit = BlocProvider.of<QrCubit>(context);
    await qrCubit.getScanTypes(student: true, report: false);
    if (qrCubit.state.scanTypesEntity?.isNotEmpty == true) {
      setState(() {
        qrCubit.selectScanType(value: qrCubit.state.scanTypesEntity!.first);
      });
      await getEvents(typeID: qrCubit.state.selectedTypeEntity?.id ?? 0);
      await getBioAttendance();
    }
  }

  Future<void> getEvents({required int typeID}) async {
    setState(() {
      isLoadingEvents = true;
      error = '';
    });

    BaseResponse data = await StudentApiMethods.getEvents(typeID: typeID);
    if (data is SuccessResponse) {
      setState(() {
        calendarData = data.data["data"];
        months = [];
        totalDayList = [];
        List keys = calendarData.keys.toList();
        List days = [];
        for (int i = 0; i < keys.length; i++) {
          months.add(calendarData[keys[i]]);
          days.add(calendarData[keys[i]]);
        }
        for (var day in days) {
          List keys = day["days"].keys.toList();
          for (var key in keys) {
            totalDayList.add(day["days"][key]);
          }
        }
        var currentMonthData =
            months.firstWhere((element) => element["month_id"] == currentMonth);
        presentDays = currentMonthData["present_days"];
        absentDays = currentMonthData["absent_days"];
      });
    } else if (data is ErrorResponse) {
      setState(() {
        error = data.message ?? "Something went wrong";
      });
    }

    setState(() {
      isLoadingEvents = false;
    });
  }

  void updateSelectedEventDetails(c.NepaliDateTime date) {
    var dateString = date.toString().split(" ")[0];
    var event = totalDayList.firstWhere(
        (element) => element["date"] == dateString,
        orElse: () => null);
    setState(() {
      selectedEvent = event;
      selectedEventDetails = event != null
          ? "Date: $dateString\nType: ${event["is_present"] == 1 ? "Present" : event["is_present"] == 0 ? "Absent" : "Holiday"}"
          : 'No event details available.';
    });
  }

  Future<void> getBioAttendance() async {
    setState(() {
      isLoadingBio = true;
      error = '';
    });

    BaseResponse data = await StudentApiMethods.getBioAttendance();
    if (data is SuccessResponse) {
      setState(() {
        bioAttendanceData = data.data;
        log(bioAttendanceData);
      });
    } else if (data is ErrorResponse) {
      setState(() {
        error = data.message ?? "Something went wrong";
      });
    }

    setState(() {
      isLoadingBio = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: cm.getAppBarWithTitle(context, "Attendance"),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 4.h, bottom: 10.h),
                  child: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: AppColors.mainColor,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          "Manual",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Biometric",
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: (isLoadingEvents || isLoadingBio) 
                    ? const Center(child: CircularProgressIndicator())
                    : (error.isNotEmpty) 
                      ? Center(child: Text(error))
                      : TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _manualTab(),
                            _bioTab(),
                          ],
                        ),
                )
              ],
            )
          );
        }
      ),
    );
  }

  Widget _manualTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            child: BlocBuilder<QrCubit, QrState>(
              builder: (context, state) {
                return state.scanTypesEntity!.isEmpty
                    ? const Center(
                        child: Text(
                          "No data found",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : SearchDropDown(
                        hintText: "Select Type",
                        value: state.selectedTypeEntity!.id!.toString(),
                        data: state.scanTypesEntity!, 
                        onChanged: (value) async {
                          BlocProvider.of<QrCubit>(context).selectTypeEntity(value);
                          await getEvents(typeID: value!.id!);
                        },
                      );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 10.h, right: 8),
            child: ContainerWidget(
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary:
                        Theme.of(context).textTheme.bodyMedium!.color!,
                    onSurface:
                        Theme.of(context).textTheme.bodyMedium!.color!,
                  ),
                ),
                child: c.CalendarDatePicker(
                  initialDate: c.NepaliDateTime.now(),
                  firstDate: c.NepaliDateTime(2000, 01, 01),
                  lastDate: c.NepaliDateTime.now(),
                  onDisplayedMonthChanged: (time) {
                    setState(() {
                      currentMonth = time.month;
                      var currentMonthData = months.firstWhere(
                          (element) =>
                              element["month_id"] == currentMonth);
                      presentDays = currentMonthData["present_days"];
                      absentDays = currentMonthData["absent_days"];
                    });
                  },
                  onDateChanged: (date) {
                    updateSelectedEventDetails(date);
                  },
                  selectedDayDecoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.8),
                    shape: BoxShape.rectangle,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  todayDecoration: BoxDecoration(
                    color: const Color.fromARGB(255, 224, 211, 87)
                        .withOpacity(0.8),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  dayBuilder: (c.NepaliDateTime date) {
                    var dateString = date.toString().split(" ")[0];
                    bool isHoliday = totalDayList.any((element) =>
                        element["date"] == dateString &&
                        element["is_holiday"] == 1);
                    bool isPresent = totalDayList.any((element) =>
                        element["date"] == dateString &&
                        element["is_present"] == 1);
                    bool isAbsent = totalDayList.any((element) =>
                        element["date"] == dateString &&
                        element["is_present"] == 0);
      
                    Color backgroundColor = isHoliday
                        ? Colors.orange
                        : isPresent
                            ? Colors.green.withOpacity(0.9)
                            : isAbsent
                                ? AppColors.mainColor.withOpacity(0.8)
                                : Colors.transparent;
      
                    return Container(
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            isHoliday ? BorderRadius.circular(4) : null,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isHoliday
                                    ? backgroundColor
                                    : Colors.black,
                              ),
                            ),
                            Container(
                              width: 20,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isHoliday
                                    ? Colors.transparent
                                    : backgroundColor,
                                shape: isHoliday
                                    ? BoxShape.rectangle
                                    : BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          // Event Details
          if (selectedEvent != null && selectedEvent!["is_holiday"] == 1)
            if (selectedEvent!["events"].isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: eventWidget(selectedEvent!),
              ),
          SizedBox(height: 6.h),
          // Color Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _legendContainer(
                title: "Present",
                color: Colors.green.withOpacity(0.9),
              ),
              _legendContainer(
                title: "Absent",
                color: AppColors.mainColor.withOpacity(0.8),
              ),
              _legendContainer(
                title: "Holiday",
                color: Colors.orange,
              ),
              _legendContainer(
                title: "Today",
                color: const Color.fromARGB(255, 224, 211, 87).withOpacity(0.8),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              presentAbsentContainer(
                "Present",
                presentDays.toString(),
                Colors.green.withOpacity(0.9),
              ),
              presentAbsentContainer(
                "Absent",
                absentDays.toString(),
                AppColors.mainColor.withOpacity(0.8),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _bioTab() {
    return _webView(bioAttendanceData);
  }

  Widget _webView(String data) {
    return InAppWebView(
      initialData: InAppWebViewInitialData(
        data: data,
      ),
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
          useOnLoadResource: true,
          javaScriptEnabled: true,
          mediaPlaybackRequiresUserGesture: false,
        ),
      ),
    );
  }

  Widget _legendContainer({
    required String title,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 5),
          Text(title),
        ],
      ),
    );
  }

  Widget presentAbsentContainer(String title, String value, Color color) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.sp),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: color,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
                ),
              ),
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            ContainerWidget(
              radius: 2,
              child: Center(child: Text(value)),
            ),
          ],
        ),
      ),
    );
  }

  Widget eventWidget(Map<String, dynamic> eventData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: eventData["is_holiday"] == 1
                ? AppColors.mainColor
                : Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  c.NepaliDateTime.parse(eventData["date"]).day.toString(),
                  style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.white),
                ),
                Text(
                  c.NepaliDateFormat.MMMM()
                      .format(c.NepaliDateTime.parse(eventData["date"]))
                      .toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Container(
          width: 5,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          color: eventData["is_holiday"] == 1 
            ? AppColors.mainColor 
            : Colors.grey,
        ),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...eventData["events"].map(
                (e) => Column(
                  children: [
                    Text(
                      e ?? "N/A",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: eventData["is_holiday"] == 1
                            ? AppColors.mainColor
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
