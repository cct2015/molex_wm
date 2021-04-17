// To parse this JSON data, do
//
//     final putLocationUpdation = putLocationUpdationFromJson(jsonString);

import 'dart:convert';

PutLocationUpdation putLocationUpdationFromJson(String str) => PutLocationUpdation.fromJson(json.decode(str));

String putLocationUpdationToJson(PutLocationUpdation data) => json.encode(data.toJson());

class PutLocationUpdation {
    PutLocationUpdation({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory PutLocationUpdation.fromJson(Map<String, dynamic> json) => PutLocationUpdation(
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

    BundleTransferToBinTracking bundleTransferToBinTracking;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bundleTransferToBinTracking: BundleTransferToBinTracking.fromJson(json[" Bundle Transfer to Bin Tracking "]),
    );

    Map<String, dynamic> toJson() => {
        " Bundle Transfer to Bin Tracking ": bundleTransferToBinTracking.toJson(),
    };
}

class BundleTransferToBinTracking {
    BundleTransferToBinTracking({
        this.id,
        this.binIdentification,
        this.binLocation,
        this.bundleIdentification,
        this.bundleQuantity,
        this.binRoute,
        this.binStatus,
        this.materialCoordinatorIdentification,
        this.binHistory,
        this.binTime,
    });

    int id;
    String binIdentification;
    String binLocation;
    String bundleIdentification;
    int bundleQuantity;
    dynamic binRoute;
    dynamic binStatus;
    String materialCoordinatorIdentification;
    dynamic binHistory;
    dynamic binTime;

    factory BundleTransferToBinTracking.fromJson(Map<String, dynamic> json) => BundleTransferToBinTracking(
        id: json["id"],
        binIdentification: json["binIdentification"],
        binLocation: json["binLocation"],
        bundleIdentification: json["bundleIdentification"],
        bundleQuantity: json["bundleQuantity"],
        binRoute: json["binRoute"],
        binStatus: json["binStatus"],
        materialCoordinatorIdentification: json["materialCoordinatorIdentification"],
        binHistory: json["binHistory"],
        binTime: json["binTime"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "binIdentification": binIdentification,
        "binLocation": binLocation,
        "bundleIdentification": bundleIdentification,
        "bundleQuantity": bundleQuantity,
        "binRoute": binRoute,
        "binStatus": binStatus,
        "materialCoordinatorIdentification": materialCoordinatorIdentification,
        "binHistory": binHistory,
        "binTime": binTime,
    };
}
