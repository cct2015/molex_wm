// To parse this JSON data, do
//
//     final getpreparationShedule = getpreparationSheduleFromJson(jsonString);

import 'dart:convert';

GetpreparationShedule getpreparationSheduleFromJson(String str) => GetpreparationShedule.fromJson(json.decode(str));

String getpreparationSheduleToJson(GetpreparationShedule data) => json.encode(data.toJson());

class GetpreparationShedule {
    GetpreparationShedule({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetpreparationShedule.fromJson(Map<String, dynamic> json) => GetpreparationShedule(
        status: json["status"],
        statusMsg: json["statusMsg"],
        errorCode: json["errorCode"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusMsg": statusMsg,
        "errorCode": errorCode,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.preparationProcessData,
    });

    List<PreparationSchedule> preparationProcessData;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        preparationProcessData: List<PreparationSchedule>.from(json["Preparation process Data "].map((x) => PreparationSchedule.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Preparation process Data ": List<dynamic>.from(preparationProcessData.map((x) => x.toJson())),
    };
}

class PreparationSchedule {
    PreparationSchedule({
        this.orderId,
        this.finishedGoodsNumber,
        this.scheduledId,
        this.cablePartNumber,
        this.length,
        this.color,
        this.scheduledQuantity,
        this.scheduledStatus,
        this.process,
        this.numberOfBundles,
        this.binIdentification,
        this.rejectedQuantity,
        this.bundleQuantity,
        this.passedQuantity,
    });

    String orderId;
    String finishedGoodsNumber;
    String scheduledId;
    String cablePartNumber;
    String length;
    String color;
    String scheduledQuantity;
    String scheduledStatus;
    String process;
    String numberOfBundles;
    String binIdentification;
    dynamic rejectedQuantity;
    String bundleQuantity;
    dynamic passedQuantity;

    factory PreparationSchedule.fromJson(Map<String, dynamic> json) => PreparationSchedule(
        orderId: json["orderId"],
        finishedGoodsNumber: json["finishedGoodsNumber"],
        scheduledId: json["scheduledId"],
        cablePartNumber: json["cablePartNumber"],
        length: json["length"],
        color: json["color"],
        scheduledQuantity: json["scheduledQuantity"],
        scheduledStatus: json["scheduledStatus"],
        process: json["process"],
        numberOfBundles: json["numberOfBundles"],
        binIdentification: json["binIdentification"],
        rejectedQuantity: json["rejectedQuantity"],
        bundleQuantity: json["bundleQuantity"],
        passedQuantity: json["passedQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "finishedGoodsNumber": finishedGoodsNumber,
        "scheduledId": scheduledId,
        "cablePartNumber": cablePartNumber,
        "length": length,
        "color": color,
        "scheduledQuantity": scheduledQuantity,
        "scheduledStatus": scheduledStatus,
        "process": process,
        "numberOfBundles": numberOfBundles,
        "binIdentification": binIdentification,
        "rejectedQuantity": rejectedQuantity,
        "bundleQuantity": bundleQuantity,
        "passedQuantity": passedQuantity,
    };
}
