// To parse this JSON data, do
//
//     final getCableDetail = getCableDetailFromJson(jsonString);

import 'dart:convert';

GetCableDetail getCableDetailFromJson(String str) => GetCableDetail.fromJson(json.decode(str));

String getCableDetailToJson(GetCableDetail data) => json.encode(data.toJson());

class GetCableDetail {
    GetCableDetail({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetCableDetail.fromJson(Map<String, dynamic> json) => GetCableDetail(
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
        this.stripLengthFrom,
        this.stripLengthTo,
    });

    dynamic cutLengthSpec;
    dynamic cablePartNumber;
    dynamic description;
    dynamic stripLengthFrom;
    dynamic stripLengthTo;

    factory CableDetails.fromJson(Map<String, dynamic> json) => CableDetails(
        cutLengthSpec: json["cutLengthSpec"],
        cablePartNumber: json["cablePartNumber"],
        description: json["description"],
        stripLengthFrom: json["stripLengthFrom"],
        stripLengthTo: json["stripLengthTo"],
    );

    Map<String, dynamic> toJson() => {
        "cutLengthSpec": cutLengthSpec,
        "cablePartNumber": cablePartNumber,
        "description": description,
        "stripLengthFrom": stripLengthFrom,
        "stripLengthTo": stripLengthTo,
    };
}
