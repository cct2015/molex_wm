// To parse this JSON data, do
//
//     final getMaterialTrackingCableDetails = getMaterialTrackingCableDetailsFromJson(jsonString);

import 'dart:convert';

GetMaterialTrackingCableDetails getMaterialTrackingCableDetailsFromJson(String str) => GetMaterialTrackingCableDetails.fromJson(json.decode(str));

String getMaterialTrackingCableDetailsToJson(GetMaterialTrackingCableDetails data) => json.encode(data.toJson());

class GetMaterialTrackingCableDetails {
    GetMaterialTrackingCableDetails({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetMaterialTrackingCableDetails.fromJson(Map<String, dynamic> json) => GetMaterialTrackingCableDetails(
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
        this.materialTrackingCable,
    });

    MaterialTrackingCable materialTrackingCable;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        materialTrackingCable: MaterialTrackingCable.fromJson(json[" Material Tracking Cable "]),
    );

    Map<String, dynamic> toJson() => {
        " Material Tracking Cable ": materialTrackingCable.toJson(),
    };
}

class MaterialTrackingCable {
    MaterialTrackingCable({
        this.id,
        this.partNumber,
        this.uom,
        this.required1,
        this.loaded,
        this.available,
        this.pending,
    });

    int id;
    int partNumber;
    String uom;
    int required1;
    int loaded;
    int available;
    int pending;

    factory MaterialTrackingCable.fromJson(Map<String, dynamic> json) => MaterialTrackingCable(
        id: json["id"],
        partNumber: json["partNumber"],
        uom: json["uom"],
        required1: json["required"],
        loaded: json["loaded"],
        available: json["available"],
        pending: json["pending"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "partNumber": partNumber,
        "uom": uom,
        "required": required1,
        "loaded": loaded,
        "available": available,
        "pending": pending,
    };
}
