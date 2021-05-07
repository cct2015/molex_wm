// To parse this JSON data, do
//
//     final bundleToBin = bundleToBinFromJson(jsonString);

import 'dart:convert';

TransferBundleToBin transferbundleToBinFromJson(String str) => TransferBundleToBin.fromJson(json.decode(str));

String transferbundleToBinToJson(TransferBundleToBin data) => json.encode(data.toJson());

class TransferBundleToBin {
    TransferBundleToBin({
        this.binIdentification,
        this.binLocation,
        this.bundleQuantity,
        this.numberOfBundles,//TODO
        this.finishedGoods,
        this.lastUseDate,
        this.binRoute,
        this.binStatus,//ToDO
        this.materialCoordinatorIdentification,//TODO
        this.binHistory,//TODO
        this.binTime,//TODO
        this.scheduledId,
        this.bundleCreationTime,
        this.machineIdentification,
        this.operatorIdentification,
        this.cablePartNumber,
        this.cablePartDescription,//TODO
        this.color,
        this.bundleLocation,//TODO
        this.bundleRoute,
        this.purchaseOrder,
        this.orderIdentification,
        this.cutLength,
        this.scheduledQuantity,
        this.bundleRejectedQuantity,
    });

    String binIdentification;
    String binLocation;
    String bundleQuantity;
    String numberOfBundles;
    String finishedGoods;
    DateTime lastUseDate;
    String binRoute;
    String binStatus;
    String materialCoordinatorIdentification;
    DateTime binHistory;
    String binTime;
    String scheduledId;
    DateTime bundleCreationTime;
    String machineIdentification;
    String operatorIdentification;
    String cablePartNumber;
    String cablePartDescription;
    String color;
    String bundleLocation;
    String bundleRoute;
    String purchaseOrder;
    String orderIdentification;
    String cutLength;
    String scheduledQuantity;
    String bundleRejectedQuantity;

    factory TransferBundleToBin.fromJson(Map<String, dynamic> json) => TransferBundleToBin(
        binIdentification: json["binIdentification"],
        binLocation: json["binLocation"],
        bundleQuantity: json["bundleQuantity"],
        numberOfBundles: json["numberOfBundles"],
        finishedGoods: json["finishedGoods"],
        lastUseDate: DateTime.parse(json["lastUseDate"]),
        binRoute: json["binRoute"],
        binStatus: json["binStatus"],
        materialCoordinatorIdentification: json["materialCoordinatorIdentification"],
        binHistory: DateTime.parse(json["binHistory"]),
        binTime: json["binTime"],
        scheduledId: json["scheduledId"],
        bundleCreationTime: DateTime.parse(json["bundleCreationTime"]),
        machineIdentification: json["machineIdentification"],
        operatorIdentification: json["operatorIdentification"],
        cablePartNumber: json["cablePartNumber"],
        cablePartDescription: json["cablePartDescription"],
        color: json["color"],
        bundleLocation: json["bundleLocation"],
        bundleRoute: json["bundleRoute"],
        purchaseOrder: json["purchaseOrder"],
        orderIdentification: json["orderIdentification"],
        cutLength: json["cutLength"],
        scheduledQuantity: json["scheduledQuantity"],
        bundleRejectedQuantity: json["bundleRejectedQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "binIdentification": binIdentification,
        "binLocation": binLocation,
        "bundleQuantity": bundleQuantity,
        "numberOfBundles": numberOfBundles,
        "finishedGoods": finishedGoods,
        "lastUseDate": lastUseDate!=null? "${lastUseDate?.year.toString().padLeft(4, '0')}-${lastUseDate?.month.toString().padLeft(2, '0')}-${lastUseDate?.day.toString().padLeft(2, '0')}":null,
        "binRoute": binRoute,
        "binStatus": binStatus,
        "materialCoordinatorIdentification": materialCoordinatorIdentification,
        "binHistory": binHistory!=null?"${binHistory?.year.toString().padLeft(4, '0')}-${binHistory?.month.toString().padLeft(2, '0')}-${binHistory?.day.toString().padLeft(2, '0')}":null,
        "binTime": binTime,
        "scheduledId": scheduledId,
        "bundleCreationTime": "${bundleCreationTime?.year.toString().padLeft(4, '0')}-${bundleCreationTime?.month.toString().padLeft(2, '0')}-${bundleCreationTime?.day.toString().padLeft(2, '0')}",
        "machineIdentification": machineIdentification,
        "operatorIdentification": operatorIdentification,
        "cablePartNumber": cablePartNumber,
        "cablePartDescription": cablePartDescription,
        "color": color,
        "bundleLocation": bundleLocation,
        "bundleRoute": bundleRoute,
        "purchaseOrder": purchaseOrder,
        "orderIdentification": orderIdentification,
        "cutLength": cutLength,
        "scheduledQuantity": scheduledQuantity,
        "bundleRejectedQuantity": bundleRejectedQuantity,
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
