// To parse this JSON data, do
//
//     final overdueAmount = overdueAmountFromJson(jsonString);

import 'dart:convert';

List<OverdueAmount> overdueAmountFromJson(String str) =>
    List<OverdueAmount>.from(
        json.decode(str).map((x) => OverdueAmount.fromJson(x)));

String overdueAmountToJson(List<OverdueAmount> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OverdueAmount {
  OverdueAmount({required this.data});

  List<Datum> data;

  factory OverdueAmount.fromJson(Map<String, dynamic> json) => OverdueAmount(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.accountId,
    required this.partyId,
    required this.partyName,
    required this.dueAmount,
  });

  String accountId;
  int partyId;
  String partyName;
  double dueAmount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        accountId: json["AccountId"],
        partyId: json["PartyId"],
        partyName: json["PartyName"],
        dueAmount:
            // ignore: prefer_null_aware_operators
            json["DueAmount"] == null ? null : json["DueAmount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "AccountId": accountId,
        "PartyId": partyId,
        "PartyName": partyName,
        "DueAmount": dueAmount,
      };
}
