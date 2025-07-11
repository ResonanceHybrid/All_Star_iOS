import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/constants.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:all_star_learning/widgets/student/online_class_card.dart';
import 'package:flutter/material.dart';

class OnlineClassPage extends StatefulWidget {
  const OnlineClassPage({super.key});

  @override
  State<OnlineClassPage> createState() => _OnlineClassPageState();
}

class _OnlineClassPageState extends State<OnlineClassPage> {
  int selectedRadioTile = 0;
  CustomMethods cm = CustomMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(
        context,
        "Online Class",
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, top: 50, right: 8),
            child: ContainerWidget(
              child: Column(children: [
                Text(
                  "Select Default Online class Tool",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.mainColor),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRadioTile = 0;
                        });
                      },
                      child: ZoomCard(
                          icon: Image.asset(kzoomImage,
                              height: 50, width: 50),
                          title: "Zoom",
                          check: selectedRadioTile == 0,
                          ontap: () {
                            setState(() {
                              selectedRadioTile = 0;
                            });
                          }),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRadioTile = 1;
                        });
                      },
                      child: ZoomCard(
                          icon: Image.asset(kteamsImage,
                              height: 50, width: 50),
                          title: "Teams",
                          check: selectedRadioTile == 1,
                          ontap: () {
                            setState(() {
                              selectedRadioTile = 1;
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text("Done",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
