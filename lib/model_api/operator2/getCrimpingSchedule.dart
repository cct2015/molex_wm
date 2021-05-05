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
        this.crimpingBundleList,
    });

    List<CrimpingSchedule> crimpingBundleList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        crimpingBundleList: List<CrimpingSchedule>.from(json["Crimping Bundle List "].map((x) => CrimpingSchedule.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Crimping Bundle List ": List<dynamic>.from(crimpingBundleList.map((x) => x.toJson())),
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
        this.process,
        this.binIdentification,
        this.bundleIdentificationCount,
        this.bundleQuantityTotal,
    });

    int cablePartNo;
    int length;
    String wireColour;
    int purchaseOrder;
    int finishedGoods;
    int scheduleId;
    String process;
    String binIdentification;
    int bundleIdentificationCount;
    int bundleQuantityTotal;

    factory CrimpingSchedule.fromJson(Map<String, dynamic> json) => CrimpingSchedule(
        cablePartNo: json["cablePartNo"],
        length: json["length"],
        wireColour: json["wireColour"],
        purchaseOrder: json["purchaseOrder"],
        finishedGoods: json["finishedGoods"],
        scheduleId: json["scheduleId"],
        process: json["process"],
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
        "process": process,
        "binIdentification": binIdentification,
        "bundleIdentificationCount": bundleIdentificationCount,
        "bundleQuantityTotal": bundleQuantityTotal,
    };
}
