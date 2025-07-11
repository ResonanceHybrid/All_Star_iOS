import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:flutter/material.dart' hide CalendarDatePicker;
import 'package:nepali_date_picker/nepali_date_picker.dart' as c;
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';

class NepaliEventCalendar extends StatefulWidget {
  const NepaliEventCalendar({super.key});

  @override
  State<NepaliEventCalendar> createState() => _NepaliEventCalendarState();
}

class _NepaliEventCalendarState extends State<NepaliEventCalendar> {
  final c.NepaliDateTime selectedDate = c.NepaliDateTime.now();
  @override
  Widget build(BuildContext context) {
    return CalendarDatePickerWidget();
  }
}

/// Calendar Picker Example
class CalendarDatePickerWidget extends StatelessWidget {
  final ValueNotifier<NepaliDateTime> _selectedDate =
      ValueNotifier(NepaliDateTime.now());
  Widget eventWidget(context, eventdata) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
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
                  eventdata.date.day.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.white),
                ),
                Text(NepaliDateFormat.MMM().format(eventdata.date),
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
                        "Total Classes",
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

  /// Events
  final List<Event> events = [
    Event(date: NepaliDateTime.now(), eventTitles: ['Today 1', 'Today 2']),
    Event(
        date: NepaliDateTime.now().add(const Duration(days: 30)),
        eventTitles: ['Holiday 1', 'Holiday 2']),
    Event(
        date: NepaliDateTime.now().subtract(const Duration(days: 5)),
        eventTitles: ['Event 1', 'Event 2']),
    Event(
        date: NepaliDateTime.now().add(const Duration(days: 8)),
        eventTitles: ['Seminar 1', 'Seminar 2']),
  ];

  CalendarDatePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        SizedBox(
          height: responsiveHeight > 800 ? 110 : 90,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ContainerWidget(
            child:
            
             CalendarDatePicker(
              initialDate: NepaliDateTime.now(),
              firstDate: NepaliDateTime(2000),
              lastDate: NepaliDateTime(2100),
              onDateChanged: (date) => _selectedDate.value = date,
              dayBuilder: (dayToBuild) {
                return Stack(
                  children: <Widget>[
                    Center(
                      child: Text(
                        NepaliUtils().language == Language.english
                            ? '${dayToBuild.day}'
                            : NepaliUnicode.convert('${dayToBuild.day}'),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    if (events
                        .any((event) => _dayEquals(event.date, dayToBuild)))
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.purple),
                        ),
                      )
                  ],
                );
              },
              selectedDayDecoration: const BoxDecoration(
                color: AppColors.mainColor,
                shape: BoxShape.circle,
              ),
              // todayDecoration: const BoxDecoration(
              //   gradient: AppColors.mainGradient,
              //   shape: BoxShape.circle,
              // ),
            ),
         
          ),
        ),
        ValueListenableBuilder<NepaliDateTime>(
          valueListenable: _selectedDate,
          builder: (context, date, _) {
            Event? event;
            events.sort((a, b) => a.date.compareTo(b.date));
            try {
              event = events.firstWhere((e) => _dayEquals(e.date, date));
            } on StateError {
              event = null;
            }

            if (event == null) {
              return const Center(
                child: Text('No Events'),
              );
            }

            return ListView.builder(
              itemCount: events.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: eventWidget(context, events[index]),
              ),
            );
          },
        ),
      ],
    );
  }

  bool _dayEquals(NepaliDateTime? a, NepaliDateTime? b) =>
      a != null &&
      b != null &&
      a.toIso8601String().substring(0, 10) ==
          b.toIso8601String().substring(0, 10);
}

///
class TodayWidget extends StatelessWidget {
  ///
  final NepaliDateTime today;

  ///
  const TodayWidget({
    super.key,
    required this.today,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  NepaliDateFormat.EEEE()
                      .format(today)
                      .substring(0, 3)
                      .toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            Text(
              NepaliDateFormat.d().format(today),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

///
class Event {
  ///
  final NepaliDateTime date;

  ///
  final List<String> eventTitles;

  ///
  Event({required this.date, required this.eventTitles});
}
