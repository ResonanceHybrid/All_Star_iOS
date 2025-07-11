import 'dart:developer';

import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/config/translations/strings_enum.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/constants.dart';
import 'package:all_star_learning/widgets/student/bg_button.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:all_star_learning/widgets/student/text_field_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../SelectSchool/search_school_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? selectedSchool;

  bool isObscure = false;
  final _formKey = GlobalKey<FormState>();
  bool isRememberMe = false;
  String? logo;

  @override
  void initState() {
    super.initState();
    getSchoolLogoAndName();
    getCredential();
  }

  getSchoolLogoAndName() {
    var school = LocalStorageMethods.getSchoolDetails();
    if (school != null) {
      logo = school["logo"];
      setState(() {});
    }
  }

  getCredential() async {
    var credentials = LocalStorageMethods.getCredentials();
    if (credentials != null) {
      if (credentials["rememberMe"] as bool) {
        isRememberMe = credentials["rememberMe"];
        emailController.text = credentials["email"];
        passwordController.text = credentials["password"];
      }
      setState(() {});
    }
  }

  login() async {
    CustomMethods().loadingAlertDialog();
    BaseResponse response = await ApiMethods.login(
      email: emailController.text,
      password: passwordController.text,
    );
    if (response is SuccessResponse) {
      LocalStorageMethods.saveUserDetails(
        response.data,
      );

      if (response.data["data"]["role"] != null) {
        if (response.data["data"]["role"] == "student") {
          await _generateFcmTokenAndSendToServer();
          if (!mounted) return;
          Navigator.pop(context);
          if (response.data["data"]["first_time_login"] == true) {
            Get.back();
            Get.toNamed(AppPages.changePasswordFirstTime);
          } else {
            Get.offAllNamed(AppPages.studentNavigation);
          }
        } else if (response.data["data"]["role"] == 'teacher') {
          _generateFcmTokenAndSendToServer();
          if (response.data["data"]["first_time_login"] == true) {
            Get.back();
            Get.toNamed(AppPages.changePasswordFirstTime);
          } else {
            Get.offAllNamed(AppPages.teacherNavigation);
          }
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something went wrong!")));
      }
    } else if (response is ErrorResponse) {
      if (!mounted) return;
      Navigator.pop(context);
      CustomMethods().showSnackBar(
        context,
        response.message ?? Strings.someThingWentWorng,
        Colors.red,
      );
    }
  }

  static Future<void> _generateFcmTokenAndSendToServer() async {
    try {
      var token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        if (LocalStorageMethods.getUserDetails()["data"]["role"] == "student") {
          FirebaseMessaging.instance.unsubscribeFromTopic(
              LocalStorageMethods.getSchoolDetails()["domain_name"] +
                  "-" +
                  "teacher");
        } else if (LocalStorageMethods.getUserDetails()["data"]["role"] ==
            "teacher") {
          FirebaseMessaging.instance.unsubscribeFromTopic(
              LocalStorageMethods.getSchoolDetails()["domain_name"] +
                  "-" +
                  "student");
        }
        LocalStorageMethods.setFcmToken(token);
        FirebaseMessaging.instance.subscribeToTopic(
            LocalStorageMethods.getSchoolDetails()["domain_name"] +
                "-" +
                LocalStorageMethods.getUserDetails()["data"]["role"]);
        await StudentApiMethods.uploadFCMToken(
          userId: LocalStorageMethods.getUserDetails()["data"]["id"].toString(),
          token: LocalStorageMethods.getFcmToken() ?? "",
        );
      } else {
        await Future.delayed(const Duration(seconds: 5));
        _generateFcmTokenAndSendToServer();
      }
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height;

    return Form(
      key: _formKey,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.mainGradient,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      15.0,
                    ), 
                    bottomRight: Radius.circular(
                      15.0,
                    ),
                  ),
                ),
                height: responsiveHeight * 0.5,
                width: MediaQuery.of(context)
                  .size
                  .width, // set the height of the container
              ),
            ),
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: responsiveHeight > 600
                    ? responsiveHeight * .24
                    : responsiveHeight * 0.125,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: ContainerWidget(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: logo ?? "",
                            height: 100.sp,
                          ),
                        ),
                        TextFormFieldWidget(
                          label: Strings.email,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          icon: Icon(
                            Icons.mail,
                            size: 27.sp,
                            color: Colors.black,
                          ),
                        ),
                        const Divider(),
                        PasswordFieldWidget(
                          label: Strings.password,
                          controller: passwordController,
                          isObscure: isObscure,
                          icon: Icon(
                            Icons.key,
                            size: 27.sp,
                            color: Colors.black,
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Colors.grey,
                                colorScheme: const ColorScheme.light(
                                  primary: AppColors.mainColor,
                                  secondary: AppColors.mainColor,
                                ),
                              ),
                              child: CheckboxMenuButton(
                                value: isRememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    isRememberMe = value!;
                                  });
                                  if (isRememberMe) {
                                    LocalStorageMethods.saveCredentials(
                                      isRememberMe,
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  } else {
                                    LocalStorageMethods.removeCredentials();
                                  }
                                },
                                child: Text(
                                  "Remember me",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                emailController.clear();
                                passwordController.clear();
                                Get.toNamed(AppPages.resetPassword);
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50.sp,
                          child: Bgbutton(
                            label: Strings.signIn,
                            textColour: Colors.white,
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                await login();
                              }
                            },
                            bg: AppColors.mainColor,
                            fontsize: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.sp,
                ),
                Image.asset(
                  kLoginLogoImage,
                  height: 40.sp,
                ),
              ],
            ),
            Positioned(
              top: 50,
              right: 24,
              child: GestureDetector(
                onTap: () async {
                  var response = await Get.to(
                    () => const SearchAndPaginateSchoolList());
                  if(response != null) {
                    LocalStorageMethods.removeUserDetails();
                    LocalStorageMethods.removeSchoolDetails();
                    LocalStorageMethods.removeCredentials();
                    Get.toNamed(AppPages.selectSchool, arguments: response);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.refresh,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
