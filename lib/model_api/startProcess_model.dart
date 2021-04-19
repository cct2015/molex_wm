// To parse this JSON data, do
//
//     final startProcess = startProcessFromJson(jsonString);

import 'dart:convert';

StartProcess startProcessFromJson(String str) => StartProcess.fromJson(json.decode(str));

String startProcessToJson(StartProcess data) => json.encode(data.toJson());

class StartProcess {
    StartProcess({
        this.scheduledIdentification,
        this.machineIdentification,
        this.scheduledQuantity,
        this.finishedGoodsNumber,
        this.orderIdentification,
        this.cablePartNumber,
        this.lengthSpecificationInmm,
        this.color,
    });

    int scheduledIdentification;
    String machineIdentification;
    int scheduledQuantity;
    int finishedGoodsNumber;
    int orderIdentification;
    int cablePartNumber;
    int lengthSpecificationInmm;
    String color;

    factory StartProcess.fromJson(Map<String, dynamic> json) => StartProcess(
        scheduledIdentification: json["scheduledIdentification"],
        machineIdentification: json["machineIdentification"],
        scheduledQuantity: json["scheduledQuantity"],
        finishedGoodsNumber: json["finishedGoodsNumber"],
        orderIdentification: json["orderIdentification"],
        cablePartNumber: json["cablePartNumber"],
        lengthSpecificationInmm: json["lengthSpecificationInmm"],
        color: json["color"],
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
    };
}
