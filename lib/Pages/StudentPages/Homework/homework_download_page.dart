import 'package:all_star_learning/Models/student_homework_model.dart';
import 'package:all_star_learning/Utils/custom_methods.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:get/get.dart';
import 'package:external_path/external_path.dart';

class StudentHomeworkDownloadPage extends StatefulWidget {
  final List<HomeworkFiles> homeworkFiles;

  const StudentHomeworkDownloadPage({
    super.key,
    required this.homeworkFiles,
  });

  @override
  State<StudentHomeworkDownloadPage> createState() =>
      _StudentHomeworkDownloadPageState();
}

class _StudentHomeworkDownloadPageState
    extends State<StudentHomeworkDownloadPage> {
  CustomMethods cm = CustomMethods();
  final _flutterMediaDownloaderPlugin = MediaDownload();

// Function to handle the download process
  void handleDownload(String filePath, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Downloading..."),
            ],
          ),
        );
      },
    );

    try {
      // Start file download
      await _flutterMediaDownloaderPlugin.downloadMedia(
        context,
        filePath,
        await ExternalPath.getExternalStoragePublicDirectory("Download"),
        filePath.split('/').last,
      );

      // Close the loading dialog
      Get.back();
      // Show success message
      cm.showSnackBar(context, "File downloaded successfully ", Colors.green);
    } catch (e) {
      // Close the loading dialog
      Get.back();
      // Show error message
      cm.showSnackBar(context, "File failed to download", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: cm.getAppBarWithTitle(context, "Download"),
        body: widget.homeworkFiles.isEmpty
            ? const Center(
                child: Text("No Homework Files Available"),
              )
            : ListView(
                children: [
                  ...widget.homeworkFiles.map(
                    (e) {
                      return Stack(
                        children: [
                          Container(
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        )),
                                    errorWidget: (context, url, error) =>
                                        const SizedBox(
                                            height: 200,
                                            child: Center(
                                                child: Icon(Icons.error))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () async {
                                handleDownload(e.path, context);
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )
                ],
              ));
  }
}
