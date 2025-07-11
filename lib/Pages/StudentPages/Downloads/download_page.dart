import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Resources/student_api_methods.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  void initState() {
    super.initState();
    getContentTypes();
  }

  CustomMethods cm = CustomMethods();
  List<dynamic> contentTypes = [];
  String errorMessage = "";
  Map<String, dynamic> contentData = {};
  Map<String, bool> isLoading = {};
  bool isLoadingContent = true;
  int? selectedContentIndex;

  getContentTypes() async {
    BaseResponse data = await StudentApiMethods.getContentTypes();
    if (data is SuccessResponse) {
      contentTypes = data.data["data"];
      if (contentTypes.isNotEmpty) {
        selectedContentIndex = 0;
      }
      await fetchAllContentDetails();
    } else if (data is ErrorResponse) {
      errorMessage = data.message ?? "Something went wrong";
    }
    setState(() {
      isLoadingContent = false;
    });
  }

  fetchAllContentDetails() async {
    for (int index = 0; index < contentTypes.length; index++) {
      var e = contentTypes[index];
      setState(() {
        isLoading["$index"] = true;
      });
      BaseResponse data = await StudentApiMethods.getContentDetails(e["id"]);
      if (data is SuccessResponse) {
        contentData["$index"] = data.data["data"];
      } else if (data is ErrorResponse) {
        errorMessage = data.message ?? "Something went wrong";
      }
      setState(() {
        isLoading["$index"] = false;
      });
    }
  }

  final _flutterMediaDownloaderPlugin = MediaDownload();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Downloads"),
      body: isLoadingContent
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : contentTypes.isEmpty
              ? const Center(child: Text("No Data Found"))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          contentTypes.length,
                          (index) {
                            var e = contentTypes[index];
                            return ChoiceChip(
                              showCheckmark: false,
                              label: Text(
                                e["title"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: selectedContentIndex == index
                                      ? Colors.white
                                      : AppColors.mainColor,
                                ),
                              ),
                              selected: selectedContentIndex == index,
                              onSelected: (selected) {
                                setState(() {
                                  selectedContentIndex =
                                      selected ? index : null;
                                });
                              },
                              selectedColor: AppColors.mainColor,
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: AppColors.mainColor,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: selectedContentIndex == null
                          ? const Center(
                              child: Text("Select a category to view content"),
                            )
                          : isLoading["$selectedContentIndex"] == true
                              ? const Center(child: CircularProgressIndicator())
                              : contentData.containsKey("$selectedContentIndex")
                                  ? contentData["$selectedContentIndex"]
                                              .length ==
                                          0
                                      ? const Center(
                                          child: Text(
                                            "No Content Available",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            ),
                                          ),
                                        )
                                      : ListView.separated(
                                          padding: const EdgeInsets.all(12),
                                          itemCount: contentData[
                                                  "$selectedContentIndex"]
                                              .length,
                                          separatorBuilder: (context, _) =>
                                              const SizedBox(height: 8.0),
                                          itemBuilder: (context, index) {
                                            var file = contentData[
                                                "$selectedContentIndex"][index];
                                            return Material(
                                              elevation: 3,
                                              shadowColor:
                                                  Colors.grey.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              clipBehavior: Clip.antiAlias,
                                              child: ListTile(
                                                tileColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                title: Text(
                                                  "${file['title']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                ),
                                                subtitle: Text(
                                                  "${file["update_date"]}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge!
                                                      .copyWith(
                                                        color: Colors.grey,
                                                        fontSize: 14,
                                                      ),
                                                ),
                                                trailing: IconButton(
                                                  icon: const Icon(
                                                    Icons.download,
                                                    size: 30,
                                                    color: AppColors.mainColor,
                                                  ),
                                                  onPressed: () async {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext
                                                          context) {
                                                        return const AlertDialog(
                                                          content: Row(
                                                            children: [
                                                              CircularProgressIndicator(),
                                                              SizedBox(
                                                                  width: 20),
                                                              Text(
                                                                  "Downloading..."),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );

                                                    try {
                                                      // Start file download
                                                      await _flutterMediaDownloaderPlugin
                                                          .downloadMedia(
                                                        context,
                                                        file["file"],
                                                        await ExternalPath
                                                            .getExternalStoragePublicDirectory(
                                                                'Download'),
                                                        file["file"]
                                                            .split('/')
                                                            .last,
                                                      );

                                                      // Close the loading dialog
                                                      Get.back();
                                                      // Show success message
                                                      if (!context.mounted)
                                                        return;
                                                      cm.showSnackBar(
                                                        context,
                                                        "File downloaded successfully ",
                                                        Colors.green,
                                                      );
                                                    } catch (e) {
                                                      // Close the loading dialog
                                                      Get.back();
                                                      // Show error message
                                                      cm.showSnackBar(
                                                          context,
                                                          "File failed to download",
                                                          Colors.red);
                                                    }
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                  : const Center(
                                      child: Text(
                                        "No Content Available",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                    ),
                  ],
                ),
    );
  }
}
