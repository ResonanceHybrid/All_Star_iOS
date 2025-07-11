import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';

class StudentProfilePage extends StatefulWidget {
  final bool fromNav;
  const StudentProfilePage({super.key, required this.fromNav});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final CustomMethods cm = CustomMethods();
  String errorMessage = "";
  Map<String, dynamic> userDetails = {};
  bool isLoading = false;
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getProfileDetails();
  }

  void getProfileDetails() async {
    setState(() => isLoading = true);
    BaseResponse data = await StudentApiMethods.getProfileData();
    if (data is SuccessResponse) {
      userDetails = data.data["data"];
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something went wrong";
    }
    setState(() => isLoading = false);
  }

  Future<void> uploadImage() async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
              BaseResponse data =
                  await StudentApiMethods.uploadProfileImage(_image!);
              if (data is SuccessResponse) {
                var userdata = LocalStorageMethods.getUserDetails();
                userdata["data"]["image"] = data.data["data"]["image"] ?? "";
                LocalStorageMethods.saveUserDetails(userdata);
                if (mounted) {
                  Navigator.pop(context);
                  getProfileDetails();
                }
              } else if (data is ErrorResponse) {
                if (mounted) {
                  Navigator.pop(context);
                  cm.showSnackBar(context,
                      data.message ?? "Something went wrong", Colors.red);
                }
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height;
    log("userDetails: $userDetails");
    return Scaffold(
      appBar: !widget.fromNav
          ? cm.getAppBarWithTitle(context, "Student Profile")
          : cm.getAppbarWithDrawerAndAction(context),
      drawerEnableOpenDragGesture: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: responsiveHeight,
          child: Stack(
            children: [
              cm.getCurvedTopOnStack(context),
              Positioned(
                top: 40,
                left: 10,
                right: 10,
                child: ContainerWidget(
                  radius: 15,
                  child: SizedBox(
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userDetails["name"] ?? "",
                            style:
                                Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: AppColors.mainColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (_) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              dialogBackgroundColor:
                                  Theme.of(context).canvasColor,
                            ),
                            child: Dialog(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
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
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                        if (mounted) {
                                          Navigator.pop(context);
                                          uploadImage();
                                        }
                                      }
                                    },
                                    child: const Text("Camera"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      var data = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      if (data != null) {
                                        _image = File(data.path);
                                        if (mounted) {
                                          Navigator.pop(context);
                                          uploadImage();
                                        }
                                      }
                                    },
                                    child: const Text("Gallery"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    );
                  },
                  child: _image != null
                      ? CircleAvatar(
                          radius: 45,
                          backgroundColor: const Color(0xffFD7369),
                          child: CircleAvatar(
                            backgroundImage: FileImage(_image!),
                            radius: 40,
                          ),
                        )
                      : Stack(
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: const Color(0xffFD7369),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(userDetails[
                                        "image"] ??
                                    "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
                                radius: 40,
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
                            ),
                          ],
                        ),
                ),
              ),
              Positioned(
                top: 142,
                right: 10,
                left: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 25,
                      width: 7,
                      decoration:
                          const BoxDecoration(color: AppColors.mainColor),
                    ),
                    Container(
                      height: 25,
                      width: 7,
                      decoration:
                          const BoxDecoration(color: AppColors.mainColor),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 160,
                right: 10,
                left: 10,
                child: ContainerWidget(
                  radius: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRowWidget("Class", userDetails["class_name"] ?? ""),
                      const SizedBox(height: 20),
                      _buildRowWidget(
                          "Section", userDetails["section_name"] ?? ""),
                      const SizedBox(height: 20),
                      _buildRowWidget("Email", userDetails["email"] ?? "N/A"),
                      const SizedBox(height: 20),
                      _buildRowWidget(
                          "Adm. No", userDetails["admission_number"] ?? "N/A"),
                      const SizedBox(height: 20),
                      _buildRowWidget("House", userDetails["house"] ?? "N/A"),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 450,
                right: 10,
                left: 10,
                child: ContainerWidget(
                  radius: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRowWidget("Guardian Name", userDetails["parent_details"]?["guardian_name"] ?? ""),
                      const SizedBox(height: 20),
                      _buildRowWidget("Guardian Phone", userDetails["parent_details"]?["guardian_phone"] ?? ""),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowWidget(String left, String right) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .25,
          child: Text(
            left,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                ":",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .50,
              child: Text(
                right,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.mainColor,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
