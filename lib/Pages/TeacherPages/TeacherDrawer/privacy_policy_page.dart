// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class PrivacyPolicyPage extends StatefulWidget {
//   const PrivacyPolicyPage({super.key});

//   @override
//   State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
// }

// class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
//   WebViewController controller = WebViewController();
//   @override
//   void initState() {
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse('https://app.everestremit.co.uk/privacy-policy'),
//       );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text("Privacy Policy")),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: WebViewWidget(
//             controller: controller,
//           ),
//         ));
//   }
// }
