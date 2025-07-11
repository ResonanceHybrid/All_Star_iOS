import 'dart:io';

import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Models/student_homework_model.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marquee/marquee.dart';

class HomeworkPage extends StatefulWidget {
  const HomeworkPage({super.key});

  @override
  State<HomeworkPage> createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage> {
  CustomMethods cm = CustomMethods();

  getHomework() async {
    setState(() {
      isLoading = true;
    });
    BaseResponse data = await StudentApiMethods.getAllHomeWork();
    if (data is SuccessResponse) {
      homeworkListModel = StudentHomeworkModel.fromJson(data.data["data"]);
      homeworkList = homeworkListModel?.studenthomeworkList ?? [];

      setState(() {
        isLoading = false;
      });
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something Went Wrong";
      setState(() {
        isLoading = false;
      });
    }
  }

  String errorMessage = "";
  StudentHomeworkModel? homeworkListModel;
  List<StudentHomework> homeworkList = [];
  bool isLoading = false;

  List<File> imageList = [];

  @override
  void initState() {
    super.initState();
    getHomework();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppbarWithDrawerAndAction(
        context,
        title: "Homework",
      ),
      body: Stack(
        children: [
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                )
              : errorMessage != ""
                  ? Center(
                      child: Text(errorMessage),
                    )
                  : homeworkList.isEmpty
                      ? const Center(
                          child: Text('Homework not available.'),
                        )
                      : ListView(
                          children: [
                            ListView.builder(
                              itemCount: homeworkList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                StudentHomework useData = homeworkList[index];
                                return StudentHomeworkListCard(
                                  item: useData,
                                  uploadModel: uploadModel,
                                );
                              },
                            ),
                          ],
                        ),
        ],
      ),
    );
  }

  submitHomework(List<File> imageList, int homeworkId) async {
    Navigator.pop(context);
    cm.loadingAlertDialog();
    BaseResponse data =
        await StudentApiMethods.uploadHomework(imageList, homeworkId);
    if (data is SuccessResponse) {
      if (!mounted) return;
      imageList.clear();
      Navigator.pop(context);
      cm.showSnackBar(context, "Homework submitted successfully", Colors.green);
    } else if (data is ErrorResponse) {
      if (!mounted) return;
      Navigator.pop(context);
      cm.showSnackBar(
          context, data.message ?? "Something went wrong", Colors.red);
    }
  }

  Widget normalContainer(
      IconData icon, Color iconColor, String text, bool marque) {
    return ContainerWidgetWithGradient(
      radius: 10,
      gradient: const LinearGradient(
        colors: [
          Color.fromARGB(255, 251, 233, 216),
          Color.fromARGB(255, 240, 113, 35),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1.0],
      ),
      child: Column(
        children: [
          Icon(icon, size: 26, color: iconColor),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 20,
            child: !marque
                ? Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.white, fontSize: 12),
                  )
                : Marquee(
                    velocity: 20,
                    text: text,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void uploadModel(BuildContext context, StudentHomework useData,
      List<File> imageList) async {
    await showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(builder: (context, setState) {
            return Theme(
              data: ThemeData(
                  dialogBackgroundColor: Theme.of(context).canvasColor),
              child: Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    imageList.isNotEmpty
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 150,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    ...imageList.map((e) {
                                      return Stack(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 5),
                                            padding: const EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            width: 150,
                                            child: Image.file(e),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                color: AppColors.mainColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  imageList.removeAt(0);
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await submitHomework(imageList, useData.id);
                                },
                                child: Container(
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                      child: Text("Submit Homework",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ))),
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColors.mainColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                  ),
                                  onPressed: () async {
                                    final pickedFile = await ImagePicker()
                                        .pickMultiImage(
                                            imageQuality: 100,
                                            maxHeight: 1000,
                                            maxWidth: 1000);
                                    List<XFile> xfilePick = pickedFile;

                                    if (xfilePick.isNotEmpty) {
                                      for (var i = 0;
                                          i < xfilePick.length;
                                          i++) {
                                        imageList.add(File(xfilePick[i].path));
                                      }
                                      setState(() {});
                                    }
                                  },
                                  child: Text(
                                    "Add Images",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            );
          });
        });
  }
}

class StudentHomeworkListCard extends StatelessWidget {
  const StudentHomeworkListCard({
    super.key,
    required this.item,
    required this.uploadModel,
  });

  final StudentHomework item;
  final void Function(
          BuildContext context, StudentHomework useData, List<File> imageList)
      uploadModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 8.r,
            spreadRadius: 2.r,
            offset: const Offset(4, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.55.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 0.8.sw,
                            child: Text(
                              "${item.subjectName} ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textLightDarkColorGrey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Due on: ${item.homeworkSubmissionDate.toString().split(' ').first}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLightDarkColorGrey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.w,
                ),
                Center(
                  child: Text(
                    item.description ?? "N/A",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.mainColor.withOpacity(0.8),
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 8.w,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    Get.toNamed(AppPages.studenthomeworkview, arguments: {
                      "homeworkFiles": item.homeworkFiles,
                      "description": item.description,
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 12.h),
                    height: 50.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[400]!),
                          right: BorderSide(color: Colors.grey[400]!),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_red_eye_rounded,
                          size: 16.r,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "View",
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLightDarkColorGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    uploadModel(context, item, []);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(top: 12.h),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(color: Colors.grey[400]!),
                        right: BorderSide(color: Colors.grey[400]!),
                        top: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_file_rounded,
                          size: 16.r,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "Upload",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLightDarkColorGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    Get.toNamed(AppPages.studentHomeworkDownload, arguments: {
                      "homeworkFiles": item.homeworkFiles,
                    });
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(top: 12.h),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(color: Colors.grey[400]!),
                        right: BorderSide(color: Colors.grey[400]!),
                        top: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download_rounded,
                          size: 16.r,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "Download",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLightDarkColorGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    Get.toNamed(AppPages.studentSubmittedHomework,
                        arguments: item.id);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.only(top: 12.h),
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 16.r,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "Submitted",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLightDarkColorGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
