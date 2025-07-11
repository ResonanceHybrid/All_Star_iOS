import 'package:all_star_learning/Models/school_list_model.dart';
import 'package:all_star_learning/Pages/SelectSchool/search_school_data.dart';
import 'package:all_star_learning/config/theme/app_static_colors.dart';
import 'package:all_star_learning/routes/app_pages.dart';
import 'package:all_star_learning/utils/local_storage.dart';
import 'package:all_star_learning/widgets/student/container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utils/constants.dart';

class SelectSchoolPage extends StatefulWidget {
  final School? selectedSchool;
  const SelectSchoolPage({super.key, this.selectedSchool});

  @override
  State<SelectSchoolPage> createState() => _SelectSchoolPageState();
}

class _SelectSchoolPageState extends State<SelectSchoolPage> {
  School? selectedSchool;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedSchool = widget.selectedSchool;
    });
  }
  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppColors.mainGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                      15.0), // set the bottom-left border radius
                  bottomRight: Radius.circular(
                      15.0), // set the bottom-right border radius
                ),
              ),
              height: responsiveHeight * 0.5,
              width: MediaQuery.of(context)
                  .size
                  .width, // set the height of the container
            ),
          ),
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: responsiveHeight > 600
                    ? responsiveHeight * .24
                    : responsiveHeight * 0.125,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ContainerWidget(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      selectedSchool != null && selectedSchool!.logo != null 
                        ? Image.network(
                            selectedSchool!.logo!,
                            height: 128,
                            width: 128,
                          ) 
                        : Image.asset(
                            'assets/images/logo.png',
                            height: 100,
                            width: 100,
                          ),
                      if(selectedSchool != null) 
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            children: [
                              Text(
                                selectedSchool!.name!,
                                style: Theme.of(context)
                                .textTheme
                                .titleLarge!,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                selectedSchool!.address!,
                                style: Theme.of(context)
                                .textTheme
                                .labelMedium!,
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 20),
                      if(selectedSchool == null)
                      GestureDetector(
                          onTap: () async {
                            var response = await Get.to(
                                () => const SearchAndPaginateSchoolList());
                            if (response != null) {
                              setState(() {
                                selectedSchool = response;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            // margin: const EdgeInsets.symmetric(
                            //     horizontal: 16, vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText: selectedSchool == null
                                    ? 'Select Your School'
                                    : selectedSchool?.name,
                                prefixIcon: const Icon(Icons.school),
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.grey),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                border: InputBorder.none,
                              ),
                            ),
                          )),
            
                      const SizedBox(height: 20),
            
                      Row(
                        children: [
                          if(selectedSchool != null)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: GestureDetector(
                                onTap: () async {
                                  var response = await Get.to(
                                    () => const SearchAndPaginateSchoolList());
                                  if (response != null) {
                                    setState(() {
                                      selectedSchool = response;
                                    });
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: AppColors.mainGradient,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Reset",
                                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (selectedSchool == null) {
                                  SnackBar snackBar = const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Center(child: Text('Please select your school')),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  return;
                                } else {
                                  LocalStorageMethods.saveSchoolDetails(
                                    selectedSchool?.domainName ?? "",
                                    selectedSchool?.logo ?? "",
                                    selectedSchool?.name ?? "",
                                  );
                            
                                  Get.offAllNamed(AppPages.login);
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  gradient: AppColors.mainGradient,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80.sp,
              ),
              Image.asset(
                kLoginLogoImage,
                height: 40.sp,
              ),
              SizedBox(
                height: 20.sp,
              ),
              Text(
                "Privacy Policy",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.grey[500],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
