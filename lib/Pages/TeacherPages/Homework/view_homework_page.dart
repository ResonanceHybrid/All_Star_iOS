import 'package:all_star_learning/Models/Search/homework_model.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewHomeWorkPage extends StatefulWidget {
  const ViewHomeWorkPage({
    super.key,
    required this.homeWork,
  });

  final HomeWork homeWork;

  @override
  State<ViewHomeWorkPage> createState() => _ViewHomeWorkPageState();
}

class _ViewHomeWorkPageState extends State<ViewHomeWorkPage> {
  CustomMethods cm = CustomMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(
        context,
        "Homework View Page",
      ),
      body: Stack(
        children: [
          // cm.getCurvedTopOnStack(context),
          Column(
            children: [
              Expanded(
                child: Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Homework Type
                        Text(
                          "Homework Description",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Html(
                          data: widget.homeWork.description ?? "N/A",
                        ),

                        // Text(
                        //   widget.homeWork.description ?? "N/A",
                        //   style: TextStyle(
                        //     fontSize: 14.sp,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          "Attachments",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        // Attachments
                        widget.homeWork.homeworkFiles != null &&
                                widget.homeWork.homeworkFiles!.isNotEmpty
                            ? SizedBox(
                                height: 0.5.sh,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      widget.homeWork.homeworkFiles?.length ??
                                          0,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 4.h,
                                        horizontal: 8.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 0.6.sw,
                                            child: Image.network(
                                              widget
                                                      .homeWork
                                                      .homeworkFiles![index]
                                                      .path ??
                                                  "",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          Text(
                                            widget
                                                    .homeWork
                                                    .homeworkFiles![index]
                                                    .comments ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            widget
                                                    .homeWork
                                                    .homeworkFiles![index]
                                                    .comments ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Text(
                                "No Attachments",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                        SizedBox(
                          height: 12.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
