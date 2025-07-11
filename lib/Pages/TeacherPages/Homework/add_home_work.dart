import 'dart:io';

import 'package:all_star_learning/Controllers/homework_controller.dart';
import 'package:all_star_learning/Models/Search/class_model.dart';
import 'package:all_star_learning/Models/Search/section_model.dart';
import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Models/teacher_subject_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/teacher/bg_button_teacher.dart';
import 'package:all_star_learning/widgets/teacher/search_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class AddHomeworkPage extends StatefulWidget {
  const AddHomeworkPage({super.key});

  @override
  State<AddHomeworkPage> createState() => _AddHomeworkPageState();
}

class _AddHomeworkPageState extends State<AddHomeworkPage> {
  TextEditingController homeworkController = TextEditingController();
  File? photo;
  List<File> selectedImages = [];
  ImagePicker picker = ImagePicker();
  Future getImages() async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  CustomMethods cm = CustomMethods();
  String? selectedSubject;
  String? selectedClass;
  String? selectedSection;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateContorller = TextEditingController();

  @override
  void initState() {
    super.initState();
    startDateController.text =
        NepaliDateFormat("yyyy-MM-dd").format(NepaliDateTime.now());
    endDateContorller.text = NepaliDateFormat("yyyy-MM-dd")
        .format(NepaliDateTime.now().add(const Duration(days: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        final sc = Get.put(TeacherAddHomeworkController());
        sc.refreshFunction();
      },
      child: Scaffold(
        appBar: cm.getAppBarWithTitle(
          context,
          "Add Home Work",
        ),
        //drawer:.const TeacherDrawer(),
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            GetBuilder<TeacherAddHomeworkController>(
              init: TeacherAddHomeworkController(),
              builder: (sc) {
                List<ClassModel> classList = sc.classesValue;
                List<SectionModel> sectionList = sc.sectionsValue;
                List<TeacherSubjectModel> subjectList = sc.teacherSubjectsValue;
                // bool isLoadingClasses = sc.isClassLoadingValue;
                // bool isLoadingSections = sc.isSectionLoadingValue;
                // bool isLoadingSubjects = sc.isSubjectLoadingValue;
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TDropdownWidget(
                      //     label: "Class",
                      //     data: classList,
                      //     isLoading: isLoadingClasses,
                      //     hintText: "Select Class",
                      //     value: selectedClass,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         selectedClass = value;
                      //         selectedSection = null;
                      //         selectedSubject = null;
                      //       });
                      //       sc.loadSections(selectedClass!);
                      //     }),
                      SearchDropDown(
                          value: selectedClass,
                          hintText: "Select Class",
                          data: classList,
                          onChanged: (value) {
                            setState(() {
                              selectedClass = value;
                              selectedSection = null;
                              selectedSubject = null;
                            });
                            sc.loadSections(selectedClass!);
                          }),
                      const SizedBox(height: 20),
              
                      // TDropdownWidget(
                      //     label: "Section",
                      //     data: sectionList,
                      //     isLoading: isLoadingSections,
                      //     hintText: "Select Section",
                      //     value: selectedSection,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         selectedSection = value;
                      //         selectedSubject = null;
                      //       });
              
                      //       sc.loadSubjectsWithId(selectedClass.toString(), selectedSection.toString());
                      //     }),
              
                      SearchDropDown(
                          hintText: "Select Section",
                          data: sectionList,
                          value: selectedSection,
                          onChanged: (value) {
                            setState(() {
                              selectedSection = value;
                              selectedSubject = null;
                            });
              
                            sc.loadSubjectsWithId(selectedClass.toString(),
                                selectedSection.toString());
                          }),
              
                      const SizedBox(height: 20),
              
                      // TDropdownWidget(
                      //     label: "Subject",
                      //     data: subjectList,
                      //     isLoading: isLoadingSubjects,
                      //     value: selectedSubject,
                      // hintText: "Select Subject",
                      // onChanged: (value) {
                      //   setState(() {
                      //     selectedSubject = value;
                      //   });
                      // }),
                      Text(
                        "Select Subject",
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.textDarkColorGrey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      SizedBox(height: 8.h),
                      DropdownButtonFormField(
                        itemHeight: 48.0,
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          errorStyle: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.red),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0.h, horizontal: 10.0.w),
                          border: const OutlineInputBorder(),
                          hintStyle:
                              TextStyle(fontFamily: "Lexend", fontSize: 12.sp),
                          filled: true,
                          enabled: false,
                          fillColor: Colors.grey.shade200,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.r),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.r),
                            borderSide: const BorderSide(
                              color: Colors
                                  .red, // Set the error border color to amber
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4.r),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        value: selectedSubject,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: subjectList.map((TeacherSubjectModel value) {
                          return DropdownMenuItem<String>(
                            value: value.id.toString(),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: subjectList.indexOf(value) != 0 ? BorderSide(
                                    color: AppColors.colorsGrey300,
                                  ) : BorderSide.none,
                                )
                              ),
                              child: Text(
                                value.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: AppColors.textDarkColorGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSubject = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
              
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select File",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: AppColors.textDarkColorGrey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black45,
                              ),
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () {
                                getImages();
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                border: InputBorder.none,
                                hintText: "Attach File",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      // color: AppColors.mainColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                suffixIcon: const Icon(
                                  Icons.upload_file,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
              
                      selectedImages.isEmpty
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: selectedImages.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: SizedBox(
                                                        child: Image.file(
                                                          selectedImages[index],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    width: 2),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                    spreadRadius: 0,
                                                    blurRadius: 6,
                                                    offset: Offset(0,
                                                        4), // sets position of shadow
                                                  ),
                                                ],
                                              ),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: Image.file(
                                                selectedImages[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: -2,
                                            right: 10,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  selectedImages
                                                      .removeAt(index);
                                                });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
              
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Type Homework",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: AppColors.textDarkColorGrey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                )),
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                                hintText: "Type Homework...",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    ),
                              ),
                              autofocus: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Required field *";
                                }
                                return null;
                              },
                              maxLines: 10,
                              minLines: 8,
                              controller: homeworkController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: BgbuttonTeacher(
                              label: "Save Homework",
                              textColour: Colors.white,
                              onPress: () async {
                                await addHomeWork();
                              },
                              bg: AppColors.mainColor,
                              fontsize: 16),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  clearData() {
    selectedClass = null;
    selectedSection = null;
    selectedSubject = null;
    startDateController.clear();
    endDateContorller.clear();
    homeworkController.clear();
    selectedImages.clear();
    setState(() {});
  }

  addHomeWork() async {
    if (selectedClass == null) {
      CustomMethods().showSnackBar(context, "Please select class", Colors.red);
      return;
    }
    if (selectedSection == null) {
      CustomMethods()
          .showSnackBar(context, "Please select section", Colors.red);
      return;
    }
    if (selectedSubject == null) {
      CustomMethods()
          .showSnackBar(context, "Please select subject", Colors.red);
      return;
    }
    if (startDateController.text.isEmpty) {
      CustomMethods()
          .showSnackBar(context, "Please select starting date", Colors.red);
      return;
    }
    if (endDateContorller.text.isEmpty) {
      CustomMethods()
          .showSnackBar(context, "Please select submission date", Colors.red);
      return;
    }

    if (selectedImages.isEmpty && homeworkController.text.isEmpty) {
      CustomMethods().showSnackBar(
          context, "Please select images Image or Type Homework", Colors.red);
      return;
    }
    CustomMethods().loadingAlertDialog();

    BaseResponse response = await ApiMethods.addHomework(
      classId: selectedClass!,
      sectionId: selectedSection!,
      subjectId: selectedSubject!,
      homeworkDate: startDateController.text,
      homeworkSubmissionDate: endDateContorller.text,
      description: homeworkController.text,
      images: selectedImages,
    );

    if (response is SuccessResponse) {
      if (!mounted) return;
      Navigator.pop(context);
      CustomMethods().showSnackBar(context,
          response.data ?? "HomeWork Added Successfully", Colors.green);
      clearData();
    } else {
      if (!mounted) return;
      Navigator.pop(context);
      CustomMethods().showSnackBar(
          context, response.message ?? "Something Went Wrong", Colors.red);
    }
  }
}
