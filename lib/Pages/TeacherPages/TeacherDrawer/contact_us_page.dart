// import 'package:everest_remit_app/Config/app_colors.dart';
// import 'package:everest_remit_app/Widgets/bg_button.dart';
// import 'package:everest_remit_app/Widgets/dropdown_widget.dart';
// import 'package:everest_remit_app/Widgets/text_field_widget.dart';
// import 'package:flutter/material.dart';

// class ContactUsPage extends StatefulWidget {
//   const ContactUsPage({super.key});

//   @override
//   State<ContactUsPage> createState() => _ContactUsPageState();
// }

// class _ContactUsPageState extends State<ContactUsPage> {
//   TextEditingController fullnameController = TextEditingController();
//   TextEditingController mobileNumberController = TextEditingController();
//   TextEditingController titleController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String relatedTopic = 'Feedback';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Padding(
//         padding: MediaQuery.of(context).viewInsets,
//         child: BottomAppBar(
//           height: 70,
//           child: Bgbutton(
//               label: 'Submit Now',
//               textColour: Colors.white,
//               onPress: () {
//                 if (_formKey.currentState!.validate()) {}
//               },
//               bg: AppColors.mainColor,
//               fontsize: 17),
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text("Contact Us"),
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
//                     DropdownWidget(
//                         data: const [
//                           "Feedback",
//                           "Complaint",
//                           "Transaction",
//                           "Fraud Reporting",
//                           "Refund Request"
//                         ],
//                         label: "Contact us related to",
//                         hintText: "Feedback",
//                         onChanged: (value) {
//                           setState(() {
//                             relatedTopic = value;
//                           });
//                         }),
//                     TextFormFieldWidget(
//                       label: "Full Name",
//                       controller: fullnameController,
//                     ),
//                     PhoneNumberFieldWidget(
//                       label: "Mobile Number",
//                       controller: mobileNumberController,
//                     ),
//                     TextFormFieldWidget(
//                       label: "Title",
//                       controller: titleController,
//                     ),
//                     EntryTextAreaField(
//                       labelText: "Description",
//                       controller: descriptionController,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }
