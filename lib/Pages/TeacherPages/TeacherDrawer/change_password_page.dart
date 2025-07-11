// import 'package:everest_remit_app/Config/app_colors.dart';
// import 'package:everest_remit_app/Widgets/bg_button.dart';
// import 'package:everest_remit_app/Widgets/text_field_widget.dart';
// import 'package:flutter/material.dart';

// class ChangePasswordPage extends StatefulWidget {
//   const ChangePasswordPage({super.key});

//   @override
//   State<ChangePasswordPage> createState() => _ChangePasswordPageState();
// }

// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   TextEditingController currentPasswordController = TextEditingController();
//   TextEditingController newPasswordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String deliveryLocation = '';
//   String relation = '';
//   bool isCurrentPasswordObscure = false;
//   bool isNewPasswordObscure = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Padding(
//         padding: MediaQuery.of(context).viewInsets,
//         child: BottomAppBar(
//           height: 70,
//           child: Bgbutton(
//               label: 'Update',
//               textColour: Colors.white,
//               onPress: () {
//                 if (_formKey.currentState!.validate()) {}
//               },
//               bg: AppColors.mainColor,
//               fontsize: 17),
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text("Change Password"),
//       ),
//       body: SafeArea(
//           bottom: false,
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     PasswordFieldWidget(
//                       label: "Current Password",
//                       controller: currentPasswordController,
//                       isObscure: isCurrentPasswordObscure,
//                     ),
//                     PasswordFieldWidget(
//                       label: "New Password",
//                       controller: newPasswordController,
//                       isObscure: isNewPasswordObscure,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
