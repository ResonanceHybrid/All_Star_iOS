import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Pages/TeacherPages/Teacher%20Notice/pdf_viewer.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/Utils/constants.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:recase/recase.dart';

import '../../../routes/app_pages.dart';

class TeacherNoticesPage extends StatefulWidget {
  final bool isFromNotification;

  const TeacherNoticesPage({super.key, required this.isFromNotification});

  @override
  State<TeacherNoticesPage> createState() => _TeacherNoticesPageState();
}

class _TeacherNoticesPageState extends State<TeacherNoticesPage> {
  bool isLoading = false;
  String errorMessage = "";
  List notices = [];

  @override
  void initState() {
    super.initState();
    getNotices();
  }

  Future<void> getNotices() async {
    setState(() {
      isLoading = true;
    });

    BaseResponse response = await ApiMethods.getNotices();

    if (response is SuccessResponse) {
      notices = response.data["data"];
    } else if (response is ErrorResponse) {
      errorMessage = response.message ?? "Something went wrong";
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMethods().getAppBarWithTitle(context, "Notices", isBack: false),
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: getNotices,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 300),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (notices.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 300),
                        child: Text("Notices not available"),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notices.length,
                      itemBuilder: (context, index) {
                        var e = notices[index];
                        return GestureDetector(
                          onTap: () {
                            expandTeacherNotice(context, e);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 12.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.18),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.notifications,
                                            color: Colors.red,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            "Notification",
                                            style: TextStyle(
                                              color: Colors.grey[400],
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        e["publish_date_bs"] ?? "",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: e["images"] == null
                                            ? 0.75.sw
                                            : 0.65.sw,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 4.w),
                                              child: Text(
                                                e["title"].toString().titleCase,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Html(
                                              data: e["description"] ?? "",
                                              style: {
                                                "body": Style(
                                                  fontSize: FontSize(14),
                                                  color: Colors.black,
                                                  maxLines: 3,
                                                  padding: HtmlPaddings.zero,
                                                ),
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (e["images"] != null)
                                        if (e["images"]["file_type"] == "pdf")
                                          IconButton(
                                            onPressed: () {
                                              Get.to(() => PdfViewPage(
                                                  pdfUrl: e["images"]["path"],
                                              ));
                                            },
                                            icon: Image.asset(kpdfIcon, scale: 3),
                                          )
                                        else
                                          SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: Image.network(
                                              e["images"]["path"],
                                            ),
                                          ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> expandTeacherNotice(BuildContext context, dynamic e) {
    return showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 80.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e["title"] ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(),
                SizedBox(height: 15.h),
                SizedBox(
                  height: e["images"] != null && e["description"] != null ? 450.h : null,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        if (e["images"] != null)
                          if (e["images"]["file_type"] == "pdf")
                            IconButton(
                              onPressed: () {
                                Get.to(() =>
                                  PdfViewPage(pdfUrl: e["images"]["path"]),
                                );
                              },
                              icon: Image.asset(kpdfIcon, scale: 3),
                            )
                          else
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppPages.fullImageViewer,
                                  arguments: {
                                    "image_path": e["images"]["path"],
                                  },
                                );
                              },
                              child: Image.network(e["images"]["path"]),
                            ),
                        const SizedBox(height: 10),
                        Html(
                          data: e["description"] ?? "",
                          style: {
                            "body": Style(
                              fontSize: FontSize(14),
                              color: Colors.black,
                            ),
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                const Divider(),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e["publish_date_bs"] ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 16, color: Colors.grey[600]),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Done",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
