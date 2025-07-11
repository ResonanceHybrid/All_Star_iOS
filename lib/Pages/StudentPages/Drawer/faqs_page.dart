// import 'package:everest_remit_app/Config/custom_text_styles.dart';
// import 'package:flutter/material.dart';

// class FAQsPage extends StatefulWidget {
//   const FAQsPage({super.key});

//   @override
//   State<FAQsPage> createState() => _FAQsPageState();
// }

// class _FAQsPageState extends State<FAQsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("FAQs"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           itemCount: 10,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 15),
//               child: ListTile(
//                 subtitle: const Text(
//                     "Give us a call. If we haven’t transferred your funds yet, we can add it for you. If the transfer has already been made, you’ll need to contact your recipient to let them know."),
//                 title: Text(
//                   "${index + 1} . What Should I Do If I Didn’t Add My Recipients Reference to My Transfer?",
//                   style: CustomTextStyle.headingBoldStyleMedium,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
