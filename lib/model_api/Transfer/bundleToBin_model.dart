// To parse this JSON data, do
//
//     final transferBundleToBin = transferBundleToBinFromJson(jsonString);

import 'dart:convert';

List<TransferBundleToBin> transferBundleToBinFromJson(String str) => List<TransferBundleToBin>.from(json.decode(str).map((x) => TransferBundleToBin.fromJson(x)));

String transferBundleToBinToJson(List<TransferBundleToBin> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
        this.id,
        this.bundleIdentification,
        this.scheduledId,
        this.bundleCreationTime,
        this.bundleQuantity,
        this.machineIdentification,
        this.operatorIdentification,
        this.finishedGoodsPart,
        this.cablePartNumber,
        this.cablePartDescription,
        this.cutLengthSpecificationInmm,
        this.color,
        this.bundleStatus,
        this.binId,
        this.locationId,
        this.orderId,
        this.updateFromProcess,
    });

    int id;
    String bundleIdentification;
    dynamic scheduledId;
    DateTime bundleCreationTime;
    int bundleQuantity;
    String machineIdentification;
    String operatorIdentification;
    int finishedGoodsPart;
    int cablePartNumber;
    dynamic cablePartDescription;
    int cutLengthSpecificationInmm;
    String color;
    String bundleStatus;
    int binId;
    String locationId;
    dynamic orderId;
    String updateFromProcess;

    factory BundleTransferToBin.fromJson(Map<String, dynamic> json) => BundleTransferToBin(
        id: json["id"],
        bundleIdentification: json["bundleIdentification"],
        scheduledId: json["scheduledId"],
        bundleCreationTime: DateTime.parse(json["bundleCreationTime"]),
        bundleQuantity: json["bundleQuantity"],
        machineIdentification: json["machineIdentification"],
        operatorIdentification: json["operatorIdentification"],
        finishedGoodsPart: json["finishedGoodsPart"],
        cablePartNumber: json["cablePartNumber"],
        cablePartDescription: json["cablePartDescription"],
        cutLengthSpecificationInmm: json["cutLengthSpecificationInmm"],
        color: json["color"],
        bundleStatus: json["bundleStatus"],
        binId: json["binId"],
        locationId: json["locationId"],
        orderId: json["orderId"],
        updateFromProcess: json["updateFromProcess"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bundleIdentification": bundleIdentification,
        "scheduledId": scheduledId,
        "bundleCreationTime": "${bundleCreationTime.year.toString().padLeft(4, '0')}-${bundleCreationTime.month.toString().padLeft(2, '0')}-${bundleCreationTime.day.toString().padLeft(2, '0')}",
        "bundleQuantity": bundleQuantity,
        "machineIdentification": machineIdentification,
        "operatorIdentification": operatorIdentification,
        "finishedGoodsPart": finishedGoodsPart,
        "cablePartNumber": cablePartNumber,
        "cablePartDescription": cablePartDescription,
        "cutLengthSpecificationInmm": cutLengthSpecificationInmm,
        "color": color,
        "bundleStatus": bundleStatus,
        "binId": binId,
        "locationId": locationId,
        "orderId": orderId,
        "updateFromProcess": updateFromProcess,
    };
}
