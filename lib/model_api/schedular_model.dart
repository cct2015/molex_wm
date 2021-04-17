// To parse this JSON data, do
//
//     final schedualr = schedualrFromJson(jsonString);

import 'dart:convert';

Schedualr schedualrFromJson(String str) => Schedualr.fromJson(json.decode(str));

String schedualrToJson(Schedualr data) => json.encode(data.toJson());

class Schedualr {
    Schedualr({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory Schedualr.fromJson(Map<String, dynamic> json) => Schedualr(
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
        this.employeeList,
    });

    List<Schedule1> employeeList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        employeeList: List<Schedule1>.from(json["Employee List "].map((x) => Schedule1.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Employee List ": List<dynamic>.from(employeeList.map((x) => x.toJson())),
    };
}

class Schedule1 {
    Schedule1({
        this.machineNumber,
        this.currentTime,
        this.shiftType,
        this.currentDate,
        this.orderId,
        this.finishedGoodsNumber,
        this.scheduledId,
        this.cablePartNumber,
        this.length,
        this.color,
        this.scheduledQuantity,
        this.scheduledStatus,
        this.process,
    });

    String machineNumber;
    dynamic currentTime;
    dynamic shiftType;
    dynamic currentDate;
    int orderId;
    int finishedGoodsNumber;
    String scheduledId;
    dynamic cablePartNumber;
    int length;
    String color;
    int scheduledQuantity;
    dynamic scheduledStatus;
    String process;

    factory Schedule1.fromJson(Map<String, dynamic> json) => Schedule1(
        machineNumber: json["machineNumber"],
        currentTime: json["currentTime"],
        shiftType: json["shiftType"],
        currentDate: json["currentDate"],
        orderId: json["orderId"],
        finishedGoodsNumber: json["finishedGoodsNumber"],
        scheduledId: json["scheduledId"],
        cablePartNumber: json["cablePartNumber"],
        length: json["length"],
        color: json["color"],
        scheduledQuantity: json["scheduledQuantity"],
        scheduledStatus: json["scheduledStatus"],
        process: json["process"],
    );

    Map<String, dynamic> toJson() => {
        "machineNumber": machineNumber,
        "currentTime": currentTime,
        "shiftType": shiftType,
        "currentDate": currentDate,
        "orderId": orderId,
        "finishedGoodsNumber": finishedGoodsNumber,
        "scheduledId": scheduledId,
        "cablePartNumber": cablePartNumber,
        "length": length,
        "color": color,
        "scheduledQuantity": scheduledQuantity,
        "scheduledStatus": scheduledStatus,
        "process": process,
    };
}
