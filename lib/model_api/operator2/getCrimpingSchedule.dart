// To parse this JSON data, do
//
//     final getCrimpingSchedule = getCrimpingScheduleFromJson(jsonString);

import 'dart:convert';

GetCrimpingSchedule getCrimpingScheduleFromJson(String str) => GetCrimpingSchedule.fromJson(json.decode(str));

String getCrimpingScheduleToJson(GetCrimpingSchedule data) => json.encode(data.toJson());

class GetCrimpingSchedule {
    GetCrimpingSchedule({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetCrimpingSchedule.fromJson(Map<String, dynamic> json) => GetCrimpingSchedule(
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
        this.getBundleDetail,
    });

    List<CrimpingSchedule> getBundleDetail;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        getBundleDetail: List<CrimpingSchedule>.from(json["get bundle detail "].map((x) => CrimpingSchedule.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "get bundle detail ": List<dynamic>.from(getBundleDetail.map((x) => x.toJson())),
    };
}

class CrimpingSchedule {
    CrimpingSchedule({
        this.cablePartNo,
        this.length,
        this.wireColour,
        this.purchaseOrder,
        this.finishedGoods,
        this.scheduleId,
        this.scheduledQuantity,
        this.scheduledStatus,
        this.process,
        this.numberOfBundles,
        this.binIdentification,
        this.bundleIdentificationCount,
        this.bundleQuantityTotal,
    });

    String cablePartNo;
    String length;
    String wireColour;
    String purchaseOrder;
    String finishedGoods;
    String scheduleId;
    String scheduledQuantity;
    String scheduledStatus;
    String process;
    String numberOfBundles;
    String binIdentification;
    String bundleIdentificationCount;
    String bundleQuantityTotal;

    factory CrimpingSchedule.fromJson(Map<String, dynamic> json) => CrimpingSchedule(
        cablePartNo: json["cablePartNo"],
        length: json["length"],
        wireColour: json["wireColour"],
        purchaseOrder: json["purchaseOrder"],
        finishedGoods: json["finishedGoods"],
        scheduleId: json["scheduleId"],
        scheduledQuantity: json["scheduledQuantity"],
        scheduledStatus: json["scheduledStatus"],
        process: json["process"],
        numberOfBundles: json["numberOfBundles"],
        binIdentification: json["binIdentification"],
        bundleIdentificationCount: json["bundleIdentificationCount"],
        bundleQuantityTotal: json["bundleQuantityTotal"],
    );

    Map<String, dynamic> toJson() => {
        "cablePartNo": cablePartNo,
        "length": length,
        "wireColour": wireColour,
        "purchaseOrder": purchaseOrder,
        "finishedGoods": finishedGoods,
        "scheduleId": scheduleId,
        "scheduledQuantity": scheduledQuantity,
        "scheduledStatus": scheduledStatus,
        "process": process,
        "numberOfBundles": numberOfBundles,
        "binIdentification": binIdentification,
        "bundleIdentificationCount": bundleIdentificationCount,
        "bundleQuantityTotal": bundleQuantityTotal,
    };
}
