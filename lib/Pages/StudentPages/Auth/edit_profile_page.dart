import 'package:all_star_learning/Pages/TeacherPages/TeacherHome/cubit/home_container_cubit.dart';
import 'package:all_star_learning/new/core/common/custom_form_filed.dart';
import 'package:all_star_learning/widgets/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../Models/base_response_model.dart';
import '../../../Resources/api_methods.dart';
import '../../../Utils/custom_methods.dart';
import '../../../Utils/local_storage.dart';
import '../../../config/translations/strings_enum.dart';

class EditProfilePage extends StatefulWidget {

  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  final CustomMethods cm = CustomMethods();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    var details = LocalStorageMethods.getUserDetails();
    userData = details["data"];
    _nameController = TextEditingController(text: userData?["name"]);
    _emailController = TextEditingController(text: userData?["email"]);
    _addressController = TextEditingController(text: userData?["permanent_address"]);
    setState(() {
      
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  editProfile() async {
    CustomMethods().loadingAlertDialog();
    BaseResponse response = await ApiMethods.editProfile(
      email: _emailController.text.trim(),
      name: _nameController.text.trim(),
      address: _addressController.text.trim(),
    );
    if (!mounted) return;
    if (response is SuccessResponse) {
      Navigator.pop(context);
      FocusManager.instance.primaryFocus?.unfocus();
      LocalStorageMethods.saveUserDetails(
        response.data,
      );
      BlocProvider.of<HomeContainerCubit>(context).getUserDetails();
      CustomMethods().showSnackBar(
        context,
        response.data["message"],
        Colors.green,
      );
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
        "Edit profile", 
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
                    controller: _nameController,
                    hintText: "name",
                    topLabelText: "Enter your name",
                  ),
                  const SizedBox(height: 24.0),
                  KTextFormField(
                    controller: _emailController,
                    hintText: "email",
                    topLabelText: "Enter your email",
                  ),
                  const SizedBox(height: 24.0),
                  KTextFormField(
                    controller: _addressController,
                    hintText: "address",
                    topLabelText: "Enter your address",
                  ),
                ],
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _emailController,
            builder: (context, email, _) {
              return ValueListenableBuilder<TextEditingValue>(
                valueListenable: _nameController,
                builder: (context, name, _) {
                  return ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _addressController,
                    builder: (context, address, _) {
                      bool isDisabled = name.text.isEmpty && address.text.isEmpty && !email.text.isEmail;
                      return KElevatedButton(
                        onPressed: () {
                          editProfile();
                        },
                        isDisabled: isDisabled,
                        label: "Save",
                      );
                    }
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