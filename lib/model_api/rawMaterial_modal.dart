// To parse this JSON data, do
//
//     final getRawRawMaterial = getRawRawMaterialFromJson(jsonString);

import 'dart:convert';

GetRawMaterial getRawMaterialFromJson(String str) => GetRawMaterial.fromJson(json.decode(str));

String getRawMaterialToJson(GetRawMaterial data) => json.encode(data.toJson());

class GetRawMaterial {
    GetRawMaterial({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetRawMaterial.fromJson(Map<String, dynamic> json) => GetRawMaterial(
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
        this.material,
    });

    List<RawMaterial> material;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        material: List<RawMaterial>.from(json["Raw Material Details "].map((x) => RawMaterial.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Raw Material Details ": List<dynamic>.from(material.map((x) => x.toJson())),
    };
}

class RawMaterial {
    RawMaterial({
        this.partNunber,
        this.uom,
        this.requireQuantity,
        this.toatalScheduleQuantity,
        this.description,
    });

    int partNunber;
    String uom;
    int requireQuantity;
    int toatalScheduleQuantity;
    String description;

    factory RawMaterial.fromJson(Map<String, dynamic> json) => RawMaterial(
        partNunber: json["partNunber"],
        uom: json["uom"],
        requireQuantity: json["requireQuantity"],
        toatalScheduleQuantity: json["toatalScheduleQuantity"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "partNunber": partNunber,
        "uom": uom,
        "requireQuantity": requireQuantity,
        "toatalScheduleQuantity": toatalScheduleQuantity,
        "description": description,
    };
}
