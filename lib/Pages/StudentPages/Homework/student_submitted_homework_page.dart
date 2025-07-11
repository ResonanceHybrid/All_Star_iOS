import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentSubmittedHomeworkPage extends StatefulWidget {
  final int homeworkId;
  const StudentSubmittedHomeworkPage({super.key, required this.homeworkId});

  @override
  State<StudentSubmittedHomeworkPage> createState() =>
      _StudentSubmittedHomeworkPageState();
}

class _StudentSubmittedHomeworkPageState
    extends State<StudentSubmittedHomeworkPage> {
  @override
  void initState() {
    super.initState();
    getSubmittedHomework();
  }

  CustomMethods cm = CustomMethods();

  String errorMesssage = "";
  bool isLoading = false;
  List homeworkList = [];

  getSubmittedHomework() async {
    setState(() {
      isLoading = true;
    });
    BaseResponse data =
        await StudentApiMethods.getSubmittedHomework(widget.homeworkId);
    if (data is SuccessResponse) {
      homeworkList = data.data["data"];
    } else if (data is ErrorResponse) {
      errorMesssage = data.message ?? "Error loading submitted data.......";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: cm.getAppBarWithTitle(context, "Submitted"),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : homeworkList.isEmpty
                ? Center(
                    child: Text(
                      "Home work not submitted yet !",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  )
                : ListView(
                    children: [
                      ...homeworkList.map(
                        (e) {
                          return Stack(children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: e["path"],
                                    imageBuilder: (context, imageProvider) =>
                                        GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppPages.photoView,
                                            arguments: e["path"]);
                                      },
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                      height: 200,
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const SizedBox(
                                      height: 200,
                                      child: Center(child: Icon(Icons.error)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("Comment"),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    )),
                                    child: TextFormField(
                                      readOnly: true,
                                      initialValue: e["comments"],
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                top: 5,
                                right: 10,
                                child: Container(
                                  //delete
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              title: const Text("Delete"),
                                              content: const Text(
                                                  "Are you sure you want to delete this file?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("No")),
                                                TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      BaseResponse data =
                                                          await StudentApiMethods
                                                              .deleteSubmittedHomework(
                                                                  e["id"]);
                                                      if (data
                                                          is SuccessResponse) {
                                                        if (!mounted) {
                                                          return;
                                                        }
                                                        cm.showSnackBar(
                                                            context,
                                                            "File deleted successfully",
                                                            Colors.green);
                                                        getSubmittedHomework();
                                                      } else if (data
                                                          is ErrorResponse) {
                                                        if (!mounted) {
                                                          return;
                                                        }
                                                        cm.showSnackBar(
                                                            context,
                                                            data.message ??
                                                                "Error deleting file",
                                                            Colors.red);
                                                      }
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    },
                                                    child: const Text("Yes")),
                                              ],
                                            );
                                          });
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                ))
                          ]);
                        },
                      )
                    ],
                  ));
  }
}
