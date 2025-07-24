import 'dart:developer';
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
import 'package:permission_handler/permission_handler.dart';
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

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    }

    final result = await permission.request();
    return result == PermissionStatus.granted;
  }

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      // Check and request permission
      Permission permission =
          source == ImageSource.camera ? Permission.camera : Permission.photos;

      if (!await _requestPermission(permission)) {
        if (mounted) {
          cm.showSnackBar(
              context,
              "Permission denied to access ${source == ImageSource.camera ? 'camera' : 'gallery'}",
              Colors.red);
        }
        return;
      }

      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        if (mounted) {
          Navigator.pop(context);
          uploadImage();
        }
      }
    } catch (e) {
      log("Error picking image: $e");
      if (mounted) {
        Navigator.pop(context);
        cm.showSnackBar(
            context, "Failed to pick image. Please try again.", Colors.red);
      }
    }
  }

  Future<void> _showImagePickerDialog() async {
    await showDialog(
      context: context,
      builder: (_) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Theme.of(context).canvasColor,
          ),
          child: Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 45,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Change Profile Image",
                        style:
                            Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  onPressed: () async {
                    await _pickImageFromSource(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera"),
                ),
                TextButton.icon(
                  onPressed: () async {
                    await _pickImageFromSource(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo_library),
                  label: const Text("Gallery"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> uploadImage() async {
    if (_image == null) return;

    showDialog(
      context: context,
      builder: (_) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogBackgroundColor: Theme.of(context).canvasColor,
          ),
          child: AlertDialog(
            title: const Text('Are you sure you want to change profile image?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    BaseResponse data =
                        await ApiMethods.uploadProfileImageTeacher(_image!);
                    if (data is SuccessResponse) {
                      var userdata = LocalStorageMethods.getUserDetails();
                      userdata["data"]["image"] =
                          data.data["data"]["image"] ?? "";
                      LocalStorageMethods.saveUserDetails(userdata);
                      if (mounted) {
                        Navigator.pop(context);
                        userDetails = LocalStorageMethods.getUserDetails();
                        setState(() {});
                        cm.showSnackBar(context,
                            "Profile image updated successfully", Colors.green);
                      }
                    } else if (data is ErrorResponse) {
                      if (mounted) {
                        Navigator.pop(context);
                        cm.showSnackBar(context,
                            data.message ?? "Something went wrong", Colors.red);
                      }
                    }
                  } catch (e) {
                    log("Error uploading image: $e");
                    if (mounted) {
                      Navigator.pop(context);
                      cm.showSnackBar(
                          context,
                          "Failed to upload image. Please try again.",
                          Colors.red);
                    }
                  }
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
    );
  }

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
                  //onTap: _showImagePickerDialog,
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
                          onBackgroundImageError: (exception, stackTrace) {
                            log("Error loading profile image: $exception");
                          },
                        ),
                      ),
                      // Positioned(
                      //   top: 0,
                      //   right: 0,
                      //   child: Container(
                      //     height: 30,
                      //     width: 30,
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).cardColor,
                      //       shape: BoxShape.circle,
                      //     ),
                      //     child: const Center(
                      //       child: Icon(
                      //         Icons.edit,
                      //         color: AppColors.mainColor,
                      //         size: 15,
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
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
        ],
      ),
    );
  }

  Widget rowWidget(String left, String right) {
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
}
