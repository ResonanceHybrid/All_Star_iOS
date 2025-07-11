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
                  child: Text(widget.sectionName ?? "N/A",
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
                  child: Text(widget.examName ?? "N/A",
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
                          initialData: InAppWebViewInitialData(
                            data: htmlResponse,
                          ),
                          initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(),
                          ),
                          onWebViewCreated:
                              (InAppWebViewController controller) {},
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
