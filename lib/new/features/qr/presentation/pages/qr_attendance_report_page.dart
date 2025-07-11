import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/month_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class QRAttendanceReportsPage extends StatefulWidget {
  final String? selectedMonth;
  final String? selectedClass;
  final String? selectedSection;
  final List<ClassModel> classList;
  final List<SectionModel> sectionList;
  final List<MonthModel> monthList;
  final List<int> attendanceTypes;

  const QRAttendanceReportsPage({
    super.key,
    required this.selectedMonth,
    required this.selectedClass,
    required this.selectedSection,
    required this.classList,
    required this.sectionList,
    required this.monthList,
    required this.attendanceTypes,
  });

  @override
  State<QRAttendanceReportsPage> createState() =>
      _QRAttendanceReportsPageState();
}

class _QRAttendanceReportsPageState extends State<QRAttendanceReportsPage> {
  ApiMethods apiMethods = ApiMethods();
  String htmlResponse = '';
  bool isLoading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    getAttendanceReport();
  }

  Future<void> getAttendanceReport() async {
    if (widget.selectedClass == null ||
        widget.selectedSection == null ||
        widget.selectedMonth == null) return;
    setState(() {
      isLoading = true;
      htmlResponse = '';
      error = '';
    });

    BaseResponse response = await apiMethods.getQRAttendanceReport(
      widget.selectedClass.toString(),
      widget.selectedSection.toString(),
      widget.selectedMonth.toString(),
      widget.attendanceTypes,
    );
    if (response is SuccessResponse) {
      setState(() {
        htmlResponse = response.data;
      });
    } else {
      // Handle error
    }
    setState(() {
      isLoading = false;
    });
  }

  CustomMethods cm = CustomMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QR Attendance Report",
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Get.toNamed(AppPages.qrAttendanceReportSearchPage, arguments: {
              "route": AppPages.teacherQRAttendanceReport,
            });
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 0,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.classList
                        .firstWhere((element) =>
                            element.id.toString() == widget.selectedClass)
                        .name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                      widget.sectionList
                          .firstWhere((element) =>
                              element.id.toString() ==
                              widget.selectedSection)
                          .name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                      widget.monthList
                          .firstWhere((element) =>
                              element.id.toString() == widget.selectedMonth)
                          .name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 10.0),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : htmlResponse.isEmpty
                    ? const NoDataWidget()
                    : InAppWebView(
                        initialData:
                            InAppWebViewInitialData(data: htmlResponse),
                        initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                            useShouldOverrideUrlLoading: true,
                            useOnLoadResource: true,
                            javaScriptEnabled: true,
                            mediaPlaybackRequiresUserGesture: false,
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class AttendanceReportDropdown extends StatelessWidget {
  const AttendanceReportDropdown({
    super.key,
    required this.context,
    required this.hintText,
    required this.data,
    required this.onChanged,
    required this.value,
  });

  final BuildContext context;

  final String hintText;
  final List<dynamic> data;
  final Function(String? p1) onChanged;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).cardColor,
      ),
      child: Flexible(
        flex: 2,
        child: DropdownButtonFormField(
          value: value,
          icon: const SizedBox(),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          hint: Text(
            hintText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColors.mainColor, fontWeight: FontWeight.w600),
          ),
          alignment: Alignment.center,
          items: data.map((dynamic value) {
            return DropdownMenuItem<String>(
              value: value.id.toString(),
              child: Text(
                value.name,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: AppColors.mainColor, fontWeight: FontWeight.w600),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
