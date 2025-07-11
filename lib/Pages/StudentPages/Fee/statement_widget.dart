import 'package:all_star_learning/Models/fee_model.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';

import '../../../Models/base_response_model.dart';
import '../../../Resources/student_api_methods.dart';
import '../../../widgets/student/container_widget.dart';

class StatementWidget extends StatelessWidget {
  final Datum e;
  final bool highlight;
  const StatementWidget(this.e, {super.key, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      hasShadow: false,
      borderColor: Theme.of(context).highlightColor,
      radius: 10,
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: e.type == "invoice"
                        ? highlight ? Colors.red.shade300 : Colors.red.shade100
                        : highlight ? Colors.green.shade300 : Colors.green.shade100,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Text(
                      e.type == "invoice"
                      ? "Due"
                      : "Paid",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    e.date,
                    style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                  ),
                ],
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rs. ${e.totalAmount}",
                    style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    e.type.capitalizeFirst!,
                    style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          Material(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                color: Theme.of(context).dividerColor,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: InkWell(
                onTap: () => _getOnTap(
                  context,
                  e.id, 
                  e.type,
                  e.totalAmount.toString(),
                  e.date,
                ),
                child: Text(
                  "View Details",
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  _getOnTap(BuildContext context, int id, String type, String total, String date) async {
    showDialog(
      context: context,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    BaseResponse response = await StudentApiMethods.studentFeesDetails(id, type);
    if (response is SuccessResponse) {
      var data = response.data;
      if (!context.mounted) return;
      Navigator.pop(context);
      showDialog(
        barrierColor: Colors.black.withOpacity(0.70),
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: Theme.of(context).canvasColor,
            ),
            child: Dialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: type == "invoice" 
                    ? [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date,
                              style: Theme.of(context)
                                .textTheme
                                .titleSmall!,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, 
                              icon: const Icon(CupertinoIcons.xmark),
                            )
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fee Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontSize: 20),
                            ),
                            Text(
                              "Amount",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontSize: 20),
                            )
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                        ...data["data"].map((e) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e["fee_type"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontSize: 16),
                                  ),
                                  Text(
                                    "Rs. ${e["total_amount"]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontSize: 16),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 15,
                                color: data["data"].indexOf(e) == data["data"].length - 1
                                  ? Colors.black 
                                  : Colors.red,
                                thickness: 0.5,
                              ),
                            ],
                          );
                        }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 20),
                            ),
                            Text(
                              "Rs. $total",
                              style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 20),
                            )
                          ],
                        ),
                      ] 
                    : [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date,
                              style: Theme.of(context)
                                .textTheme
                                .titleSmall!,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              }, 
                              icon: const Icon(CupertinoIcons.xmark),
                            )
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Fee Details",
                              style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 20),
                            ),
                            Text(
                              "Amount",
                              style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 20),
                            )
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 0.5,
                          color: Colors.red,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pre Amount",
                              style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 16),
                            ),
                            Text(
                              "Rs. ${data["pre_amount"]}",
                              style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 15,
                          color: Colors.red,
                          thickness: 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Paid Amount",
                              style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontSize: 16,
                                  color: Colors.green
                                    .withOpacity(0.8),
                              ),
                            ),
                            Text(
                              "Rs. ${data["amount_paid"]}",
                              style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(
                                  fontSize: 16,
                                  color: Colors.green
                                      .withOpacity(0.8),
                                ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 15,
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Due Balance",
                              style: Theme.of(context)
                                .textTheme
                                .headlineSmall!,
                            ),
                            Text(
                              "Rs. ${data["balance_due"]}",
                              style: Theme.of(context)
                                .textTheme
                                .headlineSmall!,
                            )
                          ],
                        ),
                      ],
                ),
              ),
            ),
          );
        },
      );
    } else if (response is ErrorResponse) {
      if (!context.mounted) return;
      Navigator.pop(context);
      CustomMethods().showSnackBar(
        context,
        response.message ?? "Something went wrong",
        Colors.red,
      );
    }
  }
}