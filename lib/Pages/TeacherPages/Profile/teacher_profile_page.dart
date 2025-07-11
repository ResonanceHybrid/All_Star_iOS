import 'dart:io';

import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/bg_button.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recase/recase.dart';

class TeacherProfilePage extends StatefulWidget {
  final bool? fromNav;
  const TeacherProfilePage({super.key, this.fromNav = false});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage> {
  bool checkZoomValue = false;
  bool checkTeamsValue = false;

  CustomMethods cm = CustomMethods();

  final picker = ImagePicker();
  File? _image;
  Map userDetails = LocalStorageMethods.getUserDetails();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Teacher Profile"),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) {
                          return StatefulBuilder(builder: (context, setState) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                  dialogBackgroundColor:
                                      Theme.of(context).canvasColor),
                              child: Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 45,
                                      child: ContainerWidget(
                                        padding: 5,
                                        color: Colors.white,
                                        radius: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Change Profile Image",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          var data = await picker.pickImage(
                                              source: ImageSource.camera);
                                          if (data != null) {
                                            _image = File(data.path);
                                            if (!mounted) return;
                                            Navigator.pop(context);
                                            uploadImage();
                                          }
                                        },
                                        child: const Text("Camera")),
                                    TextButton(
                                        onPressed: () async {
                                          XFile? data = await picker.pickImage(
                                              source: ImageSource.gallery);
                                          if (data != null) {
                                            _image = File(data.path);
                                            if (!mounted) return;
                                            Navigator.pop(context);
                                            uploadImage();
                                          }
                                        },
                                        child: const Text("Gallery")),
                                  ],
                                ),
                              ),
                            );
                          });
                        });
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: const Color(0xffFD7369),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(userDetails["data"]
                                  ["image"] ??
                              "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
                          radius: 55,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.edit,
                                color: AppColors.mainColor, size: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        userDetails["data"]["name"] ?? "N/A",
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: const Color.fromARGB(255, 246, 75, 98),
                                  fontSize: 20.sp,
                                ),
                      ),
                      Text(
                        userDetails["data"]["email"] ?? "N/A",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 13.sp,
                            ),
                      ),
                      const SizedBox(height: 15),
                      const SizedBox(height: 20),
                      rowWidget(
                        "Role",
                        userDetails["data"]["role"].toString().titleCase,
                      ),
                      const SizedBox(height: 20),
                      rowWidget("Designation",
                          "${userDetails["data"]["designation"] ?? 'N/A'}"),
                      const SizedBox(height: 20),
                      rowWidget("Department",
                          "${userDetails["data"]["department"] ?? 'N/A'}"),
                      const SizedBox(height: 20),
                      rowWidget("Date of Joining",
                          "${userDetails["data"]["joining_date"] ?? 'N/A'}"),
                      const SizedBox(height: 20),
                      rowWidget("Phone No.",
                          "${userDetails["data"]["mobile"] ?? 'N/A'}"),
                      const SizedBox(height: 20),
                      rowWidget(
                          "DOB", "${userDetails["data"]["dob_bs"] ?? 'N/A'}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   child: Center(
          //     child: CircleAvatar(
          //       radius: 55,
          //       backgroundColor: Theme.of(context).cardColor,
          //       child: CircleAvatar(
          //         radius: 50,
          //         backgroundImage: NetworkImage(userDetails["data"]["image"] ?? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
          //       ),
          //     ),
          //   ),
          // ),

          // cm.getCurvedTopOnStack(context),
          // Container(
          //   color: Colors.blue,
          //   child: ListView(
          //     physics: const BouncingScrollPhysics(),
          //     children: [
          //       Stack(
          //         children: [

          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  rowWidget(String left, String right) {
    return Row(
      children: [
        SizedBox(
          width: 130.w,
          child: Text(
            left,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.textColorGrey),
          ),
        ),
        const SizedBox(width: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                ":",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: AppColors.textColorDimGrey),
                textAlign: TextAlign.start,
              ),
            ),
            Text(
              right,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.textColorGrey),
            ),
          ],
        ),
      ],
    );
  }

  SizedBox topicsWidget(BuildContext context, icon, title) {
    return SizedBox(
      height: 111,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Select online class tool",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: AppColors.mainColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/zoom.png',
                                  ),
                                  Checkbox(
                                    shape: const CircleBorder(),
                                    value: checkZoomValue,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        checkZoomValue = newValue!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                Image.asset('assets/images/teams.png'),
                                Checkbox(
                                  shape: const CircleBorder(),
                                  value: checkTeamsValue,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      checkTeamsValue = newValue!;
                                    });
                                  },
                                ),
                              ],
                            )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: SizedBox(
                            width: 210,
                            height: 45,
                            child: Bgbutton(
                                label: "Done",
                                textColour: Colors.white,
                                onPress: () {},
                                bg: AppColors.mainColor,
                                fontsize: 17),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: ContainerWidget(
            radius: 10,
            child: SizedBox(
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: AppColors.mainColor,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  uploadImage() async {
    showDialog(
        context: context,
        builder: (_) {
          return Theme(
            data: Theme.of(context)
                .copyWith(dialogBackgroundColor: Theme.of(context).canvasColor),
            child: AlertDialog(
              title:
                  const Text('Are you sure you want to change profile image?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No')),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (_) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          });
                      BaseResponse data =
                          await ApiMethods.uploadProfileImageTeacher(_image!);
                      if (data is SuccessResponse) {
                        var userdata = LocalStorageMethods.getUserDetails();
                        userdata["data"]["image"] =
                            data.data["data"]["image"] ?? "";
                        LocalStorageMethods.saveUserDetails(userdata);
                        if (!mounted) return;
                        Navigator.pop(context);
                        // await getProfileDetails();
                      } else if (data is ErrorResponse) {
                        if (!mounted) return;
                        Navigator.pop(context);
                        cm.showSnackBar(context,
                            data.message ?? "Something went wrong", Colors.red);
                      }
                      userDetails = LocalStorageMethods.getUserDetails();
                      setState(() {});
                    },
                    child: const Text('Yes')),
              ],
            ),
          );
        });
  }
}
