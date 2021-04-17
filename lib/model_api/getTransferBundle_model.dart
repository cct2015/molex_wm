// To parse this JSON data, do
//
//     final getTransferBundle = getTransferBundleFromJson(jsonString);

import 'dart:convert';

GetTransferBundle getTransferBundleFromJson(String str) => GetTransferBundle.fromJson(json.decode(str));

String getTransferBundleToJson(GetTransferBundle data) => json.encode(data.toJson());

class GetTransferBundle {
    GetTransferBundle({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetTransferBundle.fromJson(Map<String, dynamic> json) => GetTransferBundle(
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

    List<BundleTransferToBin> bundleTransferToBinTracking;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bundleTransferToBinTracking: List<BundleTransferToBin>.from(json[" Bundle Transfer to Bin Tracking "].map((x) => BundleTransferToBin.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " Bundle Transfer to Bin Tracking ": List<dynamic>.from(bundleTransferToBinTracking.map((x) => x.toJson())),
    };
}

class BundleTransferToBin {
    BundleTransferToBin({
        this.binIdentification,
        this.binLocation,
        this.numberOfBundles,
        this.binStatus,
        this.bundleIdentification,
        this.bundleQuantity,
        this.operatorIdentification,
        this.cablePartDescription,
    });

    String binIdentification;
    String binLocation;
    dynamic numberOfBundles;
    dynamic binStatus;
    String bundleIdentification;
    int bundleQuantity;
    String operatorIdentification;
    dynamic cablePartDescription;

    factory BundleTransferToBin.fromJson(Map<String, dynamic> json) => BundleTransferToBin(
        binIdentification: json["binIdentification"],
        binLocation: json["binLocation"],
        numberOfBundles: json["numberOfBundles"],
        binStatus: json["binStatus"],
        bundleIdentification: json["bundleIdentification"],
        bundleQuantity: json["bundleQuantity"],
        operatorIdentification: json["operatorIdentification"],
        cablePartDescription: json["cablePartDescription"],
    );

    Map<String, dynamic> toJson() => {
        "binIdentification": binIdentification,
        "binLocation": binLocation,
        "numberOfBundles": numberOfBundles,
        "binStatus": binStatus,
        "bundleIdentification": bundleIdentification,
        "bundleQuantity": bundleQuantity,
        "operatorIdentification": operatorIdentification,
        "cablePartDescription": cablePartDescription,
    };
}
