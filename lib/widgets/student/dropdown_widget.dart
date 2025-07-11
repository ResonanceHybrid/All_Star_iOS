// import 'package:flutter/material.dart';

// class DropdownWidget extends StatefulWidget {
//   const DropdownWidget(
//       {super.key,
//       required this.data,
//       // required this.label,
//       required this.hintText,
//       required this.onChanged,
//       required this.icon});
//   final List data;
//   // final String label;
//   final String hintText;
//   final Function onChanged;
//   final Icon icon;
//   @override
//   State<DropdownWidget> createState() => _DropdownWidgetState();
// }

// class _DropdownWidgetState extends State<DropdownWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<dynamic>(
//       isDense: true,
//       validator: (value) => value == null ? '' : null,
//       isExpanded: true,
//       decoration: InputDecoration(
//         prefixIcon: widget.icon,
//         contentPadding: const EdgeInsets.symmetric(vertical: 20),
//         focusedBorder: InputBorder.none,
//         enabledBorder: InputBorder.none,
//         errorBorder: InputBorder.none,
//         disabledBorder: InputBorder.none,
//       ),
//       hint: Text(
//         widget.hintText,
//       ),
//       items: widget.data.map((value) {
//         return DropdownMenuItem<dynamic>(
//           value: value,
//           child: Text(
//             value,
//           ),
//         );
//       }).toList(),
//       onChanged: (value) {
//         widget.onChanged(value);
//       },
//     );
//   }
// }
