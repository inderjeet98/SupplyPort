// To parse this JSON data, do
//
//     final SubCategory = SubCategoryFromJson(jsonString);

import 'dart:convert';

List<SubCategory> subCategoryFromJson(String str) => List<SubCategory>.from(
    json.decode(str).map((x) => SubCategory.fromJson(x)));

String subCategoryToJson(List<SubCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategory {
  SubCategory({
    required this.data,
  });

  List<Datum> data;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {"data": List<dynamic>.from(data.map((x) => x.toJson()))};
}

class Datum {
  Datum({
    required this.subCategory,
  });

  String subCategory;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subCategory: json["SubCategory"],
      );

  Map<String, dynamic> toJson() => {
        "SubCategory": subCategory,
      };
}
