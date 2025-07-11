// import 'package:everest_remit_app/Config/custom_text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class HowItWorks extends StatefulWidget {
//   const HowItWorks({super.key});

//   @override
//   State<HowItWorks> createState() => _HowItWorksState();
// }

// class _HowItWorksState extends State<HowItWorks> {
//   WebViewController controller = WebViewController();
//   @override
//   void initState() {
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse('https://app.everestremit.co.uk/how-it-works'),
//       );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("How it works")),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
//                 margin: const EdgeInsets.symmetric(vertical: 10),
//                 height: 100,
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(3.0),
//                   image: const DecorationImage(
//                       image: AssetImage(
//                         "assets/images/sky.jpeg",
//                       ),
//                       fit: BoxFit.cover),
//                 ),
//                 child: Center(
//                   child: Text(
//                     "How It works?",
//                     style: CustomTextStyle.headingBoldStyleLarge
//                         .copyWith(color: Colors.white),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               serviesBlock(
//                   title: "1. Register With Everest Remit",
//                   description:
//                       "Sign up with your details and create a strong password. You can also use the app or the website to register."),
//               serviesBlock(
//                   title: "2. Insert Transfer Details",
//                   description:
//                       "Enter amount, select currency and choose delivery method. See our exchange rate upfront."),
//               serviesBlock(
//                   title: "3. Insert Receiver's Details",
//                   description:
//                       "Keep your receiver's information ready. These details depend on the receive method you choose to send money."),
//               serviesBlock(
//                   title: "4. Pay For Your Transfer",
//                   description:
//                       "You can either pay by using a debit/credit card for faster delivery or by bank transfer to the Everest Remit account."),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Column serviesBlock({required title, required description}) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: CustomTextStyle.headingBoldStyleMedium,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//           child: Text(
//             description,
//             style: CustomTextStyle.displayLight(),
//             textAlign: TextAlign.justify,
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         )
//       ],
//     );
//   }
// }
