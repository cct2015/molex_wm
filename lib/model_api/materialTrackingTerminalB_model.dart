// To parse this JSON data, do
//
//     final getMaterialTrackingTerminalB = getMaterialTrackingTerminalBFromJson(jsonString);

import 'dart:convert';

GetMaterialTrackingTerminalB getMaterialTrackingTerminalBFromJson(String str) => GetMaterialTrackingTerminalB.fromJson(json.decode(str));

String getMaterialTrackingTerminalBToJson(GetMaterialTrackingTerminalB data) => json.encode(data.toJson());

class GetMaterialTrackingTerminalB {
    GetMaterialTrackingTerminalB({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetMaterialTrackingTerminalB.fromJson(Map<String, dynamic> json) => GetMaterialTrackingTerminalB(
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
        this.materialTrackingTerminalB,
    });

    List<MaterialTrackingTerminalB> materialTrackingTerminalB;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        materialTrackingTerminalB: List<MaterialTrackingTerminalB>.from(json[" Material Tracking Terminal B "].map((x) => MaterialTrackingTerminalB.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " Material Tracking Terminal B ": List<dynamic>.from(materialTrackingTerminalB.map((x) => x.toJson())),
    };
}

class MaterialTrackingTerminalB {
    MaterialTrackingTerminalB({
        this.partNumber,
        this.uom,
        this.required,
        this.loaded,
        this.available,
        this.pending,
    });

    int partNumber;
    String uom;
    int required;
    int loaded;
    int available;
    int pending;

    factory MaterialTrackingTerminalB.fromJson(Map<String, dynamic> json) => MaterialTrackingTerminalB(
        partNumber: json["partNumber"],
        uom: json["uom"],
        required: json["required"],
        loaded: json["loaded"],
        available: json["available"],
        pending: json["pending"],
    );

    Map<String, dynamic> toJson() => {
        "partNumber": partNumber,
        "uom": uom,
        "required": required,
        "loaded": loaded,
        "available": available,
        "pending": pending,
    };
}
