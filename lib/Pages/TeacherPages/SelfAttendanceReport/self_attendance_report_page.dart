import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/app_static_colors.dart';

class TeacherSelfAttendanceReportPage extends StatefulWidget {

  const TeacherSelfAttendanceReportPage({super.key});

  @override
  State<TeacherSelfAttendanceReportPage> createState() => _TeacherSelfAttendanceReportPageState();
}

class _TeacherSelfAttendanceReportPageState extends State<TeacherSelfAttendanceReportPage> {
  ApiMethods apiMethods = ApiMethods();
  String? biometricRes;
  String? manualRes;
  bool isLoading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    getAttendanceReport(type: "biometric");
    getAttendanceReport(type: "manual");
  }

  Future<void> getAttendanceReport({String? type}) async {
    setState(() {
      isLoading = true;
      if(type == "biometric") {
        biometricRes = null;
      } else {
        manualRes = null;
      }
      error = '';
    });

    BaseResponse response = await apiMethods.getTeacherAttendanceReport(type: type);
    if (response is SuccessResponse) {
      setState(() {
        if(type == "biometric") {
          biometricRes = response.data;
        } else {
          manualRes = response.data;
        }
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
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        getAttendanceReport(type: "manual");
        getAttendanceReport(type: "biometric");
      },
      child: Scaffold(
        appBar: cm.getAppBarWithTitle(context, 'Your Attendance'),
        body: DefaultTabController(
          length: 2,
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(top: 24.h, bottom: 16.h),
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
                    child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : biometricRes == null || manualRes == null
                          ? const NoDataWidget()
                          : TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _webView(manualRes!),
                                _webView(biometricRes!),
                              ],
                            ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
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
}
