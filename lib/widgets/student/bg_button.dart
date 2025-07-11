import 'package:flutter/material.dart';

class Bgbutton extends StatelessWidget {
  const Bgbutton(
      {super.key,
      required this.label,
      required this.onPress,
      required this.bg,
      required this.fontsize,
      this.textColour});
  final String label;
  final Function onPress;
  final dynamic bg;
  final double fontsize;
  final Color? textColour;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: bg,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
      ),
      onPressed: () {
        onPress();
      },
      child: Text(
        label,
        style: TextStyle(color: textColour ?? Colors.black, fontSize: fontsize),
      ),
    );
  }
}

// class BgOutlinedbutton extends StatelessWidget {
//   BgOutlinedbutton(
//       {super.key,
//       required this.label,
//       required this.onPress,
//       required this.bg,
//       required this.textColour});
//   String label;
//   Function onPress;

//   var textColour;

//   var bg;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 100,
//       height: 30,
//       child: OutlinedButton(
//         onPressed: () {
//           onPress();
//         },
//         style: OutlinedButton.styleFrom(
//           foregroundColor: textColour,
//           side: BorderSide(
//             color: bg,
//             width: 1,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(0),
//           ),
//           backgroundColor: Theme.of(context).cardColor,
//         ),
//         child: Text(
//           label,
//           maxLines: 1,
//           textAlign: TextAlign.center,
//           overflow: TextOverflow.ellipsis,
//           style: Theme.of(context)
//               .textTheme
//               .displayLarge!
//               .copyWith(color: textColour),
//         ),
//       ),
//     );
//   }
// }
