import 'package:all_star_learning/Models/student_homework_model.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentHomeworkViewPage extends StatefulWidget {
  final List<HomeworkFiles> homeworkFiles;
  final String? description;

  const StudentHomeworkViewPage({
    super.key,
    required this.homeworkFiles,
    required this.description,
  });

  @override
  State<StudentHomeworkViewPage> createState() =>
      _StudentHomeworkViewPageState();
}

class _StudentHomeworkViewPageState extends State<StudentHomeworkViewPage> {
  CustomMethods cm = CustomMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: cm.getAppBarWithTitle(context, "View"),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.description??"N/A",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ...widget.homeworkFiles.map(
                    (e) {
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
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppPages.photoView,
                                  arguments: e.path,
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: e.path,
                                placeholder: (context, url) => Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    )),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(
                                        height: 200,
                                        child:
                                            Center(child: Icon(Icons.error))),
                              ),

                            ),
                            const SizedBox(height: 10,),
                            const Text("Comment"),
                            const SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                              )),
                              child: TextFormField(
                                initialValue: e.comments,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                  
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }
}
