import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/new/core/common/custom_form_filed.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/base_response_model.dart';
import '../../../Resources/api_methods.dart';
import '../../../config/translations/strings_enum.dart';
import '../../../routes/app_pages.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final CustomMethods cm = CustomMethods();
  bool isPhoneNumber = false;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  sendOTP() async {
    CustomMethods().loadingAlertDialog();
    BaseResponse response = await ApiMethods.sendOTP(
      email: isPhoneNumber ? null : emailController.text.trim(),
      phoneNumber: !isPhoneNumber ? null : phoneController.text.trim(),
    );
    if (response is SuccessResponse) {
      if (!mounted) return;
      Navigator.pop(context);
      if(isPhoneNumber) {
        Get.toNamed(
          AppPages.otpVerification, 
          arguments: {
            "phone_number": phoneController.text.trim(),
            "user_id": response.data["data"]["user_id"].toString(),
          }
        );
      } else {
        CustomMethods().showSnackBar(
          context,
          "Reset email has been sent!",
          Colors.green,
        );
        Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(
        context, 
        "Reset password",
        hideActions: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter the ${isPhoneNumber ? "phone number" : "email"} associated with your account and we'll send a message with instructions to reset your password.",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.textColorLightGrey
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  !isPhoneNumber 
                    ? KTextFormField(
                        autoFocus: true,
                        controller: emailController,
                        hintText: "John@doe.com",
                        topLabelText: "Email address",
                      ) 
                    : KTextFormField(
                        autoFocus: true,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        hintText: "98*****",
                        topLabelText: "Phone number",
                      ),
                  const SizedBox(height: 8.0),
                   InkWell(
                    onTap: () {
                      setState(() {
                        isPhoneNumber = !isPhoneNumber;
                      });
                    },
                    child: Text(
                      isPhoneNumber 
                        ? "Use email"
                        : "Use phone number",
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.mainColor,
                        decorationColor: AppColors.mainColor
                      ),
                    ),
                   )
                ],
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: emailController,
            builder: (context, email, _) {
              return ValueListenableBuilder<TextEditingValue>(
                valueListenable: phoneController,
                builder: (context, phone, _) {
                  return KElevatedButton(
                    isDisabled: isPhoneNumber 
                      ? !phone.text.isPhoneNumber
                      : !email.text.isEmail,
                    onPressed: () {
                      sendOTP();
                    }, 
                    label: isPhoneNumber 
                      ? "Send message" 
                      : "Send email",
                  );
                }
              );
            }
          )
        ],
      ),
    );
  }
}