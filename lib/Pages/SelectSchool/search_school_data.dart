import 'package:all_star_learning/Models/base_response_model.dart';
import 'package:all_star_learning/Models/school_list_model.dart';
import 'package:all_star_learning/Resources/initial_api_method.dart';
import 'package:all_star_learning/utils/custom_methods.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SearchAndPaginateSchoolList extends StatefulWidget {
  const SearchAndPaginateSchoolList({super.key});

  @override
  State<SearchAndPaginateSchoolList> createState() =>
      _SearchAndPaginateSchoolListState();
}

class _SearchAndPaginateSchoolListState
    extends State<SearchAndPaginateSchoolList> {
  CustomMethods cm = CustomMethods();
  bool isLoading = false;
  bool isLoadMore = false;

  @override
  void initState() {
    getSchoolList();
    _scrollController.addListener(getDataOnScroll);
    super.initState();
  }

  String error = '';
  School? selectedSchool;
  SchoolListModel? schoolListModel;
  List<School> schoolList = [];
  List<School> filteredSchoolList = [];
  int page = 1;

  getDataOnScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (schoolListModel!.nextPageUrl != null) {
        page++;
        getSchoolList(isLoadMore: true);
      }
    }
  }

  Future<void> getSchoolList(
      {bool isSearched = false, bool isLoadMore = false}) async {
    setState(() {
      isLoading = true;
    });

    if (isSearched) {
      schoolList.clear();
      page = 1;
    }
    if (isLoadMore) {
      setState(() {
        isLoadMore = true;
      });
    }

    BaseResponse response = await InitialApi.getSchoolList(
        schoolName:
            searchController.text.isEmpty ? null : searchController.text,
        page: page);
    if (response is SuccessResponse) {
      schoolListModel = response.data as SchoolListModel;
      if (schoolListModel != null) {
        for (int i = 0; i < schoolListModel!.data!.length; i++) {
          if (schoolList
              .where((element) =>
                  element.domainName == schoolListModel?.data?[i].domainName)
              .isEmpty) {
            schoolList.add(schoolListModel!.data![i]);
          }
        }
      }
    } else {
      error = response.message ?? "Something went wrong";
      if (!mounted) return;
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      SnackBar snackBar = SnackBar(
          content: Center(child: Text(error)), backgroundColor: Colors.red);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    setState(() {
      isLoading = false;
      isLoadMore = false;
    });
  }

  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  final Debouncer _debouncer = Debouncer(milliseconds: 600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(context, "Select School"),
      body: RefreshIndicator(
        onRefresh: () async {
          await getSchoolList(isSearched: true);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 10),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search School",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  if (value.length > 3) {
                    _debouncer.run(() {
                      getSchoolList(isSearched: true);
                    });
                  }
                },
              ),
            ),
            Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : schoolList.isEmpty
                        ? const Center(
                            child: Text("Search Your School"),
                          )
                        : ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            controller: _scrollController,
                            children: [
                              ...schoolList.map((e) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 35,
                                      child: CachedNetworkImage(
                                        height: 50,
                                        imageUrl: e.logo ?? '',
                                        placeholder: (context, url) =>
                                            const Icon(Icons.image_outlined),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedSchool = e;
                                      });
                                      Navigator.pop(context, selectedSchool);
                                    },
                                    title: Text(e.name ?? 'N/A'),
                                    subtitle: Text(e.address ?? 'N/A'),
                                  ),
                                );
                              })
                            ],
                          )),
          ],
        ),
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(Function() action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
