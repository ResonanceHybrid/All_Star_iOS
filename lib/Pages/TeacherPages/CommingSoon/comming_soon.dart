import 'package:all_star_learning/utils/constants.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:flutter/material.dart';

class CommingSoonPage extends StatefulWidget {
  final bool backAppBar;
  const CommingSoonPage({super.key, required this.backAppBar});

  @override
  State<CommingSoonPage> createState() => _CommingSoonPageState();
}

class _CommingSoonPageState extends State<CommingSoonPage> {
  CustomMethods cm = CustomMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.backAppBar
          ? cm.getAppBarWithTitle(context, "Comming Soon")
          : cm.teacherAppBarWithAction("Comming Soon", context),
      // //drawer:.const TeacherDrawer(),
      body: Center(
          child: Image.asset(
        kCommingSoonIcon,
        height: 200,
      )),
    );
  }
}
