// To parse this JSON data, do
//
//     final popularBrands = popularBrandsFromJson(jsonString);

import 'dart:convert';

List<PopularBrands> popularBrandsFromJson(String str) =>
    List<PopularBrands>.from(
        json.decode(str).map((x) => PopularBrands.fromJson(x)));

String popularBrandsToJson(List<PopularBrands> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularBrands {
  PopularBrands({
    required this.data,
  });

  List<Datum> data;

  factory PopularBrands.fromJson(Map<String, dynamic> json) => PopularBrands(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.brand,
    required this.itemcount,
    required this.totalSale,
  });

  String brand;
  int itemcount;
  double totalSale;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        brand: json["Brand"],
        itemcount: json["itemcount"],
        totalSale: json["TotalSale"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Brand": brand,
        "itemcount": itemcount,
        "TotalSale": totalSale,
      };
}
