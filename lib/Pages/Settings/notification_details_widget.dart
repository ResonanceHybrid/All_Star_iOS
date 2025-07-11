import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:flutter/material.dart';

class NotificationDetails extends StatelessWidget {
  final String? title;
  final String? description;
  final String timeago;
  const NotificationDetails({super.key, required this.title, required this.description, required this.timeago});

  @override
  Widget build(BuildContext context) {
    CustomMethods cm = CustomMethods();
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Notification Details"),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(10), boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: AppColors.mainColor,
                          ),
                          Text("Notification", style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                      const SizedBox(width: 20),
                      //time ago
                      Text(timeago, style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(alignment: Alignment.centerLeft, child: Text(title ?? "", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
                  const SizedBox(height: 10),
                  Text(description ?? ""),
                  const SizedBox(
                    width: 10,
                  )
                ],
              )),
        ],
      ),
    );
  }
}
