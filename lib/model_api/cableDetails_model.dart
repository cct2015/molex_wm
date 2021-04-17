// To parse this JSON data, do
//
//     final getCableDetails = getCableDetailsFromJson(jsonString);

import 'dart:convert';

GetCableDetails getCableDetailsFromJson(String str) => GetCableDetails.fromJson(json.decode(str));

String getCableDetailsToJson(GetCableDetails data) => json.encode(data.toJson());

class GetCableDetails {
    GetCableDetails({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetCableDetails.fromJson(Map<String, dynamic> json) => GetCableDetails(
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
        this.findCableDetails,
    });

    CableDetails findCableDetails;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        findCableDetails: CableDetails.fromJson(json["findCableDetails "]),
    );

    Map<String, dynamic> toJson() => {
        "findCableDetails ": findCableDetails.toJson(),
    };
}

class CableDetails {
    CableDetails({
        this.cutLengthSpec,
        this.cablePartNumber,
        this.description,
    });

    int cutLengthSpec;
    int cablePartNumber;
    String description;

    factory CableDetails.fromJson(Map<String, dynamic> json) => CableDetails(
        cutLengthSpec: json["cutLengthSpec"],
        cablePartNumber: json["cablePartNumber"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "cutLengthSpec": cutLengthSpec,
        "cablePartNumber": cablePartNumber,
        "description": description,
    };
}
