// To parse this JSON data, do
//
//     final schoolListModel = schoolListModelFromJson(jsonString);

import 'dart:convert';

SchoolListModel schoolListModelFromJson(Map<String, dynamic> data) =>
    SchoolListModel.fromJson(data);

String schoolListModelToJson(SchoolListModel data) =>
    json.encode(data.toJson());

class SchoolListModel {
  final int? currentPage;
  final List<School>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  SchoolListModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory SchoolListModel.fromJson(Map<String, dynamic> json) =>
      SchoolListModel(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<School>.from(json["data"]!.map((x) => School.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class School {
  final String? domainName;
  final String? name;
  final String? logo;
  final String? address;

  School({
    this.domainName,
    this.name,
    this.logo,
    this.address,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
        domainName: json["domain_name"],
        name: json["name"],
        logo: json["logo"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "domain_name": domainName,
        "name": name,
        "logo": logo,
      };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
