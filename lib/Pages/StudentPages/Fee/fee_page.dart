import 'dart:developer';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Models/fee_model.dart';
import 'package:all_star_learning/Models/student_due_model.dart';
import 'package:all_star_learning/Pages/StudentPages/Fee/statement_widget.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class FeePage extends StatefulWidget {
  const FeePage({super.key});

  @override
  State<FeePage> createState() => _FeePageState();
}

class _FeePageState extends State<FeePage> {
  CustomMethods cm = CustomMethods();

  @override
  void initState() {
    super.initState();
    getFeeData();
    getDueDetails();
    getSchoolDetails();
  }

  bool isLoading = true;
  FeeModel? feeModel;
  StudentDueModel? studentDue;
  String errorMessage = "";
  String? paymentQR = "";
  Map<String, dynamic> schoolDetails = {};

  getFeeData() async {
    BaseResponse data = await StudentApiMethods.studentFeesData();
    if (data is SuccessResponse) {
      feeModel = FeeModel.fromJson(data.data);
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something went wrong";
    }
    setState(() {
      isLoading = false;
    });
  }
  
  getDueDetails() async {
    BaseResponse data = await StudentApiMethods.studentDueDetails();
    if (data is SuccessResponse) {
      studentDue = StudentDueModel.fromJson(data.data);
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something went wrong";
    }
    setState(() {
      isLoading = false;
    });
  }

  getSchoolDetails() async {
    BaseResponse data = await StudentApiMethods.schoolDetail();
    if (data is SuccessResponse) {
      paymentQR = data.data["data"][0]["payment_qr_code"];
      schoolDetails = data.data["data"][0];
      log("Apple:${data.data["data"][0]}");
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something went wrong";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Fee Details"),
      body: isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : errorMessage != ""
          ? Center(
              child: Text(errorMessage),
            )
          : Column(
              children: [
                //payments section
                Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      )
                    ]
                  ),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(5),
                      2: FlexColumnWidth(3),
                    },     
                    border: const TableBorder(
                      verticalInside: BorderSide(width: 1, color: Colors.grey),
                    ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).dividerColor)),
                        ),
                        children: ["S.N", "Particulars", "Amount"].map((e) => _cell(
                          e,
                          isHeader: true,
                          textAlign: TextAlign.center,
                          textColor: Colors.white,
                        )).toList()
                      ),
                      if(studentDue != null)
                      ...studentDue!.details.map((due) => TableRow(
                        children: [
                          _cell(
                            "${studentDue!.details.indexOf(due) + 1}",
                            textAlign: TextAlign.center,
                          ),
                          _cell(
                            due.type,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          _cell(
                            due.amount.toString(),
                            textAlign: TextAlign.end,
                            padding: const EdgeInsets.all(8.0).copyWith(right: 16.0),
                          ),
                        ]
                      )),
                      if(studentDue != null)
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(width: 1, color: Theme.of(context).dividerColor)),
                          ),
                          children: [
                            _cell(
                              ""
                            ),
                            _cell(
                              "Total Fee",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              maxLines: 2,
                            ),
                            _cell(
                              "Rs. ${studentDue!.totalAmount.toString()}",
                              textAlign: TextAlign.end,
                            )
                          ]
                        )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16, 
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      )
                    ]
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Due Amount
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${feeModel?.summary.values.last}".contains("-")
                              ? "Advance: "
                              : "Due Amount: ",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Rs. ${feeModel?.summary.values.last ?? "N/A"}",
                            style: TextStyle(
                              color: "${feeModel?.summary.values.last}".contains("-")
                                ? Colors.green
                                : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {

                            }, 
                            icon: Image.asset(
                              height: 32,
                              width: 32,
                              "assets/icons/nav/qr.png",
                              color: AppColors.mainColor,
                            )
                          ),
                          const SizedBox(width: 12.0),
                          GestureDetector(
                            onTap: () async {
                              await showQR();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                gradient: AppColors.mainGradient,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // width: 150.w,
                              // height: 80.h,
                              child: Center(
                                child: Text(
                                  "Pay Now",
                                  style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600
                                    ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      ..._buttons.map((button) => Expanded(
                        flex: button == "Bank Details" ? 4 : 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Material(
                            color: Colors.grey.shade400,
                            clipBehavior: Clip.antiAlias,
                            elevation: 1,
                            shadowColor: Colors.grey.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () async {
                                  switch (button) {
                                    case "School QR":
                                      await showQR();
                                      break;
                                    case "Bank Details":
                                      await showBankDetails();
                                      break;
                                    case "Statements":
                                      Get.toNamed(AppPages.statements);
                                      break;
                                    
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
                                  child: Text(
                                    button,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),
                // Scrollable middle section
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await getFeeData();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: feeModel?.data.length ?? 0,
                      itemBuilder: (context, index) {
                        var e = feeModel!.data[index];
                        return StatementWidget(e, highlight: true,);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _cell(String value, {
    bool isHeader = false, 
    TextAlign? textAlign,
    int? maxLines, 
    TextOverflow? overflow,
    Color? textColor,
    EdgeInsets? padding,
  }) {
    return TableCell(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Text(
          value,
          style: TextStyle(
            fontSize: isHeader ? 16 : 14,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.w600,
            color: textColor ?? Colors.black,
          ),
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
        ),
      ),
    );
  }

  final List<String> _buttons = [
    "School QR",
    "Bank Details",
    "Statements",
  ];

  showQR() async {
    await getSchoolDetails();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 5,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Scan to Pay",
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share(paymentQR!);
                      }, 
                      icon: const Icon(Icons.share),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppPages.fullImageViewer, arguments: {"image_path": paymentQR!});
                  },
                  child: Container(
                    height: 300.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: paymentQR == null
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              paymentQR!,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showBankDetails() async {
    await getSchoolDetails();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 5,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bank Details",
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Share.share(schoolDetails["bank_details"]);
                      }, 
                      icon: const Icon(Icons.share),
                    )
                  ],
                ),
                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 20),
                // Bank details
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      GestureDetector(
                        onTap: () async {
                          // Copy to clipboard
                          ClipboardData data = ClipboardData(
                              text: schoolDetails["bank_details"]);
                          await Clipboard.setData(data);
                          Get.back();
                          cm.showSnackBar(
                            context,
                            "Bank Name copied to clipboard",
                            Colors.green,
                          );
                        },
                        child: Text(
                          "${schoolDetails["bank_details"]}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    "Close",
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
