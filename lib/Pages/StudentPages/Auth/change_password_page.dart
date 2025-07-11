import 'package:all_star_learning/new/core/common/custom_form_filed.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Models/base_response_model.dart';
import '../../../Resources/api_methods.dart';
import '../../../Utils/custom_methods.dart';
import '../../../Utils/local_storage.dart';
import '../../../config/translations/strings_enum.dart';

class ChangePasswordPage extends StatefulWidget {
  final String? userId;

  const ChangePasswordPage({super.key, this.userId});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final CustomMethods cm = CustomMethods();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  changePassword() async {
    CustomMethods().loadingAlertDialog();
    var details = LocalStorageMethods.getUserDetails();
    BaseResponse response = await ApiMethods.updatePassword(
      userId: int.tryParse(widget.userId ?? "") ?? details["data"]["id"],
      password: _passwordController.text,
    );
    if (!mounted) return;
    if (response is SuccessResponse) {
      Navigator.pop(context);
      FocusManager.instance.primaryFocus?.unfocus();
      CustomMethods().showSnackBar(
        context,
        "Password changed!",
        Colors.green,
      );
      if(widget.userId != null) {
        Get.toNamed(AppPages.login);
      }
    } else if (response is ErrorResponse) {
      Navigator.pop(context);
      FocusManager.instance.primaryFocus?.unfocus();
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
        "Change Password", 
        hideActions: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 64),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  KTextFormField(
                    controller: _passwordController,
                    hintText: "********",
                    topLabelText: "Enter your new password",
                  ),
                  const SizedBox(height: 24.0),
                  KTextFormField(
                    controller: _confirmPasswordController,
                    hintText: "********",
                    topLabelText: "Re-enter your new password",
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _passwordController,
            builder: (context, password, _) {
              return ValueListenableBuilder<TextEditingValue>(
                valueListenable: _confirmPasswordController,
                builder: (context, confirmPassword, _) {
                  bool isDisabled = !((password.text.trim().isNotEmpty && confirmPassword.text.trim().isNotEmpty) 
                                    && (password.text.trim() == confirmPassword.text.trim()));
                  return KElevatedButton(
                    onPressed: () {
                      changePassword();
                    },
                    isDisabled: isDisabled,
                    label: "Change password",
                  );
                }
              );
            }
          ),
        ],
      ),
    );
  }
}