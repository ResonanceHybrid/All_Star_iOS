import 'package:all_star_learning/Controllers/search_controller.dart';
import 'package:all_star_learning/Models/Search/month_model.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_cubit.dart';
import 'package:all_star_learning/new/features/qr/presentation/cubit/qr_state.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:all_star_learning/widgets/student/no_data_widget.dart';
import 'package:all_star_learning/widgets/teacher/search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentQrAttendanceReport extends StatefulWidget {
  const StudentQrAttendanceReport({super.key});

  @override
  State<StudentQrAttendanceReport> createState() =>
      _StudentQrAttendanceReportState();
}

class _StudentQrAttendanceReportState extends State<StudentQrAttendanceReport> {
  CustomMethods cm = CustomMethods();

  String? selectedMonth;

  TextEditingController dateController = TextEditingController();
  final sc = Get.put(AppSearchController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Search Attendance Report"),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          GetX<AppSearchController>(
            builder: (sc) {
              List<MonthModel> monthList = [];
              for (MonthModel month in sc.months) {
                monthList.add(month);
                if (month.isCurrentMonth == 1) {
                  break;
                }
              }
              

              if (monthList.isNotEmpty && selectedMonth == null) {
                selectedMonth = monthList
                    .firstWhere((element) => element.isCurrentMonth == 1)
                    .id
                    .toString();
              }

              return BlocBuilder<QrCubit, QrState>(
                builder: (context, qrState) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: SearchDropDown(
                                isMonth: true,
                                hintText: "Select Month",
                                data: monthList,
                                onChanged: (val) {
                                  setState(() {
                                    selectedMonth = val;
                                  });
                                },
                                value: selectedMonth,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 22.0),
                                child: KElevatedButton(
                                  label: "Search",
                                  onPressed: () {
                                    if (selectedMonth == null) {
                                      cm.showSnackBar(
                                          context, "Please select month", Colors.red);
                                      return;
                                    }
                                    BlocProvider.of<QrCubit>(context)
                                        .getStudentQrReport(
                                            monthId: int.parse(selectedMonth!));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Expanded(
                        child: qrState.isLoading
                            ? const Center(
                                child: CircularProgressIndicator())
                            : qrState.studentQrReport == null
                                ? const NoDataWidget()
                                : InAppWebView(
                                    initialData: InAppWebViewInitialData(
                                        data: qrState.studentQrReport!),
                                    initialOptions:
                                        InAppWebViewGroupOptions(
                                      crossPlatform: InAppWebViewOptions(
                                        useShouldOverrideUrlLoading: true,
                                        useOnLoadResource: true,
                                        javaScriptEnabled: true,
                                        mediaPlaybackRequiresUserGesture:
                                            false,
                                      ),
                                    ),
                                  ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
