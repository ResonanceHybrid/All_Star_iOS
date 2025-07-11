// import 'package:all_star_learning/config/theme/app_static_colors.dart';
// import 'package:flutter/material.dart';

// class TDropdownWidget extends StatefulWidget {
//   const TDropdownWidget(
//       {super.key, required this.data, required this.label, required this.hintText, required this.onChanged, this.value, required this.isLoading});
//   final List data;
//   final String label;
//   final String hintText;
//   final Function(dynamic) onChanged;
//   final String? value;
//   final bool isLoading;
//   @override
//   State<TDropdownWidget> createState() => _TDropdownWidgetState();
// }

// class _TDropdownWidgetState extends State<TDropdownWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Container(
//             padding: const EdgeInsets.only(left: 20, right: 10),
//             decoration: BoxDecoration(boxShadow: const [
//               BoxShadow(
//                 color: Colors.deepOrangeAccent,
//                 spreadRadius: 0,
//                 blurRadius: 6,
//                 offset: Offset(0, 4), // sets position of shadow
//               ),
//             ], color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(5)),
//             child: Theme(
//               data: Theme.of(context).copyWith(
//                 canvasColor: Theme.of(context).cardColor,
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButtonFormField<dynamic>(
//                     isExpanded: true,
//                     value: widget.value,
//                     icon: widget.isLoading
//                         ? const SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           )
//                         : const Icon(Icons.arrow_downward, color: AppColors.mainColor),
//                     decoration: const InputDecoration(border: InputBorder.none),
//                     hint: Text(
//                       widget.hintText,
//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.mainColor, fontWeight: FontWeight.w600),
//                     ),
//                     items: widget.data.map((value) {
//                       return DropdownMenuItem<dynamic>(
//                         value: value.id.toString(),
//                         child: Text(
//                           value.name,
//                           style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.mainColor, fontWeight: FontWeight.w600),
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: widget.onChanged),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
