// To parse this JSON data, do
//
//     final PromoOffers = welcomeFromJson(jsonString);

import 'dart:convert';

List<PromoOffers> promoOffersFromJson(String str) => List<PromoOffers>.from(
    json.decode(str).map((x) => PromoOffers.fromJson(x)));

String promoOffersToJson(List<PromoOffers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromoOffers {
  PromoOffers({required this.data});

  List<Datum> data;

  factory PromoOffers.fromJson(Map<String, dynamic> json) => PromoOffers(
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() =>
      {"data": List<dynamic>.from(data.map((x) => x.toJson()))};
}

class Datum {
  Datum({
    required this.offerId,
    required this.offerName,
    required this.offerCode,
    required this.offerDescription,
    required this.offerHighlights,
    required this.offerTerms,
    required this.offerType,
    required this.active,
    required this.validFrom,
    required this.validTill,
    required this.offerItems,
  });

  String? offerId;
  String? offerName;
  String? offerCode;
  String? offerDescription;
  String? offerHighlights;
  String? offerTerms;
  String? offerType;
  String? active;
  DateTime validFrom;
  DateTime validTill;
  String? offerItems;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        offerId: json["OfferId"],
        offerName: json["OfferName"],
        offerCode: json["OfferCode"],
        offerDescription: json["OfferDescription"],
        offerHighlights: json["OfferHighlights"],
        offerTerms: json["OfferTerms"],
        offerType: json["OfferType"],
        active: json["Active"],
        validFrom: DateTime.parse(json["ValidFrom"]),
        validTill: DateTime.parse(json["ValidTill"]),
        offerItems: json["offerItems"],
      );

  Map<String, dynamic> toJson() => {
        "OfferId": offerId,
        "OfferName": offerName,
        "OfferCode": offerCode,
        "OfferDescription": offerDescription,
        "OfferHighlights": offerHighlights,
        "OfferTerms": offerTerms,
        "OfferType": offerType,
        "Active": active,
        "ValidFrom": validFrom.toIso8601String(),
        "ValidTill": validTill.toIso8601String(),
        "offerItems": offerItems,
      };
}

// enum Active { Y }

// final activeValues = EnumValues({
//     "Y": Active.Y
// });

// enum OfferTerms { EMPTY, TERMS_AND_CONDITIONS_APPLIED }

// final offerTermsValues = EnumValues({
//     "": OfferTerms.EMPTY,
//     "TERMS AND CONDITIONS APPLIED": OfferTerms.TERMS_AND_CONDITIONS_APPLIED
// });

// enum OfferType { D }

// final offerTypeValues = EnumValues({
//     "D": OfferType.D
// });

// class Schema {
//     Schema({
//         this.index,
//         this.name,
//         this.type,
//     });

//     int index;
//     String name;
//     Type type;

//     factory Schema.fromJson(Map<String, dynamic> json) => Schema(
//         index: json["index"],
//         name: json["name"],
//         type: typeValues.map[json["type"]],
//     );

//     Map<String, dynamic> toJson() => {
//         "index": index,
//         "name": name,
//         "type": typeValues.reverse[type],
//     };
// }

// enum Type { STRING, DATE_TIME }

// final typeValues = EnumValues({
//     "DateTime": Type.DATE_TIME,
//     "String": Type.STRING
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues( this.map,);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
