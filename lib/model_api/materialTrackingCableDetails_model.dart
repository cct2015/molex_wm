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

    List<MaterialTrackingCableDetails> materialTrackingCable;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        materialTrackingCable: List<MaterialTrackingCableDetails>.from(json[" Material Tracking Cable "].map((x) => MaterialTrackingCableDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " Material Tracking Cable ": List<dynamic>.from(materialTrackingCable.map((x) => x.toJson())),
    };
}

class MaterialTrackingCableDetails{
    MaterialTrackingCableDetails({
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

    factory MaterialTrackingCableDetails.fromJson(Map<String, dynamic> json) => MaterialTrackingCableDetails(
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
