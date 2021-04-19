// To parse this JSON data, do
//
//     final postRawMaterialList = postRawMaterialListFromJson(jsonString);

import 'dart:convert';

List<PostRawMaterial> postRawMaterialListFromJson(String str) => List<PostRawMaterial>.from(json.decode(str).map((x) => PostRawMaterial.fromJson(x)));

String postRawMaterialListToJson(List<PostRawMaterial> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostRawMaterial {
    PostRawMaterial({
        this.schedulerIdentification,
        this.machineIdentification,
        this.finishedGoodsNumber,
        this.orderidentification,
        this.partNumber,
        this.partDescription,
        this.requiredQuantityOrPiece,
        this.totalScheduledQuantity,
        this.unitOfMeasurement,
        this.traceabilityNumber,
        this.existingQuantity,
        this.scannedQuantity,
        this.cablePartNumber,
        this.length,
        this.color,
        this.status,
        this.process,
    });

    String schedulerIdentification;
    String machineIdentification;
    int finishedGoodsNumber;
    int orderidentification;
    int partNumber;
    String partDescription;
    int requiredQuantityOrPiece;
    int totalScheduledQuantity;
    String unitOfMeasurement;
    int traceabilityNumber;
    int existingQuantity;
    int scannedQuantity;
    int cablePartNumber;
    int length;
    String color;
    String status;
    String process;

    factory PostRawMaterial.fromJson(Map<String, dynamic> json) => PostRawMaterial(
        schedulerIdentification: json["schedulerIdentification"],
        machineIdentification: json["machineIdentification"],
        finishedGoodsNumber: json["finishedGoodsNumber"],
        orderidentification: json["orderidentification"],
        partNumber: json["partNumber"],
        partDescription: json["partDescription"],
        requiredQuantityOrPiece: json["requiredQuantityOrPiece"],
        totalScheduledQuantity: json["totalScheduledQuantity"],
        unitOfMeasurement: json["unitOfMeasurement"],
        traceabilityNumber: json["traceabilityNumber"],
        existingQuantity: json["existingQuantity"],
        scannedQuantity: json["scannedQuantity"],
        cablePartNumber: json["cablePartNumber"],
        length: json["length"],
        color: json["color"],
        status: json["Status"],
        process: json["process"],
    );

    Map<String, dynamic> toJson() => {
        "schedulerIdentification": schedulerIdentification,
        "machineIdentification": machineIdentification,
        "finishedGoodsNumber": finishedGoodsNumber,
        "orderidentification": orderidentification,
        "partNumber": partNumber,
        "partDescription": partDescription,
        "requiredQuantityOrPiece": requiredQuantityOrPiece,
        "totalScheduledQuantity": totalScheduledQuantity,
        "unitOfMeasurement": unitOfMeasurement,
        "traceabilityNumber": traceabilityNumber,
        "existingQuantity": existingQuantity,
        "scannedQuantity": scannedQuantity,
        "cablePartNumber": cablePartNumber,
        "length": length,
        "color": color,
        "Status": status,
        "process": process,
    };
}
