import 'dart:async';

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

class OTPVerificationPage extends StatefulWidget {
  final String phoneNum;
  final String userId;
  const OTPVerificationPage({super.key, required this.phoneNum, required this.userId,});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final CustomMethods cm = CustomMethods();
  late final TextEditingController otpController;
  late final Timer resetTimer;
  bool canResend = true;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  verifyOTP() async {
    CustomMethods().loadingAlertDialog();
    BaseResponse response = await ApiMethods.verifyOTP(
      userId: widget.userId,
      otp: otpController.text.trim(),
    );
    if (response is SuccessResponse) {
      Get.toNamed(AppPages.changePassword, arguments: widget.userId);
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

  resendOTP() async {
    setState(() {
      canResend = false;
    });
    resetTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timer.tick >= 10) {
        timer.cancel();
        setState(() {
          canResend = true;
        });
      }
    });
    await ApiMethods.sendOTP(
      phoneNumber: widget.phoneNum,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(
        context, 
        "Verify OTP",
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
                    "Enter the OTP that we had sent to ${widget.phoneNum}",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.textColorLightGrey
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  
                  KTextFormField(
                    autoFocus: true,
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    hintText: "*****",
                    topLabelText: "OTP",
                  ),
                  const SizedBox(height: 8.0),
                   InkWell(
                    onTap: canResend ? () async {
                      resendOTP();
                    } : null,
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: canResend ? AppColors.mainColor : AppColors.textColorLightGrey,
                        decorationColor: canResend ? AppColors.mainColor : AppColors.textColorLightGrey,
                      ),
                    ),
                   )
                ],
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: otpController,
            builder: (context, otp, _) {
              return KElevatedButton(
                isDisabled: otp.text.isEmpty,
                onPressed: () {
                  verifyOTP();
                }, 
                label: "Verify",
              );
            }
          )
        ],
      ),
    );
  }
}