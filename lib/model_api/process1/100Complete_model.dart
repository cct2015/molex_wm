// To parse this JSON data, do
//
//     final FullyCompleteModel = FullyCompleteModelFromJson(jsonString);

import 'dart:convert';

FullyCompleteModel fullyCompleteModelFromJson(String str) => FullyCompleteModel.fromJson(json.decode(str));

String fullyCompleteModelToJson(FullyCompleteModel data) => json.encode(data.toJson());

class FullyCompleteModel {
    FullyCompleteModel({
        this.finishedGoodsNumber,
        this.purchaseOrder,
        this.orderId,
        this.cablePartNumber,
        this.length,
        this.color,
        this.scheduledStatus,
        this.scheduledId,
        this.scheduledQuantity,
        this.machineIdentification,
        this.bundleIdentification,
        this.firstPieceAndPatrol,
        this.applicatorChangeover,
    });

    int finishedGoodsNumber;
    int purchaseOrder;
    int orderId;
    int cablePartNumber;
    int length;
    String color;
    String scheduledStatus;
    int scheduledId;
    int scheduledQuantity;
    String machineIdentification;
    String bundleIdentification;
    int firstPieceAndPatrol;
    int applicatorChangeover;

    factory FullyCompleteModel.fromJson(Map<String, dynamic> json) => FullyCompleteModel(
        finishedGoodsNumber: json["finishedGoodsNumber"],
        purchaseOrder: json["purchaseOrder"],
        orderId: json["orderId"],
        cablePartNumber: json["cablePartNumber"],
        length: json["length"],
        color: json["color"],
        scheduledStatus: json["scheduledStatus"],
        scheduledId: json["scheduledId"],
        scheduledQuantity: json["scheduledQuantity"],
        machineIdentification: json["machineIdentification"],
        bundleIdentification: json["bundleIdentification"],
        firstPieceAndPatrol: json["firstPieceAndPatrol"],
        applicatorChangeover: json["applicatorChangeover"],
    );

    Map<String, dynamic> toJson() => {
        "finishedGoodsNumber": finishedGoodsNumber,
        "purchaseOrder": purchaseOrder,
        "orderId": orderId,
        "cablePartNumber": cablePartNumber,
        "length": length,
        "color": color,
        "scheduledStatus": scheduledStatus,
        "scheduledId": scheduledId,
        "scheduledQuantity": scheduledQuantity,
        "machineIdentification": machineIdentification,
        "bundleIdentification": bundleIdentification,
        "firstPieceAndPatrol": firstPieceAndPatrol,
        "applicatorChangeover": applicatorChangeover,
    };
}
