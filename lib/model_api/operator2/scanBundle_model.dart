// To parse this JSON data, do
//
//     final getScanBundleId = getScanBundleIdFromJson(jsonString);

import 'dart:convert';

GetScanBundleId getScanBundleIdFromJson(String str) => GetScanBundleId.fromJson(json.decode(str));

String getScanBundleIdToJson(GetScanBundleId data) => json.encode(data.toJson());

class GetScanBundleId {
    GetScanBundleId({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetScanBundleId.fromJson(Map<String, dynamic> json) => GetScanBundleId(
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
        this.crimpingProcess,
    });

    BundleQty crimpingProcess;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        crimpingProcess: BundleQty.fromJson(json["Crimping process "]),
    );

    Map<String, dynamic> toJson() => {
        "Crimping process ": crimpingProcess.toJson(),
    };
}

class BundleQty {
    BundleQty({
        this.bundleQuantity,
    });

    String bundleQuantity;

    factory BundleQty.fromJson(Map<String, dynamic> json) => BundleQty(
        bundleQuantity: json["bundleQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "bundleQuantity": bundleQuantity,
    };
}
