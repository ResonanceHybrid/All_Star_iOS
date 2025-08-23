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
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
  }

  String _wrapHtmlContent(String originalHtml) {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <style>
        body { 
            margin: 0; 
            padding: 10px; 
            font-family: Arial, sans-serif; 
            background: white;
            overflow-x: auto;
        }
        * {
            -webkit-print-color-adjust: exact !important;
            color-adjust: exact !important;
        }
        @media print { 
            * { 
                display: none !important; 
            } 
        }
        /* Prevent any PDF-like styling */
        embed, object, iframe[src*=".pdf"] {
            display: none !important;
        }
    </style>
</head>
<body>
    $originalHtml
    <script>
        // Comprehensive PDF prevention
        (function() {
            // Disable all print functions
            window.print = function() { 
                console.log('Print disabled'); 
                return false; 
            };
            
            // Override PDF viewer
            if (typeof PDFViewerApplication !== 'undefined') {
                PDFViewerApplication = null;
            }
            
            // Prevent print events
            window.addEventListener('beforeprint', function(e) { 
                e.preventDefault(); 
                e.stopPropagation(); 
                return false; 
            }, true);
            
            window.addEventListener('afterprint', function(e) { 
                e.preventDefault(); 
                e.stopPropagation(); 
                return false; 
            }, true);
            
            // Disable keyboard shortcuts that might trigger print
            document.addEventListener('keydown', function(e) {
                if ((e.ctrlKey || e.metaKey) && e.keyCode === 80) { // Ctrl+P or Cmd+P
                    e.preventDefault();
                    e.stopPropagation();
                    return false;
                }
            }, true);
            
            // Remove any PDF-related elements
            document.addEventListener('DOMContentLoaded', function() {
                var pdfElements = document.querySelectorAll('embed[type="application/pdf"], object[type="application/pdf"], iframe[src*=".pdf"]');
                pdfElements.forEach(function(element) {
                    element.remove();
                });
            });
            
            // Force content type
            if (document.contentType && document.contentType.includes('pdf')) {
                document.contentType = 'text/html';
            }
        })();
    </script>
</body>
</html>
    ''';
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20.h),
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
                                      cm.showSnackBar(context,
                                          "Please select month", Colors.red);
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
                            ? const Center(child: CircularProgressIndicator())
                            : qrState.studentQrReport == null
                                ? const NoDataWidget()
                                : InAppWebView(
                                    key: ValueKey(qrState.studentQrReport
                                        .hashCode), // Force rebuild when content changes
                                    initialData: InAppWebViewInitialData(
                                      data: _wrapHtmlContent(
                                          qrState.studentQrReport!),
                                      mimeType: 'text/html',
                                      encoding: 'utf8',
                                    ),
                                    initialOptions: InAppWebViewGroupOptions(
                                      crossPlatform: InAppWebViewOptions(
                                        useShouldOverrideUrlLoading: true,
                                        useOnLoadResource: true,
                                        javaScriptEnabled: true,
                                        mediaPlaybackRequiresUserGesture: false,
                                        // Prevent default behaviors that might trigger PDF viewer
                                        supportZoom: false,
                                        transparentBackground: true,
                                      ),
                                      android: AndroidInAppWebViewOptions(
                                        // Disable built-in zoom controls
                                        builtInZoomControls: false,
                                        displayZoomControls: false,
                                        // Force HTML rendering
                                        loadWithOverviewMode: true,
                                        useWideViewPort: true,
                                        // Disable default error page
                                        disableDefaultErrorPage: true,
                                      ),
                                      ios: IOSInAppWebViewOptions(
                                        // Disable data detector types that might interfere
                                        dataDetectorTypes: [],
                                        // Disable automatic detection
                                        suppressesIncrementalRendering: false,
                                      ),
                                    ),
                                    onWebViewCreated:
                                        (InAppWebViewController controller) {
                                      webViewController = controller;
                                    },
                                    onLoadStop: (controller, url) async {
                                      // Additional safety measures after page load
                                      await controller
                                          .evaluateJavascript(source: """
                                        // Double-check print prevention
                                        window.print = function() { return false; };
                                        
                                        // Hide any PDF viewer UI elements
                                        var toolbars = document.querySelectorAll('[class*="toolbar"], [id*="toolbar"], [class*="viewer"], [id*="viewer"]');
                                        toolbars.forEach(function(toolbar) {
                                          if (toolbar.textContent.toLowerCase().includes('print') || 
                                              toolbar.textContent.toLowerCase().includes('pdf')) {
                                            toolbar.style.display = 'none';
                                          }
                                        });
                                      """);
                                    },
                                    shouldOverrideUrlLoading:
                                        (controller, navigationAction) async {
                                      // Prevent navigation that might trigger PDF viewer
                                      final url = navigationAction.request.url
                                          .toString();
                                      if (url.contains('.pdf') ||
                                          url.contains('pdf')) {
                                        return NavigationActionPolicy.CANCEL;
                                      }
                                      return NavigationActionPolicy.ALLOW;
                                    },
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
