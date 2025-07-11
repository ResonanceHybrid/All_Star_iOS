import 'dart:io';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/teacher/bg_button_teacher.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddLessonPage extends StatefulWidget {
  const AddLessonPage({super.key});

  @override
  State<AddLessonPage> createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  TextEditingController dateController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? photo;
  // File? _documentFront;
  // File? _documentBack;
  DateTime selected = DateTime.now();
  DateTime initial = DateTime(1800);
  DateTime last = DateTime(3000);
  TimeOfDay timeOfDay = TimeOfDay.now();
  Future datePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
    );

    if (date != null) {
      setState(() {
        dateController.text = date.toLocal().toString().split(" ")[0];
      });
    }
  }

  _uploadPhotoFromGallery() async {
    XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      photo = File(img.path);
      if (!mounted) return;
      Navigator.pop(context);
    }
    setState(() {});
  }

  CustomMethods cm = CustomMethods();
  String? selectedExam;
  String? selectedSubject;
  String? selectedClass;
  String? selectedSection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.teacherAppBarWithAction("Add Lesson", context),
      //drawer:.const TeacherDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   children: [
              //     Expanded(
              //       child: TDropdownWidget(
              //           label: "Class",
              //           data: const ['UKG', 'LKG', '1', '2'],
              //           hintText: "Select Class",
              //           onChanged:),
              //     ),
              //     Expanded(
              //       child: TDropdownWidget(
              //           label: "Section",
              //           data: const [
              //             'Section A',
              //             ' Section B',
              //           ],
              //           hintText: "Select Section",
              //           onChanged: () {

              //           }),
              //     ),
              //   ],
              // ),
              // TDropdownWidget(
              //     label: "Subject",
              //     data: const [
              //       'Nepali',
              //       ' English',
              //     ],
              //     hintText: "Select Subject",
              //     onChanged: () {}),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  "Lesson Plan Date",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.mainColor, fontWeight: FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () {
                  datePicker(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.deepOrangeAccent,
                          spreadRadius: 0,
                          blurRadius: 6,
                          offset: Offset(0, 4), // sets position of shadow
                        ),
                      ],
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    enabled: false,
                    controller: dateController,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.mainColor),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Select Date",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                              color: AppColors.mainColor,
                              fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  "Attach File",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.mainColor, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.deepOrangeAccent,
                        spreadRadius: 0,
                        blurRadius: 6,
                        offset: Offset(0, 4), // sets position of shadow
                      ),
                    ],
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(5)),
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    _uploadPhotoFromGallery();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(
                      Icons.upload,
                      color: AppColors.mainColor,
                    ),
                    hintText: "Choose File",
                    hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: BgbuttonTeacher(
                      label: "Search Lesson Plan",
                      textColour: Colors.white,
                      onPress: () {},
                      bg: AppColors.mainColor,
                      fontsize: 16.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
