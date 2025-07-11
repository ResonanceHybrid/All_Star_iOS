import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/Utils/constants.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/Utils/local_storage.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/config/translations/strings_enum.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/widgets/student/bg_button.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:all_star_learning/widgets/student/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePasswordFirstTimePage extends StatefulWidget {
  const ChangePasswordFirstTimePage({super.key});

  @override
  State<ChangePasswordFirstTimePage> createState() =>
      _ChangePasswordFirstTimePageState();
}

class _ChangePasswordFirstTimePageState
    extends State<ChangePasswordFirstTimePage> {
  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? selectedSchool;

  bool isObscure = false;
  final _formKey = GlobalKey<FormState>();
  Map userDetails = {};

  getUserDetails() async {
    var details = LocalStorageMethods.getUserDetails();
    if (details != null) {
      userDetails = details;
    }
  }

  updatePassword() async {
    cm.loadingAlertDialog();
    // print(userDetails["data"]["id"]);
    BaseResponse data = await ApiMethods.updatePassword(
        userId: userDetails["data"]["id"], password: passwordController.text);
    if (data is SuccessResponse) {
      Get.back();
      userDetails["data"]["first_time_login"] = false;
      LocalStorageMethods.saveUserDetails(userDetails);
      if (userDetails["data"]["role"] == "student") {
        Get.offAllNamed(AppPages.studentNavigation);
        if (!mounted) return;
        cm.showSnackBar(context, "Password Updated successfully", Colors.green);
      } else if (userDetails["data"]["role"] == "teacher") {
        Get.offAllNamed(AppPages.teacherNavigation);
      }
    } else if (data is ErrorResponse) {
      Get.back();
      if (!mounted) return;
      cm.showSnackBar(
          context, data.message ?? "Something went wrong", Colors.red);
    }
  }

  CustomMethods cm = CustomMethods();

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
                      15.0), // set the bottom-left border radius
                  bottomRight: Radius.circular(
                      15.0), // set the bottom-right border radius
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ContainerWidget(
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red.withOpacity(0.2),
                          ),
                          child: const Text(
                            "Please, Change your password before proceed. Thank you! (Minimum 8 characters)\n कृपया, अगाडि बढ्नु अघि आफ्नो पासवर्ड परिवर्तन गर्नुहोस्। धन्यवाद!",
                            textAlign: TextAlign.center,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      PasswordFieldWidget(
                        label: Strings.newPassword,
                        controller: passwordController,
                        isObscure: isObscure,
                        icon: Icon(
                          Icons.key,
                          size: 27.sp,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50.sp,
                        child: Bgbutton(
                            label: Strings.updatePassword,
                            textColour: Colors.white,
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                updatePassword();
                              }
                            },
                            bg: AppColors.mainColor,
                            fontsize: 18.sp),
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
            top: 30,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(top: 30.sp, left: 10.sp),
                padding: EdgeInsets.all(5.sp),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 30.sp,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
