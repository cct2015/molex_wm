// To parse this JSON data, do
//
//     final transferBundleToBin = transferBundleToBinFromJson(jsonString);

import 'dart:convert';

TransferBundleToBin transferBundleToBinFromJson(String str) => TransferBundleToBin.fromJson(json.decode(str));

String transferBundleToBinToJson(TransferBundleToBin data) => json.encode(data.toJson());

class TransferBundleToBin {
    TransferBundleToBin({
        this.binIdentification,
        this.bundleId,
        this.userId,
        this.locationId,
    });

    String binIdentification;
    String bundleId;
    String userId;
    String locationId;

    factory TransferBundleToBin.fromJson(Map<String, dynamic> json) => TransferBundleToBin(
        binIdentification: json["binIdentification"],
        bundleId: json["bundleId"],
        userId: json["userId"],
        locationId: json["locationId"],
    );

    Map<String, dynamic> toJson() => {
        "binIdentification": binIdentification,
        "bundleId": bundleId,
        "userId": userId,
        "locationId": locationId,
    };
}

// To parse this JSON data, do
//
//     final responseTransferBundletoBin = responseTransferBundletoBinFromJson(jsonString);



ResponseTransferBundletoBin responseTransferBundletoBinFromJson(String str) => ResponseTransferBundletoBin.fromJson(json.decode(str));

String responseTransferBundletoBinToJson(ResponseTransferBundletoBin data) => json.encode(data.toJson());

class ResponseTransferBundletoBin {
    ResponseTransferBundletoBin({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory ResponseTransferBundletoBin.fromJson(Map<String, dynamic> json) => ResponseTransferBundletoBin(
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
        this.bundleTransferToBinTracking,
    });

    List<BundleTransferToBinTracking> bundleTransferToBinTracking;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bundleTransferToBinTracking: List<BundleTransferToBinTracking>.from(json[" Bundle Transfer to Bin Tracking "].map((x) => BundleTransferToBinTracking.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " Bundle Transfer to Bin Tracking ": List<dynamic>.from(bundleTransferToBinTracking.map((x) => x.toJson())),
    };
}

class BundleTransferToBinTracking {
    BundleTransferToBinTracking({
        this.binIdentification,
        this.bundleIdentification,
    });

    String binIdentification;
    String bundleIdentification;

    factory BundleTransferToBinTracking.fromJson(Map<String, dynamic> json) => BundleTransferToBinTracking(
        binIdentification: json["binIdentification"],
        bundleIdentification: json["bundleIdentification"],
    );

    Map<String, dynamic> toJson() => {
        "binIdentification": binIdentification,
        "bundleIdentification": bundleIdentification,
    };
}
