// To parse this JSON data, do
//
//     final partiallyCompleteModel = partiallyCompleteModelFromJson(jsonString);

import 'dart:convert';

PartiallyCompleteModel partiallyCompleteModelFromJson(String str) => PartiallyCompleteModel.fromJson(json.decode(str));

String partiallyCompleteModelToJson(PartiallyCompleteModel data) => json.encode(data.toJson());

class PartiallyCompleteModel {
    PartiallyCompleteModel({
        this.finishedGoods,
        this.purchaseOrder,
        this.orderIdentification,
        this.cablePartNumber,
        this.cutLength,
    });

    int finishedGoods;
    String purchaseOrder;
    String orderIdentification;
    String cablePartNumber;
    String cutLength;

    factory PartiallyCompleteModel.fromJson(Map<String, dynamic> json) => PartiallyCompleteModel(
        finishedGoods: json["finishedGoods"],
        purchaseOrder: json["purchaseOrder"],
        orderIdentification: json["orderIdentification"],
        cablePartNumber: json["cablePartNumber"],
        cutLength: json["cutLength"],
    );

    Map<String, dynamic> toJson() => {
        "finishedGoods": finishedGoods,
        "purchaseOrder": purchaseOrder,
        "orderIdentification": orderIdentification,
        "cablePartNumber": cablePartNumber,
        "cutLength": cutLength,
    };
}
