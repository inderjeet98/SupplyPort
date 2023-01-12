// To parse this JSON data, do
//
//     final popularCategories = popularCategoriesFromJson(jsonString);

import 'dart:convert';

List<PopularCategories> popularCategoriesFromJson(String str) =>
    List<PopularCategories>.from(
        json.decode(str).map((x) => PopularCategories.fromJson(x)));

String popularCategoriesToJson(List<PopularCategories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularCategories {
  PopularCategories({
    required this.data,
  });

  List<Datum> data;

  factory PopularCategories.fromJson(Map<String, dynamic> json) =>
      PopularCategories(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.category,
    required this.categoryName,
    required this.itemcount,
    required this.totalSale,
  });

  String category;
  String categoryName;
  int itemcount;
  double totalSale;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        category: json["Category"],
        categoryName: json["CategoryName"],
        itemcount: json["itemcount"],
        totalSale: json["TotalSale"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Category": category,
        "CategoryName": categoryName,
        "itemcount": itemcount,
        "TotalSale": totalSale,
      };
}
