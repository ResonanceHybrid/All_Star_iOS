import 'package:all_star_learning/Controllers/notification_controller.dart';
import 'package:all_star_learning/Utils/constants.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMethods().getAppBarWithTitle(context, "Notification"),
      body: GetBuilder<NotificationDataController>(
        init: NotificationDataController(),
        builder: (controller) {
          bool isLoading = controller.isLoading;
          List notification = controller.notification;

          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : notification.isEmpty
                  ? Center(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Image.asset(kNotificationNotFoundIcon),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Notification Not Found !!",
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView(
                      children: [
                        ...notification.map(
                          (e) {
                            return GestureDetector(
                              onTap: () {
                                // Get.to(() => NotificationDetails(
                                //       title: e["title"] ?? "",
                                //       description: e["data"] ?? "",
                                //       timeago: e["created"],
                                //     ));
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
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
                                            Text(
                                              "Notification",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 20),
                                        //time ago
                                        Text(
                                          e["created"],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        e["title"],
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(flex: 8, child: Text(e["data"])),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        e["image"] == ""
                                            ? const SizedBox()
                                            : Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context).canvasColor,
                                                  borderRadius:BorderRadius.circular(15),
                                                ),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: e["image"],
                                                ),
                                              )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    );
        },
      ),
    );
  }
}
