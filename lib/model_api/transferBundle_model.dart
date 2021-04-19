// To parse this JSON data, do
//
//     final transferBundle = transferBundleFromJson(jsonString);

import 'dart:convert';

TransferBundle transferBundleFromJson(String str) => TransferBundle.fromJson(json.decode(str));

String transferBundleToJson(TransferBundle data) => json.encode(data.toJson());

class TransferBundle {
    TransferBundle({
        this.binIdentification,
        this.binLocation,
        this.bundleQuantity,
        this.numberOfBundles,
        this.finishedGoods,
        this.lastUseDate,
        this.binRoute,
        this.binStatus,
        this.materialCoordinatorIdentification,
        this.binHistory,
        this.binTime,
        this.scheduledId,
        this.bundleCreationTime,
        this.machineIdentification,
        this.operatorIdentification,
        this.cablePartNumber,
        this.cablePartDescription,
        this.color,
        this.bundleLocation,
        this.bundleRoute,
        this.purchaseOrder,
        this.orderIdentification,
        this.cutLength,
        this.scheduledQuantity,
        this.bundleRejectedQuantity,
    });

    String binIdentification;
    String binLocation;
    int bundleQuantity;
    int numberOfBundles;
    int finishedGoods;
    DateTime lastUseDate;
    int binRoute;
    String binStatus;
    String materialCoordinatorIdentification;
    DateTime binHistory;
    String binTime;
    int scheduledId;
    DateTime bundleCreationTime;
    String machineIdentification;
    String operatorIdentification;
    int cablePartNumber;
    String cablePartDescription;
    String color;
    String bundleLocation;
    String bundleRoute;
    String purchaseOrder;
    int orderIdentification;
    int cutLength;
    int scheduledQuantity;
    int bundleRejectedQuantity;

    factory TransferBundle.fromJson(Map<String, dynamic> json) => TransferBundle(
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
        "lastUseDate": "${lastUseDate.year.toString().padLeft(4, '0')}-${lastUseDate.month.toString().padLeft(2, '0')}-${lastUseDate.day.toString().padLeft(2, '0')}",
        "binRoute": binRoute,
        "binStatus": binStatus,
        "materialCoordinatorIdentification": materialCoordinatorIdentification,
        "binHistory": "${binHistory.year.toString().padLeft(4, '0')}-${binHistory.month.toString().padLeft(2, '0')}-${binHistory.day.toString().padLeft(2, '0')}",
        "binTime": binTime,
        "scheduledId": scheduledId,
        "bundleCreationTime": "${bundleCreationTime.year.toString().padLeft(4, '0')}-${bundleCreationTime.month.toString().padLeft(2, '0')}-${bundleCreationTime.day.toString().padLeft(2, '0')}",
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