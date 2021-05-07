// To parse this JSON data, do
//
//     final postGenerateLabel = postGenerateLabelFromJson(jsonString);

import 'dart:convert';

PostGenerateLabel postGenerateLabelFromJson(String str) => PostGenerateLabel.fromJson(json.decode(str));

String postGenerateLabelToJson(PostGenerateLabel data) => json.encode(data.toJson());

class PostGenerateLabel {
    PostGenerateLabel({
        this.finishedGoods,
        this.cablePartNumber,
        this.cutLength,
        this.color,
        this.bundleQuantity,
    });

    String finishedGoods;
    String cablePartNumber;
    String cutLength;
    String color;
    String bundleQuantity;

    factory PostGenerateLabel.fromJson(Map<String, dynamic> json) => PostGenerateLabel(
        finishedGoods: json["finishedGoods"],
        cablePartNumber: json["cablePartNumber"],
        cutLength: json["cutLength"],
        color: json["color"],
        bundleQuantity: json["bundleQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "finishedGoods": finishedGoods,
        "cablePartNumber": cablePartNumber,
        "cutLength": cutLength,
        "color": color,
        "bundleQuantity": bundleQuantity,
    };
}

// To parse this JSON data, do
//
//     final responseGenerateLabel = responseGenerateLabelFromJson(jsonString);



ResponseGenerateLabel responseGenerateLabelFromJson(String str) => ResponseGenerateLabel.fromJson(json.decode(str));

String responseGenerateLabelToJson(ResponseGenerateLabel data) => json.encode(data.toJson());

class ResponseGenerateLabel {
    ResponseGenerateLabel({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory ResponseGenerateLabel.fromJson(Map<String, dynamic> json) => ResponseGenerateLabel(
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
        this.generateLabel,
    });

    GeneratedLabel generateLabel;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        generateLabel: GeneratedLabel.fromJson(json[" Generate Label "]),
    );

    Map<String, dynamic> toJson() => {
        " Generate Label ": generateLabel.toJson(),
    };
}

class GeneratedLabel {
    GeneratedLabel({
        this.finishedGoods,
        this.cablePartNumber,
        this.cutLength,
        this.wireGauge,
        this.terminalFrom,
        this.terminalTo,
        this.bundleQuantity,
        this.routeNo,
        this.bundleId,
    });

    int finishedGoods;
    int cablePartNumber;
    dynamic cutLength;
    dynamic wireGauge;
    dynamic terminalFrom;
    dynamic terminalTo;
    int bundleQuantity;
    dynamic routeNo;
    String bundleId;

    factory GeneratedLabel.fromJson(Map<String, dynamic> json) => GeneratedLabel(
        finishedGoods: json["finishedGoods"],
        cablePartNumber: json["cablePartNumber"],
        cutLength: json["cutLength"],
        wireGauge: json["wireGauge"],
        terminalFrom: json["terminalFrom"],
        terminalTo: json["terminalTo"],
        bundleQuantity: json["bundleQuantity"],
        routeNo: json["routeNo"],
        bundleId: json["bundleId"],
    );

    Map<String, dynamic> toJson() => {
        "finishedGoods": finishedGoods,
        "cablePartNumber": cablePartNumber,
        "cutLength": cutLength,
        "wireGauge": wireGauge,
        "terminalFrom": terminalFrom,
        "terminalTo": terminalTo,
        "bundleQuantity": bundleQuantity,
        "routeNo": routeNo,
        "bundleId": bundleId,
    };
}
