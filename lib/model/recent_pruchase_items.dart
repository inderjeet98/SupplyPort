// To parse this JSON data, do
//
//     final RecentPurchaseItems = welcomeFromJson(jsonString);

import 'dart:convert';

List<RecentPurchaseItems> recentPurchaseItemsFromJson(String str) =>
    List<RecentPurchaseItems>.from(
        json.decode(str).map((x) => RecentPurchaseItems.fromJson(x)));

String recentPurchaseItemsToJson(List<RecentPurchaseItems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentPurchaseItems {
  RecentPurchaseItems({
    required this.data,
  });

  List<Datum> data;

  factory RecentPurchaseItems.fromJson(Map<String, dynamic> json) =>
      RecentPurchaseItems(
          data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {"data": List<dynamic>.from(data.map((x) => x.toJson()))};
}

class Datum {
  Datum({
    required this.itemId,
    required this.itemName,
    required this.salesPrice,
    required this.docDate,
    required this.mrp,
    required this.uom,
  });

  int? itemId;
  String? itemName;
  double? salesPrice, mrp;
  String? uom;
  DateTime docDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        itemId: json["ItemId"],
        itemName: json["ItemName"],
        salesPrice: json["SalesPrice"].toDouble(),
        docDate: DateTime.parse(json["DocDate"]),
        mrp: json["MRP"] == null ? null : json["MRP"].toDouble(),
        uom: json["UOM"] == null ? null : json["UOM"],
      );

  Map<String, dynamic> toJson() => {
        "ItemId": itemId,
        "ItemName": itemName,
        "SalesPrice": salesPrice,
        "DocDate": docDate.toIso8601String(),
        "MRP": mrp == null ? null : mrp,
        "UOM": uom == null ? null : uom,
      };
}
