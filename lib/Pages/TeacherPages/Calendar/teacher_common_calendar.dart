import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as c;

class TeacherCommonCalendarPage extends StatefulWidget {
  const TeacherCommonCalendarPage({super.key});

  @override
  State<TeacherCommonCalendarPage> createState() =>
      _TeacherCommonCalendarPageState();
}

class _TeacherCommonCalendarPageState extends State<TeacherCommonCalendarPage> {
  CustomMethods cm = CustomMethods();
  @override
  void initState() {
    super.initState();
    getEvents();
  }

  String error = '';
  bool isLoadingEvents = true;

  getEvents() async {
    isLoadingEvents = true;
    BaseResponse data = await StudentApiMethods.getEvents();
    if (data is SuccessResponse) {
      calendarData = data.data["data"];

      List keys = calendarData.keys.toList();
      List days = [];
      for (int i = 0; i < keys.length; i++) {
        months.add(calendarData[keys[i]]);
        days.add(calendarData[keys[i]]);
      }
      for (int i = 0; i < days.length; i++) {
        List keys = days[i]["days"].keys.toList();

        for (int j = 0; j < keys.length; j++) {
          totalDayList.add(days[i]["days"][keys[j]]);
          eventList = totalDayList
              .where((element) => element["events"].length > 0)
              .toList();
        }
      }
    } else if (data is ErrorResponse) {
      error = data.message ?? "Something went wrong";
    }
    setState(() {
      isLoadingEvents = false;
    });
  }

  Map<String, dynamic> calendarData = {};

  List months = [];

  List totalDayList = [];

  var currentMonth = c.NepaliDateTime.now().month;

  List eventList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppbarWithDrawerAndAction(context),
      //drawer:.const StudentDrawerWidget(),
      body: Column(
        children: [
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: isLoadingEvents
                ? const ContainerWidget(
                    child: SizedBox(
                        height: 340,
                        child: Center(
                          child: CircularProgressIndicator(),
                        )))
                : error != ''
                    ? ContainerWidget(
                        child: SizedBox(
                            height: 340,
                            child: Center(child: Text(error))))
                    : ContainerWidget(
                        radius: 8.r,
                        padding: 5,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                              onSurface: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                              surface: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                              secondary: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                              onSecondary: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                              error: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                              onError: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!,
                            ),
                          ),
                          child: c.CalendarDatePicker(
                            initialDate: c.NepaliDateTime.now(),
                            firstDate: c.NepaliDateTime(2000, 01, 01),
                            lastDate: c.NepaliDateTime(2100, 12, 30),
                            onDisplayedMonthChanged: (time) {
                              setState(() {
                                currentMonth = time.month;
                              });
                            },
                            onDateChanged: (date) {
                              var usedate = date.toString().split(" ")[0];
                              totalDayList
                                          .where((element) =>
                                              element["date"] == usedate)
                                          .first["events"]
                                          .length ==
                                      0
                                  ? () {}
                                  : () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            //show event details
                                            return AlertDialog(
                                                contentPadding:
                                                    EdgeInsets.zero,
                                                title: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    CachedNetworkImage(
                                                        height: 80,
                                                        errorWidget: (c,
                                                                d, e) =>
                                                            const Icon(Icons
                                                                .error),
                                                        imageUrl: totalDayList.firstWhere((element) =>
                                                                element[
                                                                    "date"] ==
                                                                usedate)["image"] ??
                                                            ""),
                                                    ...totalDayList
                                                        .where((element) =>
                                                            element[
                                                                "date"] ==
                                                            usedate)
                                                        .first["events"]
                                                        .map(
                                                          (e) => e ==
                                                                  "null"
                                                              ? const SizedBox()
                                                              : Container(
                                                                  margin: const EdgeInsets
                                                                      .all(
                                                                      8),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          Theme.of(context).canvasColor,
                                                                      borderRadius: BorderRadius.circular(10)),
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .all(
                                                                        12.0),
                                                                    child:
                                                                        Text(
                                                                      e ??
                                                                          "N/A",
                                                                      style:
                                                                          Theme.of(context).textTheme.bodyMedium,
                                                                    ),
                                                                  ),
                                                                ),
                                                        )
                                                  ],
                                                ));
                                          });
                                    }();
                            },
                            selectedDayDecoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                            todayDecoration: const BoxDecoration(
                              gradient: AppColors.mainGradient,
                              shape: BoxShape.circle,
                            ),
                            dayBuilder: (c.NepaliDateTime p0) {
                              var date = p0.toString().split(" ")[0];
                              return Container(
                                margin: const EdgeInsets.all(2),
                                decoration:
      
                                    // totalDayList
                                    //             .where((element) =>
                                    //                 element['date'] == date)
                                    //             .first["image"] ==
                                    //         null
                                    //     ? BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(10),
                                    //         shape: BoxShape.rectangle,
                                    //         color: totalDayList
                                    //                 .where((element) =>
                                    //                     element["date"] == date &&
                                    //                     element["is_holiday"] ==
                                    //                         1)
                                    //                 .isNotEmpty
                                    //             ? AppColors.mainColor
                                    //             : Colors.transparent)
                                    //     :
                                    // BoxDecoration(
                                    //     borderRadius:
                                    //         BorderRadius.circular(5),
                                    //     shape: BoxShape.rectangle,
                                    //     image: DecorationImage(
                                    //       image:
                                    //           CachedNetworkImageProvider(
                                    //               totalDayList
                                    //                   .where((element) =>
                                    //                       element[
                                    //                           'date'] ==
                                    //                       date)
                                    //                   .first["image"]),
                                    //     ),
                                    //     color: totalDayList
                                    //             .where((element) =>
                                    //                 element["date"] ==
                                    //                     date &&
                                    //                 element["is_holiday"] ==
                                    //                     1)
                                    //             .isNotEmpty
                                    //         ? AppColors.mainColor
                                    //         : Colors.transparent),
      
                                    BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                ),
                                // color: totalDayList
                                //         .where((element) =>
                                //             element["date"] ==
                                //                 date &&
                                //             element["is_holiday"] ==
                                //                 1)
                                //         .isNotEmpty
                                //     ? AppColors.mainColor
                                //     : Colors.transparent),
                                child: Center(
                                  child: Text(
                                    p0.day.toString(),
                                    // totalDayList
                                    //             .where((element) =>
                                    //                 element['date'] ==
                                    //                 date)
                                    //             .first["image"] ==
                                    //         null
                                    //     ? p0.day.toString()
                                    //     : "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: totalDayList
                                                .where((element) =>
                                                    element["date"] ==
                                                        date &&
                                                    element["is_holiday"] ==
                                                        1)
                                                .isNotEmpty
                                            ? AppColors.mainColor
                                            : Colors.black),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
          ),
          isLoadingEvents
              ? const SizedBox()
              : error != ''
                  ? const SizedBox()
                  : eventList
                          .where((e) =>
                              c.NepaliDateTime.parse(e["date"]).month ==
                              currentMonth)
                          .isEmpty
                      ? const SizedBox()
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                ...eventList
                                    .where((e) =>
                                        c.NepaliDateTime.parse(e["date"])
                                            .month ==
                                        currentMonth)
                                    .map((e) {
                                  return Column(
                                    children: [
                                      SizedBox(height: 10.h),
                                      eventWidget(e),
                                      SizedBox(height: 10.h),
                                      const Divider(
                                        thickness: 1,
                                        color: Colors.grey,
                                      )
                                    ],
                                  );
                                })
                              ],
                            ),
                          ),
                        )
        ],
      ),
    );
  }

  Widget eventWidget(eventdata) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 15,
            ),
            decoration: BoxDecoration(
              color: eventdata["is_holiday"] == 1
                  ? AppColors.mainColor
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  c.NepaliDateTime.parse(eventdata["date"]).day.toString(),
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: eventdata["is_holiday"] == 1
                          ? Colors.white
                          : Colors.black),
                ),
                Text(
                    c.NepaliDateFormat.MMMM()
                        .format(c.NepaliDateTime.parse(eventdata["date"]))
                        .toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: eventdata["is_holiday"] == 1
                            ? Colors.white
                            : Colors.black))
              ],
            ),
          ),
        ),
        SizedBox(width: 10.w),
        // Container(
        //   width: 5,
        //   height: 50,
        //   margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        //   color: eventdata["is_holiday"] == 1 ? AppColors.mainColor : Colors.grey,
        // ),
        Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...eventdata["events"].map(
                  (e) => Column(
                    children: [
                      Text(
                        e ?? "N/A",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: eventdata["is_holiday"] == 1
                                  ? AppColors.mainColor
                                  : Colors.grey.shade700,
                            ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ],
    );
  }
}
