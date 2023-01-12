// To parse this JSON data, do
//
//     final TopSellingitems = topSellingitemsFromJson(jsonString);

import 'dart:convert';

List<TopSellingitems> topSellingitemsFromJson(String str) =>
    List<TopSellingitems>.from(
        json.decode(str).map((x) => TopSellingitems.fromJson(x)));

String topSellingitemsToJson(TopSellingitems data) =>
    json.encode(data.toJson());

class TopSellingitems {
  TopSellingitems({
    required this.data,
  });

  List<Datum> data;

  factory TopSellingitems.fromJson(Map<String, dynamic> json) =>
      TopSellingitems(
          data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {"data": List<dynamic>.from(data.map((x) => x.toJson()))};
}

class Datum {
  Datum({
    required this.itemId,
    required this.itemName,
    required this.salesPrice,
    required this.mrp,
    required this.uom,
    required this.itemcount,
    required this.totalSale,
  });

  int? itemId;
  String? itemName;
  double? salesPrice;
  double? mrp;
  String? uom;
  int? itemcount;
  double? totalSale;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        itemId: json["ItemId"],
        itemName: json["ItemName"],
        salesPrice: json["SalesPrice"].toDouble(),
        mrp: json["MRP"] == null ? null : json["MRP"].toDouble(),
        uom: json["UOM"],
        itemcount: json["itemcount"],
        totalSale:
            json["TotalSale"] == null ? null : json["TotalSale"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "ItemId": itemId,
        "ItemName": itemName,
        "SalesPrice": salesPrice,
        "MRP": mrp,
        "UOM": uom,
        "itemcount": itemcount,
        "TotalSale": totalSale,
      };
}
