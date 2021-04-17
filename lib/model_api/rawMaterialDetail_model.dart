// To parse this JSON data, do
//
//     final getRawMaterialDetail = getRawMaterialDetailFromJson(jsonString);

import 'dart:convert';

GetRawMaterialDetail getRawMaterialDetailFromJson(String str) => GetRawMaterialDetail.fromJson(json.decode(str));

String getRawMaterialDetailToJson(GetRawMaterialDetail data) => json.encode(data.toJson());

class GetRawMaterialDetail {
    GetRawMaterialDetail({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetRawMaterialDetail.fromJson(Map<String, dynamic> json) => GetRawMaterialDetail(
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
        this.addRawMaterialRequiredDetails,
    });

    RawMaterialDetail addRawMaterialRequiredDetails;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        addRawMaterialRequiredDetails: RawMaterialDetail.fromJson(json["Add Raw Material Required Details  "]),
    );

    Map<String, dynamic> toJson() => {
        "Add Raw Material Required Details  ": addRawMaterialRequiredDetails.toJson(),
    };
}

class RawMaterialDetail {
    RawMaterialDetail({
        this.partMunber,
        this.uom,
        this.scannedQuantity,
        this.scheduledQuantity,
        this.tracebility,
        this.date,
        this.existQuantity,
        this.description,
    });

    int partMunber;
    String uom;
    int scannedQuantity;
    dynamic scheduledQuantity;
    String tracebility;
    DateTime date;
    int existQuantity;
    String description;

    factory RawMaterialDetail.fromJson(Map<String, dynamic> json) => RawMaterialDetail(
        partMunber: json["partMunber"],
        uom: json["uom"],
        scannedQuantity: json["scannedQuantity"],
        scheduledQuantity: json["scheduledQuantity"],
        tracebility: json["tracebility"],
        date: DateTime.parse(json["date"]),
        existQuantity: json["existQuantity"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "partMunber": partMunber,
        "uom": uom,
        "scannedQuantity": scannedQuantity,
        "scheduledQuantity": scheduledQuantity,
        "tracebility": tracebility,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "existQuantity": existQuantity,
        "description": description,
    };
}
