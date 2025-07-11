import 'package:all_star_learning/Models/Search/homework_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/teacher/select_nepali_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

import '../../../widgets/common_widgets/settings_popup_button.dart';

class HomeworkListPage extends StatefulWidget {
  final bool fromNav;
  const HomeworkListPage({super.key, this.fromNav = false});

  @override
  State<HomeworkListPage> createState() => _HomeworkListPageState();
}

class _HomeworkListPageState extends State<HomeworkListPage> {
  CustomMethods cm = CustomMethods();

  TextEditingController startDateController = TextEditingController();

  bool isLoading = false;
  HomeworkListModel? homeworkListModel;
  List<HomeWork> homeworkListData = [];

  getHomeworkData({bool isRefresh = false}) async {
    if (startDateController.text.isEmpty) {
      cm.showSnackBar(context, "Please Select End Date", Colors.red);
      return;
    }
    if (!isRefresh) {
      setState(() {
        isLoading = true;
      });
    }

    var data =
        await ApiMethods.getHomeworkByDate(startDate: startDateController.text);
    if (data is SuccessResponse) {
      homeworkListModel = HomeworkListModel.fromJson(data.data);
      homeworkListData = homeworkListModel?.homeworkList ?? [];
      setState(() {
        isLoading = false;
      });
    } else if (data is ErrorResponse) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      cm.showSnackBar(
          context, data.message ?? "Something Went Wrong", Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    startDateController.text = NepaliDateTime.now().format("yyyy-MM-dd");
    getHomeworkData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        getHomeworkData(isRefresh: true);
      },
      child: Scaffold(
        appBar: !widget.fromNav
          ? cm.getAppBarWithTitle(
              context,
              "Homework List Page",
            )
          : AppBar(
              title: const Text(
                "Homework List Page",
              ),
              actions: const [
                SettingsPopupButton(),
              ],
              flexibleSpace: Container(
                decoration: const BoxDecoration(gradient: AppColors.mainGradient),
              ),
            ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      child: Text(
                                        "Date",
                                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                          color: AppColors.textDarkColorGrey,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    SelectNepaliDate(
                                      controller: startDateController,
                                      hintText: "Select Date",
                                      isTo: true,
                                      onDateAdded: () async {
                                        if (startDateController
                                            .text.isNotEmpty) {
                                          await getHomeworkData();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        isLoading
                            ? Column(
                                children: [
                                  SizedBox(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.30),
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              )
                            : homeworkListData.isEmpty
                                ? Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.30),
                                      Center(
                                        child: Text(
                                          "No Data Found",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: AppColors.mainColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    width: 1.sw,
                                    height: 0.64.sh,
                                    child: ListView.builder(
                                      itemCount: homeworkListData.length,
                                      itemBuilder: (context, index) {
                                        return TeacherHomeworkListCard(
                                          item: homeworkListData[index],
                                          deleteFunction: () async {
                                            await getAlertDialog(
                                                context,
                                                homeworkListData[index]
                                                        .id ??
                                                    -1);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getAlertDialog(BuildContext context, int homeworkId) {
    return showDialog(
        context: context,
        builder: (_) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: 0.8.sw,
              height: 0.3.sh,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Are you sure to delete?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                deleteHomeWork(homeworkId);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.kRedColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "Yes",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 100,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.kGreenColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "No",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  deleteHomeWork(int homeWorkId) async {
    cm.loadingAlertDialog();
    BaseResponse data = await ApiMethods.deleteHomework(homeWorkId: homeWorkId);
    if (data is SuccessResponse) {
      getHomeworkData();
      if (!mounted) return;
      Navigator.pop(context);
    } else if (data is ErrorResponse) {}
  }
}

class TeacherHomeworkListCard extends StatelessWidget {
  const TeacherHomeworkListCard({
    super.key,
    required this.item,
    required this.deleteFunction,
  });

  final HomeWork item;
  final Future<Null> Function() deleteFunction;

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
                      width: 0.6.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 0.8.sw,
                            child: Text(
                              "${item.subjectName ?? "N/A"} | ${item.className ?? "N/A"}-${item.sectionName ?? "N/A"}",
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
                      item.homeworkDate.toString().split(' ').first,
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
                Text(
                  item.description ?? "N/A",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mainColor.withOpacity(0.8),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 8.w,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Submissions: ${item.submission}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textLightDarkColorGrey,
                      ),
                    ),
                    Text(
                      "Total Students: ${item.students?.length}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textLightDarkColorGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    Get.toNamed(AppPages.teacherHomeworkView, arguments: item);
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
                    child: Row(
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
                    Get.toNamed(
                      AppPages.homeworkEvaluatePage,
                      arguments: item.id,
                    );
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          size: 16.r,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "Evaluate",
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
                    await deleteFunction();
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_forever_rounded,
                          size: 16.r,
                          color: AppColors.mainColor,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "Delete",
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
