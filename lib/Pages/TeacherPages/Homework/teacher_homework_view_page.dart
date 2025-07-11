import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/api_methods.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeacherHomeWorkViewPage extends StatefulWidget {
  final int homeworkId;
  final int userId;
  const TeacherHomeWorkViewPage({super.key, required this.homeworkId, required this.userId});

  @override
  State<TeacherHomeWorkViewPage> createState() => _TeacherHomeWorkViewPageState();
}

class _TeacherHomeWorkViewPageState extends State<TeacherHomeWorkViewPage> {
  CustomMethods cm = CustomMethods();
  @override
  void initState() {
    super.initState();
    getStudentHomeworkList();
  }

  getStudentHomeworkList() async {
    setState(() {
      isLoadingHomework = true;
    });
    BaseResponse data = await ApiMethods.getSudentHomework(widget.homeworkId, widget.userId);

    if (data is SuccessResponse) {
      homeworkList = data.data["data"];
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something Went Wrong";
    }
    setState(() {
      isLoadingHomework = false;
    });
  }

  bool isLoadingHomework = false;
  String errorMessage = "";
  List homeworkList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, 'Homework'),
      body: isLoadingHomework
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : homeworkList.isEmpty
              ? const Center(
                  child: Text(
                    "No Homework Found",
                  ),
                )
              : ListView(children: [
                  ...homeworkList.map((e) {
                    TextEditingController commentController = TextEditingController(text: e["comments"]);
                    return Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).cardColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                AppPages.photoView,
                                arguments: e["path"],
                              );
                            },
                            child: CachedNetworkImage(
                              imageUrl: e["path"],
                              placeholder: (context, url) => Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  )),
                              errorWidget: (context, url, error) => const SizedBox(height: 200, child: Center(child: Icon(Icons.error))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Add Comment"),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            )),
                            child: TextField(
                              controller: commentController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await postComment(e["id"], commentController.text);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.mainColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                      child: Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: const Text("Delete"),
                                          content: const Text("Are you sure you want to delete this file?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  deleteHomeworkFile(e["id"]);
                                                },
                                                child: const Text("Yes")),
                                            TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("No")),
                                          ],
                                        );
                                      });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.kRedColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  })
                ]),
    );
  }

  postComment(int homeworkFileId, String comment) async {
    cm.loadingAlertDialog();
    BaseResponse data = await ApiMethods.addHomeworkComment(
      homeworkFileId: homeworkFileId,
      comment: comment,
    );
    if (data is SuccessResponse) {
      Get.back();
      getStudentHomeworkList();
    } else if (data is ErrorResponse) {
      Get.back();
      errorMessage = data.message ?? "Something Went Wrong";
    }
  }

  deleteHomeworkFile(int homeworkId) async {
    cm.loadingAlertDialog();
    BaseResponse data = await ApiMethods.deleteHomeworkFile(
      homeworkFileId: homeworkId,
    );

    if (data is SuccessResponse) {
      Get.back();
      getStudentHomeworkList();
    } else if (data is ErrorResponse) {
      Get.back();
      errorMessage = data.message ?? "Something Went Wrong";
    }
  }
}
