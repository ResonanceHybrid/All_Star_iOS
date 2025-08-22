import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MarksLedgerPage extends StatefulWidget {
  final String? classId;
  final String? sectionId;
  final String? examId;
  final String? ledgerType;
  final String? className;
  final String? sectionName;
  final String? examName;
  final String? ledgerTypeName;

  const MarksLedgerPage({
    super.key,
    this.classId,
    this.sectionId,
    this.examId,
    required this.ledgerType,
    required this.className,
    required this.sectionName,
    required this.examName,
    required this.ledgerTypeName,
  });

  @override
  State<MarksLedgerPage> createState() => _MarksLedgerPageState();
}

class _MarksLedgerPageState extends State<MarksLedgerPage> {
  ApiMethods apiMethods = ApiMethods();
  String htmlResponse = '';
  bool isLoading = false;
  String error = '';
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    getMarksLedger();
  }

  Future<void> getMarksLedger() async {
    if (widget.classId == null ||
        widget.sectionId == null ||
        widget.examId == null ||
        widget.ledgerType == null) return;
    setState(() {
      isLoading = true;
      htmlResponse = '';
      error = '';
    });

    BaseResponse response = await apiMethods.getMarksLedger(
      widget.ledgerType.toString(),
      widget.classId.toString(),
      widget.sectionId.toString(),
      widget.examId.toString(),
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
      appBar: cm.getAppBarWithTitle(context, "Marks Ledger", isBack: true),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.ledgerTypeName ?? "N/A",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.className ?? "N/A",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.sectionName ?? "N/A",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    widget.examName ?? "N/A",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 10.0),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : htmlResponse.isEmpty
                    ? const NoDataWidget()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: InAppWebView(
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
                          onWebViewCreated:
                              (InAppWebViewController controller) {
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
          ),
        ],
      ),
    );
  }
}

class MarksLedgerTypeModel {
  final String id;
  final String name;

  const MarksLedgerTypeModel({
    required this.id,
    required this.name,
  });
}
