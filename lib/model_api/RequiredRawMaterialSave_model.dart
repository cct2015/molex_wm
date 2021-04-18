// To parse this JSON data, do
//
//     final postRawmaterial = postRawmaterialFromJson(jsonString);

import 'dart:convert';

PostRawmaterial postRawmaterialFromJson(String str) => PostRawmaterial.fromJson(json.decode(str));

String postRawmaterialToJson(PostRawmaterial data) => json.encode(data.toJson());

class PostRawmaterial {
    PostRawmaterial({
        this.date,
        this.existQuantity,
        this.description,
        this.machineNumber,
        this.orderId,
        this.finishedGoodsNumber,
        this.scheduledId,
        this.cablePartNumber,
        this.scheduledQuantity,
        this.uom,
    });

    DateTime date;
    String existQuantity;
    String description;
    String machineNumber;
    String orderId;
    int finishedGoodsNumber;
    int scheduledId;
    int cablePartNumber;
    int scheduledQuantity;
    String uom;

    factory PostRawmaterial.fromJson(Map<String, dynamic> json) => PostRawmaterial(
        date: DateTime.parse(json["date"]),
        existQuantity: json["existQuantity"],
        description: json["description"],
        machineNumber: json["machineNumber"],
        orderId: json["orderId"],
        finishedGoodsNumber: json["finishedGoodsNumber"],
        scheduledId: json["scheduledId"],
        cablePartNumber: json["cablePartNumber"],
        scheduledQuantity: json["scheduledQuantity"],
        uom: json["uom"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "existQuantity": existQuantity,
        "description": description,
        "machineNumber": machineNumber,
        "orderId": orderId,
        "finishedGoodsNumber": finishedGoodsNumber,
        "scheduledId": scheduledId,
        "cablePartNumber": cablePartNumber,
        "scheduledQuantity": scheduledQuantity,
        "uom": uom,
    };
}
