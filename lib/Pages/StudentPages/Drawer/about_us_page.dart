// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class AboutUsPage extends StatefulWidget {
//   const AboutUsPage({super.key});

//   @override
//   State<AboutUsPage> createState() => _AboutUsPageState();
// }

// class _AboutUsPageState extends State<AboutUsPage> {
//   WebViewController controller = WebViewController();
//   @override
//   void initState() {
//     controller = WebViewController()
//       ..loadRequest(
//         Uri.parse('https://app.everestremit.co.uk/about-us'),
//       );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text("About Us")),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: WebViewWidget(
//             controller: controller,
//           ),
//         ));
//   }
// }
