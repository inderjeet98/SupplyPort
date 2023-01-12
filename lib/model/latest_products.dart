import 'dart:convert';

List<LatestProducts> latestProductsFromJson(String str) =>
    List<LatestProducts>.from(
        json.decode(str).map((x) => LatestProducts.fromJson(x)));

String latestProductsToJson(List<LatestProducts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LatestProducts {
  LatestProducts({required this.data});

  List<Datum> data;

  factory LatestProducts.fromJson(Map<String, dynamic> json) => LatestProducts(
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.itemName,
    required this.itemId,
    required this.category,
    required this.source,
    required this.salesUom,
    required this.stdRate,
    required this.salesPrice,
    this.mrp,
    required this.hsnCode,
    required this.salesTaxGroupId,
  });

  String itemName;
  int itemId;
  String? category;
  String? source;
  String? salesUom;
  double? stdRate;
  double? salesPrice;
  double? mrp;
  int hsnCode;
  String? salesTaxGroupId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        itemName: json["ItemName"],
        itemId: json["ItemId"],
        category: json["Category"] ?? null,
        source: json["Source"] == null ? null : json["Source"],
        salesUom: json["SalesUom"] == null ? null : json["SalesUom"],
        stdRate: json["StdRate"] == null ? null : json["StdRate"].toDouble(),
        salesPrice:
            json["SalesPrice"] == null ? null : json["SalesPrice"].toDouble(),
        mrp: json["MRP"] == null ? null : json["MRP"].toDouble(),
        hsnCode: json["HsnCode"],
        salesTaxGroupId:
            json["SalesTaxGroupId"] == null ? null : json["SalesTaxGroupId"],
      );

  Map<String, dynamic> toJson() => {
        "ItemName": itemName,
        "ItemId": itemId,
        "Category": category == null ? null : category,
        "Source": source == null ? null : source,
        "SalesUom": salesUom,
        "StdRate": stdRate,
        "SalesPrice": salesPrice,
        "MRP": mrp,
        "HsnCode": hsnCode,
        "SalesTaxGroupId": salesTaxGroupId,
      };
}
