// To parse this JSON data, do
//
//     final totalOutstanding = totalOutstandingFromJson(jsonString);

import 'dart:convert';

List<TotalOutstanding> totalOutstandingFromJson(String str) =>
    List<TotalOutstanding>.from(
        json.decode(str).map((x) => TotalOutstanding.fromJson(x)));

String totalOutstandingToJson(List<TotalOutstanding> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalOutstanding {
  TotalOutstanding({
    required this.data,
  });

  List<Datum> data;

  factory TotalOutstanding.fromJson(Map<String, dynamic> json) =>
      TotalOutstanding(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.partyId,
    required this.partyName,
    required this.sumDebit,
    required this.sumCredit,
    required this.sumClosing,
  });

  int partyId;
  String partyName;
  double sumDebit;
  double sumCredit;
  double sumClosing;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        partyId: json["PartyId"],
        partyName: json["PartyName"],
        sumDebit: json["sum(Debit)"].toDouble(),
        sumCredit: json["sum(Credit)"].toDouble(),
        sumClosing: json["sum(Closing)"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "PartyId": partyId,
        "PartyName": partyName,
        "sum(Debit)": sumDebit,
        "sum(Credit)": sumCredit,
        "sum(Closing)": sumClosing,
      };
}

List<OverdueDays> overdueDaysFromJson(String str) => List<OverdueDays>.from(
    json.decode(str).map((x) => OverdueDays.fromJson(x)));

String overdueDaysToJson(List<OverdueDays> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OverdueDays {
  OverdueDays({required this.data});

  List<DueData> data;

  factory OverdueDays.fromJson(Map<String, dynamic> json) => OverdueDays(
        data: List<DueData>.from(json["data"].map((x) => DueData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DueData {
  DueData({
    required this.overdueDays,
  });

  int overdueDays;

  factory DueData.fromJson(Map<String, dynamic> json) => DueData(
        overdueDays: json["OverdueDays"],
      );

  Map<String, dynamic> toJson() => {
        "OverdueDays": overdueDays,
      };
}
