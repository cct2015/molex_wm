// To parse this JSON data, do
//
//     final transferBinToLocation = transferBinToLocationFromJson(jsonString);

import 'dart:convert';

List<TransferBinToLocation> transferBinToLocationFromJson(String str) => List<TransferBinToLocation>.from(json.decode(str).map((x) => TransferBinToLocation.fromJson(x)));

String transferBinToLocationToJson(List<TransferBinToLocation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransferBinToLocation {
    TransferBinToLocation({
        this.binIdentification,
        this.bundleId,
        this.userId,
        this.locationId,
    });

    String binIdentification;
    String bundleId;
    String userId;
    String locationId;

    factory TransferBinToLocation.fromJson(Map<String, dynamic> json) => TransferBinToLocation(
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
//     final responseTransferBinToLocation = responseTransferBinToLocationFromJson(jsonString);

// To parse this JSON data, do
//
//     final responseTransferBinToLocation = responseTransferBinToLocationFromJson(jsonString);


ResponseTransferBinToLocation responseTransferBinToLocationFromJson(String str) => ResponseTransferBinToLocation.fromJson(json.decode(str));

String responseTransferBinToLocationToJson(ResponseTransferBinToLocation data) => json.encode(data.toJson());

class ResponseTransferBinToLocation {
    ResponseTransferBinToLocation({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory ResponseTransferBinToLocation.fromJson(Map<String, dynamic> json) => ResponseTransferBinToLocation(
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

    List<BinTransferToLocationTracking> bundleTransferToBinTracking;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bundleTransferToBinTracking: List<BinTransferToLocationTracking>.from(json[" Bundle Transfer to Bin Tracking "].map((x) => BinTransferToLocationTracking.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " Bundle Transfer to Bin Tracking ": List<dynamic>.from(bundleTransferToBinTracking.map((x) => x.toJson())),
    };
}

class BinTransferToLocationTracking {
    BinTransferToLocationTracking({
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

    factory BinTransferToLocationTracking.fromJson(Map<String, dynamic> json) => BinTransferToLocationTracking
    (
        id: json["id"],
        bundleIdentification: json["bundleIdentification"],
        scheduledId: json["scheduledId"],
        bundleCreationTime: DateTime.parse(json["bundleCreationTime"]),
        bundleQuantity: json["bundleQuantity"],
        machineIdentification: json["machineIdentification"],
        operatorIdentification: json["operatorIdentification"] == null ? null : json["operatorIdentification"],
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
        "operatorIdentification": operatorIdentification == null ? null : operatorIdentification,
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

// To parse this JSON data, do
//
//     final errorTransferBinToLocation = errorTransferBinToLocationFromJson(jsonString);



ErrorTransferBinToLocation errorTransferBinToLocationFromJson(String str) => ErrorTransferBinToLocation.fromJson(json.decode(str));

String errorTransferBinToLocationToJson(ErrorTransferBinToLocation data) => json.encode(data.toJson());

class ErrorTransferBinToLocation {
    ErrorTransferBinToLocation({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    String errorCode;
    Data1 data;

    factory ErrorTransferBinToLocation.fromJson(Map<String, dynamic> json) => ErrorTransferBinToLocation(
        status: json["status"],
        statusMsg: json["statusMsg"],
        errorCode: json["errorCode"],
        data: Data1.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusMsg": statusMsg,
        "errorCode": errorCode,
        "data": data.toJson(),
    };
}

class Data1 {
    Data1();

    factory Data1.fromJson(Map<String, dynamic> json) => Data1(
    );

    Map<String, dynamic> toJson() => {
    };
}
