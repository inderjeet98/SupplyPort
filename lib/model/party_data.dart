// To parse this JSON data, do
//
//     final partyData = partyDataFromJson(jsonString);

import 'dart:convert';

List<PartyData?>? partyDataFromJson(String str) => json.decode(str) == null
    ? []
    : List<PartyData?>.from(
        json.decode(str)!.map((x) => PartyData.fromJson(x)));

String partyDataToJson(List<PartyData?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class PartyData {
  PartyData({this.data});

  List<Datum?>? data;

  factory PartyData.fromJson(Map<String, dynamic> json) => PartyData(
      data: json["data"] == null
          ? []
          : List<Datum?>.from(json["data"]!.map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x!.toJson())),
      };
}

class Datum {
  Datum({
    this.companyId,
    this.partyId,
    this.partyRefId,
    this.partyName,
    this.shortName,
    this.fatherName,
    this.partyType,
    this.active,
    this.status,
    this.partyGroupId,
    this.partyCategory,
    this.territoryId,
    this.commisionId,
    this.creditLimit,
    this.creditDays,
    this.pmtTermsId,
    this.currencyId,
    this.accountId,
    this.description,
    this.remarks,
    this.perAdd1,
    this.perAdd2,
    this.perCity,
    this.perState,
    this.perCountryId,
    this.perZip,
    this.perTelephone,
    this.perTelex,
    this.perFax,
    this.perEmail,
    this.website,
    this.corrAdd1,
    this.corrAdd2,
    this.corrCity,
    this.corrState,
    this.corrCountryId,
    this.corrZip,
    this.corrTelephone,
    this.corrTelex,
    this.corrFax,
    this.corrEmail,
    this.currentAdd1,
    this.currentAdd2,
    this.currentCity,
    this.currentState,
    this.currentCountryId,
    this.currentZip,
    this.currentTelephone,
    this.currentTelex,
    this.currentFax,
    this.currentEmail,
    this.bankId,
    this.bankBranchId,
    this.bankAccNo,
    this.createdBy,
    this.createdDate,
    this.modifyBy,
    this.modifyDate,
    this.yrsOfRelation,
    this.entitiyAttr1,
    this.entitiyAttr2,
    this.entitiyAttr3,
    this.entitiyAttr4,
    this.entitiyAttr5,
    this.entitiyAttr6,
    this.entitiyAttr7,
    this.entitiyAttr8,
    this.entitiyAttr9,
    this.entitiyAttr10,
    this.ref1,
    this.ref2,
    this.ref3,
    this.ref4,
    this.ref5,
    this.ref6,
    this.ref7,
    this.ref8,
    this.ref9,
    this.ref10,
    this.promoCode,
    this.location,
    this.latitude,
    this.longitude,
    this.routeName,
    this.routeSeq,
    this.mobileNo,
    this.contactPerson,
    this.registrationNo,
    this.taxNo,
    this.vatNo,
    this.tinNo,
    this.exportRefNo,
    this.stateCd,
    this.identityNo,
    this.consigneeRefId,
    this.transporterId,
    this.agentId,
    this.executiveId,
    this.portalPassword,
    this.activeDate,
    this.priceList,
    this.supplierCategory,
    this.customerCategory,
    this.priceListName,
    this.partyGroupName,
    this.termName,
  });

  String? companyId;
  int? partyId;
  String? partyRefId;
  String? partyName;
  dynamic shortName;
  dynamic fatherName;
  String? partyType;
  String? active;
  String? status;
  String? partyGroupId;
  String? partyCategory;
  String? territoryId;
  dynamic commisionId;
  dynamic creditLimit;
  dynamic creditDays;
  String? pmtTermsId;
  String? currencyId;
  dynamic accountId;
  dynamic description;
  dynamic remarks;
  String? perAdd1;
  String? perAdd2;
  String? perCity;
  String? perState;
  String? perCountryId;
  dynamic perZip;
  String? perTelephone;
  dynamic perTelex;
  dynamic perFax;
  dynamic perEmail;
  dynamic website;
  String? corrAdd1;
  String? corrAdd2;
  String? corrCity;
  String? corrState;
  String? corrCountryId;
  dynamic corrZip;
  String? corrTelephone;
  dynamic corrTelex;
  dynamic corrFax;
  dynamic corrEmail;
  String? currentAdd1;
  String? currentAdd2;
  String? currentCity;
  String? currentState;
  String? currentCountryId;
  dynamic currentZip;
  dynamic currentTelephone;
  dynamic currentTelex;
  dynamic currentFax;
  dynamic currentEmail;
  String? bankId;
  String? bankBranchId;
  String? bankAccNo;
  int? createdBy;
  DateTime? createdDate;
  dynamic modifyBy;
  dynamic modifyDate;
  dynamic yrsOfRelation;
  dynamic entitiyAttr1;
  dynamic entitiyAttr2;
  dynamic entitiyAttr3;
  dynamic entitiyAttr4;
  dynamic entitiyAttr5;
  dynamic entitiyAttr6;
  dynamic entitiyAttr7;
  dynamic entitiyAttr8;
  dynamic entitiyAttr9;
  dynamic entitiyAttr10;
  dynamic ref1;
  dynamic ref2;
  dynamic ref3;
  dynamic ref4;
  dynamic ref5;
  dynamic ref6;
  dynamic ref7;
  dynamic ref8;
  dynamic ref9;
  dynamic ref10;
  dynamic promoCode;
  dynamic location;
  dynamic latitude;
  dynamic longitude;
  dynamic routeName;
  dynamic routeSeq;
  String? mobileNo;
  String? contactPerson;
  dynamic registrationNo;
  dynamic taxNo;
  String? vatNo;
  dynamic tinNo;
  dynamic exportRefNo;
  dynamic stateCd;
  dynamic identityNo;
  dynamic consigneeRefId;
  dynamic transporterId;
  dynamic agentId;
  dynamic executiveId;
  dynamic portalPassword;
  dynamic activeDate;
  dynamic priceList;
  String? supplierCategory;
  dynamic customerCategory;
  dynamic priceListName;
  String? partyGroupName;
  dynamic termName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        companyId: json["CompanyId"],
        partyId: json["PartyId"],
        partyRefId: json["PartyRefId"],
        partyName: json["PartyName"],
        shortName: json["ShortName"],
        fatherName: json["FatherName"],
        partyType: json["PartyType"],
        active: json["Active"],
        status: json["Status"],
        partyGroupId: json["PartyGroupId"],
        partyCategory: json["PartyCategory"],
        territoryId: json["TerritoryId"],
        commisionId: json["CommisionId"],
        creditLimit: json["CreditLimit"],
        creditDays: json["CreditDays"],
        pmtTermsId: json["PmtTermsId"],
        currencyId: json["CurrencyId"],
        accountId: json["AccountId"],
        description: json["Description"],
        remarks: json["Remarks"],
        perAdd1: json["PerAdd1"],
        perAdd2: json["PerAdd2"],
        perCity: json["PerCity"],
        perState: json["PerState"],
        perCountryId: json["PerCountryId"],
        perZip: json["PerZip"],
        perTelephone: json["PerTelephone"],
        perTelex: json["PerTelex"],
        perFax: json["PerFax"],
        perEmail: json["PerEmail"],
        website: json["website"],
        corrAdd1: json["CorrAdd1"],
        corrAdd2: json["CorrAdd2"],
        corrCity: json["CorrCity"],
        corrState: json["CorrState"],
        corrCountryId: json["CorrCountryId"],
        corrZip: json["CorrZip"],
        corrTelephone: json["CorrTelephone"],
        corrTelex: json["CorrTelex"],
        corrFax: json["CorrFax"],
        corrEmail: json["CorrEmail"],
        currentAdd1: json["CurrentAdd1"],
        currentAdd2: json["CurrentAdd2"],
        currentCity: json["CurrentCity"],
        currentState: json["CurrentState"],
        currentCountryId: json["CurrentCountryId"],
        currentZip: json["CurrentZip"],
        currentTelephone: json["CurrentTelephone"],
        currentTelex: json["CurrentTelex"],
        currentFax: json["CurrentFax"],
        currentEmail: json["CurrentEmail"],
        bankId: json["BankId"],
        bankBranchId: json["BankBranchId"],
        bankAccNo: json["BankAccNo"],
        createdBy: json["CreatedBy"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        modifyBy: json["ModifyBy"],
        modifyDate: json["ModifyDate"],
        yrsOfRelation: json["YrsOfRelation"],
        entitiyAttr1: json["EntitiyAttr1"],
        entitiyAttr2: json["EntitiyAttr2"],
        entitiyAttr3: json["EntitiyAttr3"],
        entitiyAttr4: json["EntitiyAttr4"],
        entitiyAttr5: json["EntitiyAttr5"],
        entitiyAttr6: json["EntitiyAttr6"],
        entitiyAttr7: json["EntitiyAttr7"],
        entitiyAttr8: json["EntitiyAttr8"],
        entitiyAttr9: json["EntitiyAttr9"],
        entitiyAttr10: json["EntitiyAttr10"],
        ref1: json["Ref1"],
        ref2: json["Ref2"],
        ref3: json["Ref3"],
        ref4: json["Ref4"],
        ref5: json["Ref5"],
        ref6: json["Ref6"],
        ref7: json["Ref7"],
        ref8: json["Ref8"],
        ref9: json["Ref9"],
        ref10: json["Ref10"],
        promoCode: json["PromoCode"],
        location: json["Location"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        routeName: json["RouteName"],
        routeSeq: json["RouteSeq"],
        mobileNo: json["MobileNo"],
        contactPerson: json["ContactPerson"],
        registrationNo: json["RegistrationNo"],
        taxNo: json["TaxNo"],
        vatNo: json["VatNo"],
        tinNo: json["TinNo"],
        exportRefNo: json["ExportRefNo"],
        stateCd: json["StateCd"],
        identityNo: json["IdentityNo"],
        consigneeRefId: json["ConsigneeRefId"],
        transporterId: json["TransporterId"],
        agentId: json["AgentId"],
        executiveId: json["ExecutiveId"],
        portalPassword: json["PortalPassword"],
        activeDate: json["ActiveDate"],
        priceList: json["PriceList"],
        supplierCategory: json["SupplierCategory"],
        customerCategory: json["CustomerCategory"],
        priceListName: json["PriceListName"],
        partyGroupName: json["PartyGroupName"],
        termName: json["TermName"],
      );

  Map<String, dynamic> toJson() => {
        "CompanyId": companyId,
        "PartyId": partyId,
        "PartyRefId": partyRefId,
        "PartyName": partyName,
        "ShortName": shortName,
        "FatherName": fatherName,
        "PartyType": partyType,
        "Active": active,
        "Status": status,
        "PartyGroupId": partyGroupId,
        "PartyCategory": partyCategory,
        "TerritoryId": territoryId,
        "CommisionId": commisionId,
        "CreditLimit": creditLimit,
        "CreditDays": creditDays,
        "PmtTermsId": pmtTermsId,
        "CurrencyId": currencyId,
        "AccountId": accountId,
        "Description": description,
        "Remarks": remarks,
        "PerAdd1": perAdd1,
        "PerAdd2": perAdd2,
        "PerCity": perCity,
        "PerState": perState,
        "PerCountryId": perCountryId,
        "PerZip": perZip,
        "PerTelephone": perTelephone,
        "PerTelex": perTelex,
        "PerFax": perFax,
        "PerEmail": perEmail,
        "website": website,
        "CorrAdd1": corrAdd1,
        "CorrAdd2": corrAdd2,
        "CorrCity": corrCity,
        "CorrState": corrState,
        "CorrCountryId": corrCountryId,
        "CorrZip": corrZip,
        "CorrTelephone": corrTelephone,
        "CorrTelex": corrTelex,
        "CorrFax": corrFax,
        "CorrEmail": corrEmail,
        "CurrentAdd1": currentAdd1,
        "CurrentAdd2": currentAdd2,
        "CurrentCity": currentCity,
        "CurrentState": currentState,
        "CurrentCountryId": currentCountryId,
        "CurrentZip": currentZip,
        "CurrentTelephone": currentTelephone,
        "CurrentTelex": currentTelex,
        "CurrentFax": currentFax,
        "CurrentEmail": currentEmail,
        "BankId": bankId,
        "BankBranchId": bankBranchId,
        "BankAccNo": bankAccNo,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate?.toIso8601String(),
        "ModifyBy": modifyBy,
        "ModifyDate": modifyDate,
        "YrsOfRelation": yrsOfRelation,
        "EntitiyAttr1": entitiyAttr1,
        "EntitiyAttr2": entitiyAttr2,
        "EntitiyAttr3": entitiyAttr3,
        "EntitiyAttr4": entitiyAttr4,
        "EntitiyAttr5": entitiyAttr5,
        "EntitiyAttr6": entitiyAttr6,
        "EntitiyAttr7": entitiyAttr7,
        "EntitiyAttr8": entitiyAttr8,
        "EntitiyAttr9": entitiyAttr9,
        "EntitiyAttr10": entitiyAttr10,
        "Ref1": ref1,
        "Ref2": ref2,
        "Ref3": ref3,
        "Ref4": ref4,
        "Ref5": ref5,
        "Ref6": ref6,
        "Ref7": ref7,
        "Ref8": ref8,
        "Ref9": ref9,
        "Ref10": ref10,
        "PromoCode": promoCode,
        "Location": location,
        "Latitude": latitude,
        "Longitude": longitude,
        "RouteName": routeName,
        "RouteSeq": routeSeq,
        "MobileNo": mobileNo,
        "ContactPerson": contactPerson,
        "RegistrationNo": registrationNo,
        "TaxNo": taxNo,
        "VatNo": vatNo,
        "TinNo": tinNo,
        "ExportRefNo": exportRefNo,
        "StateCd": stateCd,
        "IdentityNo": identityNo,
        "ConsigneeRefId": consigneeRefId,
        "TransporterId": transporterId,
        "AgentId": agentId,
        "ExecutiveId": executiveId,
        "PortalPassword": portalPassword,
        "ActiveDate": activeDate,
        "PriceList": priceList,
        "SupplierCategory": supplierCategory,
        "CustomerCategory": customerCategory,
        "PriceListName": priceListName,
        "PartyGroupName": partyGroupName,
        "TermName": termName,
      };
}
