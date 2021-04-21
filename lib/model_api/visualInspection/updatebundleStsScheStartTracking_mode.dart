// To parse this JSON data, do
//
//     final viUpdateBundleStatusScheduleStartTracking = viUpdateBundleStatusScheduleStartTrackingFromJson(jsonString);

import 'dart:convert';

ViUpdateBundleStatusScheduleStartTracking viUpdateBundleStatusScheduleStartTrackingFromJson(String str) => ViUpdateBundleStatusScheduleStartTracking.fromJson(json.decode(str));

String viUpdateBundleStatusScheduleStartTrackingToJson(ViUpdateBundleStatusScheduleStartTracking data) => json.encode(data.toJson());

class ViUpdateBundleStatusScheduleStartTracking {
    ViUpdateBundleStatusScheduleStartTracking({
        this.id,
        this.scheduledIdentification,
        this.scheduledTime,
        this.scheduledStartTime,
        this.scheduledEndTime,
        this.operatorIdentification,
        this.machineIdentification,
        this.scheduledStatus,
        this.finishedGoodsNumber,
        this.purchaseOrder,
        this.orderIdentification,
        this.workType,
        this.cablePartNumber,
        this.terminalPartFrom,
        this.terminalPartTo,
        this.lengthSpecificationInmm,
        this.color,
        this.scheduledQuantity,
    });

    int id;
    int scheduledIdentification;
    dynamic scheduledTime;
    dynamic scheduledStartTime;
    dynamic scheduledEndTime;
    int operatorIdentification;
    String machineIdentification;
    String scheduledStatus;
    int finishedGoodsNumber;
    int purchaseOrder;
    int orderIdentification;
    String workType;
    int cablePartNumber;
    int terminalPartFrom;
    int terminalPartTo;
    int lengthSpecificationInmm;
    String color;
    int scheduledQuantity;

    factory ViUpdateBundleStatusScheduleStartTracking.fromJson(Map<String, dynamic> json) => ViUpdateBundleStatusScheduleStartTracking(
        id: json["id"],
        scheduledIdentification: json["scheduledIdentification"],
        scheduledTime: json["scheduledTime"],
        scheduledStartTime: json["scheduledStartTime"],
        scheduledEndTime: json["scheduledEndTime"],
        operatorIdentification: json["operatorIdentification"],
        machineIdentification: json["machineIdentification"],
        scheduledStatus: json["scheduledStatus"],
        finishedGoodsNumber: json["finishedGoodsNumber"],
        purchaseOrder: json["purchaseOrder"],
        orderIdentification: json["orderIdentification"],
        workType: json["workType"],
        cablePartNumber: json["cablePartNumber"],
        terminalPartFrom: json["terminalPartFrom"],
        terminalPartTo: json["terminalPartTo"],
        lengthSpecificationInmm: json["lengthSpecificationInmm"],
        color: json["color"],
        scheduledQuantity: json["scheduledQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "scheduledIdentification": scheduledIdentification,
        "scheduledTime": scheduledTime,
        "scheduledStartTime": scheduledStartTime,
        "scheduledEndTime": scheduledEndTime,
        "operatorIdentification": operatorIdentification,
        "machineIdentification": machineIdentification,
        "scheduledStatus": scheduledStatus,
        "finishedGoodsNumber": finishedGoodsNumber,
        "purchaseOrder": purchaseOrder,
        "orderIdentification": orderIdentification,
        "workType": workType,
        "cablePartNumber": cablePartNumber,
        "terminalPartFrom": terminalPartFrom,
        "terminalPartTo": terminalPartTo,
        "lengthSpecificationInmm": lengthSpecificationInmm,
        "color": color,
        "scheduledQuantity": scheduledQuantity,
    };
}
