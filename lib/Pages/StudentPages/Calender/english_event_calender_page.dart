import 'dart:developer';

import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EnglishEventCalendar extends StatefulWidget {
  const EnglishEventCalendar({super.key});

  @override
  State<EnglishEventCalendar> createState() => _EnglishEventCalendarState();
}

class _EnglishEventCalendarState extends State<EnglishEventCalendar> {
  EventDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      subject: 'Meeting',
      color: Colors.blue,
      isAllDay: false,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 1)),
      endTime: DateTime.now().add(const Duration(days: 1)),
      subject: 'Team lunch',
      color: Colors.green,
      isAllDay: true,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: -1, hours: 4)),
      endTime: DateTime.now().add(const Duration(days: -1, hours: 4)),
      subject: 'Client call',
      color: Colors.orange,
      isAllDay: false,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 3, hours: 2)),
      endTime: DateTime.now().add(const Duration(days: 3, hours: 2)),
      subject: 'Product demo',
      color: Colors.purple,
      isAllDay: false,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 4)),
      endTime: DateTime.now().add(const Duration(days: 4)),
      subject: 'Vacation',
      color: Colors.red,
      isAllDay: true,
    ));
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 6)),
      endTime: DateTime.now().add(const Duration(days: 6)),
      subject: 'Vacation',
      color: Colors.red,
      isAllDay: true,
    ));
    appointments.sort(
        (Appointment a, Appointment b) => a.startTime.compareTo(b.startTime));
    return EventDataSource(appointments);
  }

  final CalendarController _calendarController = CalendarController();
  void _handleDateTapped(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _handleAppointmentTapped(Appointment appointment) {
    // TODO: Handle the appointment tap event here.
    log('Appointment tapped: ${appointment.subject}');
  }

  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        SizedBox(
          height: responsiveHeight > 800 ? 110 : 90,
        ),
        Container(
          height: 350,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ContainerWidget(
            child: SfCalendar(
              view: CalendarView.month,
              showNavigationArrow: true,
              showDatePickerButton: true,
              showCurrentTimeIndicator: true,
              todayHighlightColor: AppColors.mainColor,
              // monthViewSettings: const MonthViewSettings(showAgenda: true),
              headerDateFormat: 'MMM yyyy',
              dataSource: _getCalendarDataSource(),
              controller: _calendarController,
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.calendarCell) {
                  _handleDateTapped(details.date!);
                } else if (details.targetElement ==
                    CalendarElement.appointment) {
                  _handleAppointmentTapped(details.appointments![0]);
                }
              },
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _getCalendarDataSource().appointments!.length,
          itemBuilder: (BuildContext context, int index) {
            Appointment appointment =
                _getCalendarDataSource().appointments![index];
            if (appointment.startTime.month != _selectedDate.month) {
              return const SizedBox.shrink();
            }
            return eventWidget(context, appointment.startTime, appointment);
          },
        ),
      ],
    );
  }

  Widget eventWidget(context, DateTime selectedDate, Appointment data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                Text(
                  data.startTime.day.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.white),
                ),
                Text(DateFormat("EEE").format(data.startTime),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white))
              ]),
            ),
          ),
          Container(
            width: 10,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: AppColors.mainColor,
          ),
          Expanded(
              flex: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        data.subject,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.mainColor),
                      ),
                      Text(
                        "3",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.mainColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        "New Year",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.mainColor),
                      ),
                      Text(
                        "Holiday",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.mainColor),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> source) {
    appointments = source;
  }
}
