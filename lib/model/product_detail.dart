// To parse this JSON data, do
//
//     final productDetail = productDetailsFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, unnecessary_null_in_if_null_operators

import 'dart:convert';

List<ProductDetail> productDetailFromJson(String str) =>
    List<ProductDetail>.from(
        json.decode(str).map((x) => ProductDetail.fromJson(x)));

String productDetailToJson(List<ProductDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDetail {
  ProductDetail({required this.data});

  List<Datum> data;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.companyId,
    required this.itemId,
    required this.itemRefId,
    required this.itemName,
    required this.shortName,
    this.aliasName,
    this.serialNo,
    this.pnNo,
    this.partNo,
    this.catalogNo,
    this.specifications,
    this.description,
    this.remarks,
    required this.itemGroupId,
    required this.type,
    required this.category,
    required this.source,
    required this.purpose,
    required this.status,
    required this.stockable,
    required this.salesItem,
    required this.purItem,
    required this.fixedAssets,
    required this.warantyItem,
    required this.foc,
    required this.expiry,
    required this.shelfLife,
    required this.weighable,
    required this.active,
    required this.stockUom,
    required this.salesUom,
    required this.purUom,
    this.purToStockConv,
    this.salesToStockConv,
    this.warantyStDate,
    this.warantyEndDate,
    this.packDesc,
    this.packQty,
    this.packQtyVar,
    this.packDimLength,
    this.packDimWidth,
    this.packDimHeight,
    this.packVol,
    this.packWeight,
    this.packGrossWeight,
    required this.stdRate,
    required this.salesPrice,
    this.mrp,
    this.itemCost,
    this.defaultSupp,
    required this.salesTaxGroupId,
    this.salesTaxRate,
    required this.purTaxGroupId,
    this.purTaxRate,
    required this.minLvlStkQty,
    this.safetyStkQty,
    this.reorderQty,
    this.orderFreq,
    this.leadTimeInDays,
    this.abcClass,
    this.fsnClass,
    this.vedClass,
    this.stkValueScheme,
    this.issueScheme,
    required this.issueFullLot,
    required this.createdBy,
    required this.createdDate,
    this.modifyBy,
    this.modifyDate,
    required this.stkAccount,
    required this.purAccount,
    required this.salesAccount,
    this.consAccount,
    this.varrienceAccount,
    this.itemSalesBarCode,
    this.itemPurBarCode,
    required this.packReturnable,
    this.packCost,
    required this.hsnCode,
    this.itemAttrValue1,
    this.itemAttrValue2,
    this.itemAttrValue3,
    this.itemAttrValue4,
    this.itemAttrValue5,
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
    this.info1,
    this.info2,
    this.info3,
    this.info4,
    this.info5,
    required this.lotgenertionYn,
    required this.brand,
    this.prodBaseQty,
    this.routingName,
    required this.subCategory,
    required this.productLine1,
    required this.productLine2,
    required this.secondaryUom,
    this.maxLevel,
    this.piece,
    this.size,
    this.design,
    this.colour,
    this.gender,
    this.modelNo,
    this.manufactureCode,
    this.delivery,
    this.launchDate,
    this.discontinuedDate,
    this.substitute,
    this.specification2,
    this.specification3,
    this.specification4,
    this.specification5,
    this.testPlan,
    required this.convFactor,
  });

  String? companyId;
  int itemId;
  String? itemRefId;
  String? itemName;
  String? shortName;
  dynamic aliasName;
  dynamic serialNo;
  dynamic pnNo;
  dynamic partNo;
  dynamic catalogNo;
  dynamic specifications;
  dynamic description;
  dynamic remarks;
  String? itemGroupId;
  String? type;
  String? category;
  String? source;
  dynamic purpose;
  String? status;
  String? stockable;
  String? salesItem;
  String? purItem;
  String? fixedAssets;
  String? warantyItem;
  String? foc;
  String? expiry;
  dynamic shelfLife;
  String? weighable;
  String? active;
  String? stockUom;
  String? salesUom;
  String? purUom;
  dynamic purToStockConv;
  dynamic salesToStockConv;
  dynamic warantyStDate;
  dynamic warantyEndDate;
  dynamic packDesc;
  dynamic packQty;
  dynamic packQtyVar;
  dynamic packDimLength;
  dynamic packDimWidth;
  dynamic packDimHeight;
  dynamic packVol;
  dynamic packWeight;
  dynamic packGrossWeight;
  double stdRate;
  double salesPrice;
  dynamic mrp;
  dynamic itemCost;
  dynamic defaultSupp;
  String? salesTaxGroupId;
  dynamic salesTaxRate;
  String? purTaxGroupId;
  dynamic purTaxRate;
  int? minLvlStkQty;
  dynamic safetyStkQty;
  dynamic reorderQty;
  dynamic orderFreq;
  dynamic leadTimeInDays;
  dynamic abcClass;
  dynamic fsnClass;
  dynamic vedClass;
  dynamic stkValueScheme;
  dynamic issueScheme;
  String? issueFullLot;
  int? createdBy;
  DateTime createdDate;
  int? modifyBy;
  DateTime? modifyDate;
  int? stkAccount;
  dynamic purAccount;
  int? salesAccount;
  dynamic consAccount;
  dynamic varrienceAccount;
  dynamic itemSalesBarCode;
  dynamic itemPurBarCode;
  String? packReturnable;
  dynamic packCost;
  int? hsnCode;
  dynamic itemAttrValue1;
  dynamic itemAttrValue2;
  dynamic itemAttrValue3;
  dynamic itemAttrValue4;
  dynamic itemAttrValue5;
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
  dynamic info1;
  dynamic info2;
  dynamic info3;
  dynamic info4;
  dynamic info5;
  String? lotgenertionYn;
  String? brand;
  dynamic prodBaseQty;
  dynamic routingName;
  String? subCategory;
  String? productLine1;
  String? productLine2;
  String? secondaryUom;
  dynamic maxLevel;
  dynamic piece;
  dynamic size;
  dynamic design;
  dynamic colour;
  dynamic gender;
  dynamic modelNo;
  dynamic manufactureCode;
  dynamic delivery;
  dynamic launchDate;
  dynamic discontinuedDate;
  dynamic substitute;
  dynamic specification2;
  dynamic specification3;
  dynamic specification4;
  dynamic specification5;
  dynamic testPlan;
  int? convFactor;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        companyId: json["CompanyId"] == null ? null : json["CompanyId"],
        itemId: json["ItemId"] == null ? null : json["ItemId"],
        itemRefId: json["ItemRefId"] == null ? null : json["ItemRefId"],
        itemName: json["ItemName"] == null ? null : json["ItemName"],
        shortName: json["ShortName"] == null ? null : json["ShortName"],
        aliasName: json["AliasName"] == null ? null : json["AliasName"],
        serialNo: json["SerialNo"] == null ? null : json["SerialNo"],
        pnNo: json["PnNo"] == null ? null : json["PnNo"],
        partNo: json["PartNo"] == null ? null : json["PartNo"],
        catalogNo: json["CatalogNo"] == null ? null : json["CatalogNo"],
        specifications:
            json["Specifications"] == null ? null : json["Specifications"],
        description: json["Description"] == null ? null : json["Description"],
        remarks: json["Remarks"] == null ? null : json["Remarks"],
        itemGroupId: json["itemGroupId"] == null ? null : json["itemGroupId"],
        type: json["Type"] == null ? null : json["Type"],
        category: json["Category"] == null ? null : json["Category"],
        source: json["Source"] == null ? null : json["Source"],
        purpose: json["Purpose"] == null ? null : json["Purpose"],
        status: json["Status"] == null ? null : json["Status"],
        stockable: json["Stockable"] == null ? null : json["Stockable"],
        salesItem: json["SalesItem"] == null ? null : json["SalesItem"],
        purItem: json["PurItem"] == null ? null : json["PurItem"],
        fixedAssets: json["FixedAssets"] == null ? null : json["FixedAssets"],
        warantyItem: json["WarantyItem"] == null ? null : json["WarantyItem"],
        foc: json["FOC"] == null ? null : json["FOC"],
        expiry: json["Expiry"] == null ? null : json["Expiry"],
        shelfLife: json["ShelfLife"] == null ? null : json["ShelfLife"],
        weighable: json["Weighable"] == null ? null : json["Weighable"],
        active: json["Active"] == null ? null : json["Active"],
        stockUom: json["StockUom"] == null ? null : json["StockUom"],
        salesUom: json["SalesUom"] == null ? ' ' : json["SalesUom"],
        purUom: json["PurUom"] == null ? null : json["PurUom"],
        purToStockConv:
            json["PurToStockConv"] == null ? null : json["PurToStockConv"],
        salesToStockConv:
            json["SalesToStockConv"] == null ? null : json["SalesToStockConv"],
        warantyStDate:
            json["WarantyStDate"] == null ? null : json["WarantyStDate"],
        warantyEndDate:
            json["WarantyEndDate"] == null ? null : json["WarantyEndDate"],
        packDesc: json["PackDesc"] == null ? null : json["PackDesc"],
        packQty: json["PackQty"] == null ? null : json["PackQty"],
        packQtyVar: json["PackQtyVar"] == null ? null : json["PackQtyVar"],
        packDimLength:
            json["PackDimLength"] == null ? null : json["PackDimLength"],
        packDimWidth:
            json["PackDimWidth"] == null ? null : json["PackDimWidth"],
        packDimHeight:
            json["PackDimHeight"] == null ? null : json["PackDimHeight"],
        packVol: json["PackVol"] == null ? null : json["PackVol"],
        packWeight: json["PackWeight"] == null ? null : json["PackWeight"],
        packGrossWeight:
            json["PackGrossWeight"] == null ? null : json["PackGrossWeight"],
        stdRate: json["StdRate"].toDouble() == null
            ? null
            : json["StdRate"].toDouble(),
        salesPrice: json["SalesPrice"].toDouble() == null
            ? null
            : json["SalesPrice"].toDouble(),
        mrp: json["MRP"] == null ? 0 : json["MRP"],
        itemCost: json["ItemCost"] == null ? null : json["ItemCost"],
        defaultSupp: json["DefaultSupp"] == null ? null : json["DefaultSupp"],
        salesTaxGroupId:
            json["SalesTaxGroupId"] == null ? null : json["SalesTaxGroupId"],
        salesTaxRate:
            json["SalesTaxRate"] == null ? null : json["SalesTaxRate"],
        purTaxGroupId:
            json["PurTaxGroupId"] == null ? null : json["PurTaxGroupId"],
        purTaxRate: json["PurTaxRate"] == null ? null : json["PurTaxRate"],
        minLvlStkQty:
            json["MinLvlStkQty"] == null ? null : json["MinLvlStkQty"],
        safetyStkQty:
            json["SafetyStkQty"] == null ? null : json["SafetyStkQty"],
        reorderQty: json["ReorderQty"] == null ? null : json["ReorderQty"],
        orderFreq: json["OrderFreq"] == null ? null : json["OrderFreq"],
        leadTimeInDays:
            json["LeadTimeInDays"] == null ? null : json["LeadTimeInDays"],
        abcClass: json["ABCClass"] == null ? null : json["ABCClass"],
        fsnClass: json["FSNClass"] == null ? null : json["FSNClass"],
        vedClass: json["VEDClass"] == null ? null : json["VEDClass"],
        stkValueScheme:
            json["StkValueScheme"] == null ? null : json["StkValueScheme"],
        issueScheme: json["IssueScheme"] == null ? null : json["IssueScheme"],
        issueFullLot:
            json["IssueFullLot"] == null ? null : json["IssueFullLot"],
        createdBy: json["CreatedBy"] == null ? null : json["CreatedBy"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        modifyBy: json["ModifyBy"],
        modifyDate: DateTime.parse(json["ModifyDate"]) ?? null,
        stkAccount: json["StkAccount"] == null ? null : json["StkAccount"],
        purAccount: json["PurAccount"] == null ? null : json["PurAccount"],
        salesAccount:
            json["SalesAccount"] == null ? null : json["SalesAccount"],
        consAccount: json["ConsAccount"] == null ? null : json["ConsAccount"],
        varrienceAccount:
            json["VarrienceAccount"] == null ? null : json["VarrienceAccount"],
        itemSalesBarCode:
            json["ItemSalesBarCode"] == null ? null : json["ItemSalesBarCode"],
        itemPurBarCode:
            json["ItemPurBarCode"] == null ? null : json["ItemPurBarCode"],
        packReturnable:
            json["PackReturnable"] == null ? null : json["PackReturnable"],
        packCost: json["PackCost"] == null ? null : json["PackCost"],
        hsnCode: json["HsnCode"] == null ? null : json["HsnCode"],
        itemAttrValue1:
            json["ItemAttrValue1"] == null ? null : json["ItemAttrValue1"],
        itemAttrValue2:
            json["ItemAttrValue2"] == null ? null : json["ItemAttrValue2"],
        itemAttrValue3:
            json["ItemAttrValue3"] == null ? null : json["ItemAttrValue3"],
        itemAttrValue4:
            json["ItemAttrValue4"] == null ? null : json["ItemAttrValue4"],
        itemAttrValue5:
            json["ItemAttrValue5"] == null ? null : json["ItemAttrValue5"],
        entitiyAttr1:
            json["EntitiyAttr1"] == null ? null : json["EntitiyAttr1"],
        entitiyAttr2:
            json["EntitiyAttr2"] == null ? null : json["EntitiyAttr2"],
        entitiyAttr3:
            json["EntitiyAttr3"] == null ? null : json["EntitiyAttr3"],
        entitiyAttr4:
            json["EntitiyAttr4"] == null ? null : json["EntitiyAttr4"],
        entitiyAttr5:
            json["EntitiyAttr5"] == null ? null : json["EntitiyAttr5"],
        entitiyAttr6:
            json["EntitiyAttr6"] == null ? null : json["EntitiyAttr6"],
        entitiyAttr7:
            json["EntitiyAttr7"] == null ? null : json["EntitiyAttr7"],
        entitiyAttr8:
            json["EntitiyAttr8"] == null ? null : json["EntitiyAttr8"],
        entitiyAttr9:
            json["EntitiyAttr9"] == null ? null : json["EntitiyAttr9"],
        entitiyAttr10:
            json["EntitiyAttr10"] == null ? null : json["EntitiyAttr10"],
        info1: json["Info1"] == null ? null : json["Info1"],
        info2: json["Info2"] == null ? null : json["Info2"],
        info3: json["Info3"] == null ? null : json["Info3"],
        info4: json["Info4"] == null ? null : json["Info4"],
        info5: json["Info5"] == null ? null : json["Info5"],
        lotgenertionYn:
            json["LotgenertionYN"] == null ? null : json["LotgenertionYN"],
        brand: json["Brand"] == null ? null : json["Brand"],
        prodBaseQty: json["ProdBaseQty"] == null ? null : json["ProdBaseQty"],
        routingName: json["RoutingName"] == null ? null : json["RoutingName"],
        subCategory: json["SubCategory"] == null ? null : json["SubCategory"],
        productLine1:
            json["ProductLine1"] == null ? null : json["ProductLine1"],
        productLine2:
            json["ProductLine2"] == null ? null : json["ProductLine2"],
        secondaryUom: json["SecondaryUOM"] == null ? ' ' : json["SecondaryUOM"],
        maxLevel: json["MaxLevel"] == null ? null : json["MaxLevel"],
        piece: json["Piece"] == null ? null : json["Piece"],
        size: json["Size"] == null ? null : json["Size"],
        design: json["Design"] == null ? null : json["Design"],
        colour: json["Colour"] == null ? null : json["Colour"],
        gender: json["Gender"] == null ? null : json["Gender"],
        modelNo: json["ModelNo"] == null ? null : json["ModelNo"],
        manufactureCode:
            json["ManufactureCode"] == null ? null : json["ManufactureCode"],
        delivery: json["Delivery"] == null ? null : json["Delivery"],
        launchDate: json["LaunchDate"] == null ? null : json["LaunchDate"],
        discontinuedDate:
            json["DiscontinuedDate"] == null ? null : json["DiscontinuedDate"],
        substitute: json["Substitute"] == null ? null : json["Substitute"],
        specification2:
            json["Specification2"] == null ? null : json["Specification2"],
        specification3:
            json["Specification3"] == null ? null : json["Specification3"],
        specification4:
            json["Specification4"] == null ? null : json["Specification4"],
        specification5:
            json["Specification5"] == null ? null : json["Specification5"],
        testPlan: json["TestPlan"] == null ? null : json["TestPlan"],
        convFactor: json["ConvFactor"] == null ? null : json["ConvFactor"],
      );

  Map<String, dynamic> toJson() => {
        "CompanyId": companyId,
        "ItemId": itemId,
        "ItemRefId": itemRefId,
        "ItemName": itemName,
        "ShortName": shortName,
        "AliasName": aliasName,
        "SerialNo": serialNo,
        "PnNo": pnNo,
        "PartNo": partNo,
        "CatalogNo": catalogNo,
        "Specifications": specifications,
        "Description": description,
        "Remarks": remarks,
        "itemGroupId": itemGroupId,
        "Type": type,
        "Category": category,
        "Source": source,
        "Purpose": purpose,
        "Status": status,
        "Stockable": stockable,
        "SalesItem": salesItem,
        "PurItem": purItem,
        "FixedAssets": fixedAssets,
        "WarantyItem": warantyItem,
        "FOC": foc,
        "Expiry": expiry,
        "ShelfLife": shelfLife,
        "Weighable": weighable,
        "Active": active,
        "StockUom": stockUom,
        "SalesUom": salesUom,
        "PurUom": purUom,
        "PurToStockConv": purToStockConv,
        "SalesToStockConv": salesToStockConv,
        "WarantyStDate": warantyStDate,
        "WarantyEndDate": warantyEndDate,
        "PackDesc": packDesc,
        "PackQty": packQty,
        "PackQtyVar": packQtyVar,
        "PackDimLength": packDimLength,
        "PackDimWidth": packDimWidth,
        "PackDimHeight": packDimHeight,
        "PackVol": packVol,
        "PackWeight": packWeight,
        "PackGrossWeight": packGrossWeight,
        "StdRate": stdRate,
        "SalesPrice": salesPrice,
        "MRP": mrp,
        "ItemCost": itemCost,
        "DefaultSupp": defaultSupp,
        "SalesTaxGroupId": salesTaxGroupId,
        "SalesTaxRate": salesTaxRate,
        "PurTaxGroupId": purTaxGroupId,
        "PurTaxRate": purTaxRate,
        "MinLvlStkQty": minLvlStkQty,
        "SafetyStkQty": safetyStkQty,
        "ReorderQty": reorderQty,
        "OrderFreq": orderFreq,
        "LeadTimeInDays": leadTimeInDays,
        "ABCClass": abcClass,
        "FSNClass": fsnClass,
        "VEDClass": vedClass,
        "StkValueScheme": stkValueScheme,
        "IssueScheme": issueScheme,
        "IssueFullLot": issueFullLot,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate.toIso8601String(),
        "ModifyBy": modifyBy,
        "ModifyDate": modifyDate!.toString(),
        "StkAccount": stkAccount,
        "PurAccount": purAccount,
        "SalesAccount": salesAccount,
        "ConsAccount": consAccount,
        "VarrienceAccount": varrienceAccount,
        "ItemSalesBarCode": itemSalesBarCode,
        "ItemPurBarCode": itemPurBarCode,
        "PackReturnable": packReturnable,
        "PackCost": packCost,
        "HsnCode": hsnCode,
        "ItemAttrValue1": itemAttrValue1,
        "ItemAttrValue2": itemAttrValue2,
        "ItemAttrValue3": itemAttrValue3,
        "ItemAttrValue4": itemAttrValue4,
        "ItemAttrValue5": itemAttrValue5,
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
        "Info1": info1,
        "Info2": info2,
        "Info3": info3,
        "Info4": info4,
        "Info5": info5,
        "LotgenertionYN": lotgenertionYn,
        "Brand": brand,
        "ProdBaseQty": prodBaseQty,
        "RoutingName": routingName,
        "SubCategory": subCategory,
        "ProductLine1": productLine1,
        "ProductLine2": productLine2,
        "SecondaryUOM": secondaryUom,
        "MaxLevel": maxLevel,
        "Piece": piece,
        "Size": size,
        "Design": design,
        "Colour": colour,
        "Gender": gender,
        "ModelNo": modelNo,
        "ManufactureCode": manufactureCode,
        "Delivery": delivery,
        "LaunchDate": launchDate,
        "DiscontinuedDate": discontinuedDate,
        "Substitute": substitute,
        "Specification2": specification2,
        "Specification3": specification3,
        "Specification4": specification4,
        "Specification5": specification5,
        "TestPlan": testPlan,
        "ConvFactor": convFactor,
      };
}
