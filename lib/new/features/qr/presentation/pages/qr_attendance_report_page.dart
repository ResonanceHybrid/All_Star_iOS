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
  InAppWebViewController? webViewController;

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
        // Wrap the HTML response to prevent PDF behaviors
        htmlResponse = _wrapHtmlContent(response.data);
      });
    } else {
      // Handle error
    }
    setState(() {
      isLoading = false;
    });
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
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                      widget.sectionList
                          .firstWhere((element) =>
                              element.id.toString() == widget.selectedSection)
                          .name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                      widget.monthList
                          .firstWhere((element) =>
                              element.id.toString() == widget.selectedMonth)
                          .name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
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
                        key: ValueKey(htmlResponse
                            .hashCode), // Force rebuild when content changes
                        initialData: InAppWebViewInitialData(
                          data: htmlResponse,
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
                        onWebViewCreated: (InAppWebViewController controller) {
                          webViewController = controller;
                        },
                        onLoadStop: (controller, url) async {
                          // Additional safety measures after page load
                          await controller.evaluateJavascript(source: """
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
                          final url = navigationAction.request.url.toString();
                          if (url.contains('.pdf') || url.contains('pdf')) {
                            return NavigationActionPolicy.CANCEL;
                          }
                          return NavigationActionPolicy.ALLOW;
                        },
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
