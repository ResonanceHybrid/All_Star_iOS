import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/constants.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:flutter/material.dart';

class StudentCommingSoonPage extends StatefulWidget {
  final bool backAppBar;
  const StudentCommingSoonPage({super.key, required this.backAppBar});

  @override
  State<StudentCommingSoonPage> createState() => _StudentCommingSoonPageState();
}

class _StudentCommingSoonPageState extends State<StudentCommingSoonPage> {
  CustomMethods cm = CustomMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.backAppBar
          ? cm.getAppBarWithTitle(context, "Comming Soon")
          : AppBar(
              title: const Text(
                "Comming Soon",
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
              flexibleSpace: Container(
                decoration:
                    const BoxDecoration(gradient: AppColors.mainGradient),
              ),
            ),
      //drawer:.const StudentDrawerWidget(),
      body: Center(
          child: Image.asset(
        kCommingSoonIcon,
        height: 200,
      )),
    );
  }
}
