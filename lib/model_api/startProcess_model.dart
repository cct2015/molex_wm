// To parse this JSON data, do
//
//     final postStartProcessP1 = postStartProcessP1FromJson(jsonString);

import 'dart:convert';

PostStartProcessP1 postStartProcessP1FromJson(String str) => PostStartProcessP1.fromJson(json.decode(str));

String postStartProcessP1ToJson(PostStartProcessP1 data) => json.encode(data.toJson());

class PostStartProcessP1 {
    PostStartProcessP1({
        this.scheduledIdentification,
        this.machineIdentification,
        this.scheduledQuantity,
        this.finishedGoodsNumber,
        this.orderIdentification,
        this.cablePartNumber,
        this.lengthSpecificationInmm,
        this.color,
        this.scheduleStatus,
    });

    String scheduledIdentification;
    String machineIdentification;
    String scheduledQuantity;
    String finishedGoodsNumber;
    String orderIdentification;
    String cablePartNumber;
    String lengthSpecificationInmm;
    String color;
    String scheduleStatus;

    factory PostStartProcessP1.fromJson(Map<String, dynamic> json) => PostStartProcessP1(
        scheduledIdentification: json["scheduledIdentification"],
        machineIdentification: json["machineIdentification"],
        scheduledQuantity: json["scheduledQuantity"],
        finishedGoodsNumber: json["finishedGoodsNumber"],
        orderIdentification: json["orderIdentification"],
        cablePartNumber: json["cablePartNumber"],
        lengthSpecificationInmm: json["lengthSpecificationInmm"],
        color: json["color"],
        scheduleStatus: json["scheduleStatus"],
    );

    Map<String, dynamic> toJson() => {
        "scheduledIdentification": scheduledIdentification,
        "machineIdentification": machineIdentification,
        "scheduledQuantity": scheduledQuantity,
        "finishedGoodsNumber": finishedGoodsNumber,
        "orderIdentification": orderIdentification,
        "cablePartNumber": cablePartNumber,
        "lengthSpecificationInmm": lengthSpecificationInmm,
        "color": color,
        "scheduleStatus": scheduleStatus,
    };
}
