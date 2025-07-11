// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class TermsAndConditionPage extends StatefulWidget {
//   const TermsAndConditionPage({super.key});

//   @override
//   State<TermsAndConditionPage> createState() => _TermsAndConditionPageState();
// }

// class _TermsAndConditionPageState extends State<TermsAndConditionPage> {
//   WebViewController controller = WebViewController();
//   @override
//   void initState() {
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse('https://app.everestremit.co.uk/terms-and-conditions'),
//       );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Terms and Conditions")),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: WebViewWidget(
//           controller: controller,
//         ),
//       ),
//     );
//   }
// }
