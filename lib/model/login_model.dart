// To parse this JSON data, do
//
//     final loginData = loginDataFromJson(jsonString);

import 'dart:convert';

List<LoginData> loginDataFromJson(String str) =>
    List<LoginData>.from(json.decode(str).map((x) => LoginData.fromJson(x)));

String loginDataToJson(List<LoginData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginData {
  LoginData({
    required this.data,
  });

  List<Datum> data;

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.partyName,
    required this.partyId,
    required this.mobileNo,
  });

  String partyName;
  int partyId;
  String mobileNo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        partyName: json["PartyName"],
        partyId: json["PartyId"],
        mobileNo: json["MobileNo"],
      );

  Map<String, dynamic> toJson() => {
        "PartyName": partyName,
        "PartyId": partyId,
        "MobileNo": mobileNo,
      };
}
