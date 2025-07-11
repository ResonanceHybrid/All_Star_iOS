import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ResultDetailsPage extends StatefulWidget {
  final int resultId;

  const ResultDetailsPage({
    super.key,
    required this.resultId,
  });

  @override
  State<ResultDetailsPage> createState() => _ResultDetailsPageState();
}

class _ResultDetailsPageState extends State<ResultDetailsPage> {
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
    setState(() {
      isLoading = true;
      htmlResponse = '';
      error = '';
    });

    BaseResponse response =
        await StudentApiMethods.getExamResultDetails(widget.resultId);
    if (response is SuccessResponse) {
      setState(() {
        htmlResponse = response.data;
      });
    } else if (response is ErrorResponse) {
      setState(() {
        error = response.message ?? 'Something went wrong';
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  CustomMethods cm = CustomMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, 'Exam Report'),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : htmlResponse.isEmpty
                      ? NoDataWidget(
                          message: error,
                        )
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
