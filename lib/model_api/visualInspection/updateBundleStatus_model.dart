// To parse this JSON data, do
//
//     final viUpdateBundleStatus = viUpdateBundleStatusFromJson(jsonString);

import 'dart:convert';

ViUpdateBundleStatus viUpdateBundleStatusFromJson(String str) => ViUpdateBundleStatus.fromJson(json.decode(str));

String viUpdateBundleStatusToJson(ViUpdateBundleStatus data) => json.encode(data.toJson());

class ViUpdateBundleStatus {
    ViUpdateBundleStatus({
        this.id,
        this.finishedGoods,
        this.purchaseOrder,
        this.startDate,
        this.shiftNumber,
        this.shiftStart,
        this.shiftEnd,
        this.shiftType,
        this.machineNumber,
        this.machineGroup,
        this.termainalFrom,
        this.applicatorFrom,
        this.crimpTypeFrom,
        this.crimpHeightFrom,
        this.pullForceFrom,
        this.stripLengthFrom,
        this.terminalTo,
        this.applicatorTo,
        this.crimpTypeTo,
        this.crimpHeightTo,
        this.pullForceTo,
        this.stripLengthTo,
        this.caplePart,
        this.cableType,
        this.awg,
        this.wireColor,
        this.length,
        this.wireQuantity,
        this.quantityPlanned,
        this.actualQuantity,
        this.productionBin,
        this.referenceStartTime,
        this.referenceEndTime,
        this.scheduleType,
        this.scheduleId,
        this.scheduleStatus,
        this.process,
    });

    int id;
    int finishedGoods;
    String purchaseOrder;
    dynamic startDate;
    int shiftNumber;
    dynamic shiftStart;
    dynamic shiftEnd;
    String shiftType;
    String machineNumber;
    int machineGroup;
    int termainalFrom;
    String applicatorFrom;
    String crimpTypeFrom;
    String crimpHeightFrom;
    double pullForceFrom;
    String stripLengthFrom;
    int terminalTo;
    String applicatorTo;
    String crimpTypeTo;
    String crimpHeightTo;
    double pullForceTo;
    String stripLengthTo;
    int caplePart;
    String cableType;
    int awg;
    String wireColor;
    int length;
    int wireQuantity;
    int quantityPlanned;
    int actualQuantity;
    String productionBin;
    dynamic referenceStartTime;
    dynamic referenceEndTime;
    String scheduleType;
    int scheduleId;
    String scheduleStatus;
    String process;

    factory ViUpdateBundleStatus.fromJson(Map<String, dynamic> json) => ViUpdateBundleStatus(
        id: json["id"],
        finishedGoods: json["finishedGoods"],
        purchaseOrder: json["purchaseOrder"],
        startDate: json["startDate"],
        shiftNumber: json["shiftNumber"],
        shiftStart: json["shiftStart"],
        shiftEnd: json["shiftEnd"],
        shiftType: json["shiftType"],
        machineNumber: json["machineNumber"],
        machineGroup: json["machineGroup"],
        termainalFrom: json["termainalFrom"],
        applicatorFrom: json["applicatorFrom"],
        crimpTypeFrom: json["crimpTypeFrom"],
        crimpHeightFrom: json["crimpHeightFrom"],
        pullForceFrom: json["pullForceFrom"].toDouble(),
        stripLengthFrom: json["stripLengthFrom"],
        terminalTo: json["terminalTo"],
        applicatorTo: json["applicatorTo"],
        crimpTypeTo: json["crimpTypeTo"],
        crimpHeightTo: json["crimpHeightTo"],
        pullForceTo: json["pullForceTo"].toDouble(),
        stripLengthTo: json["stripLengthTo"],
        caplePart: json["caplePart"],
        cableType: json["cableType"],
        awg: json["awg"],
        wireColor: json["wireColor"],
        length: json["length"],
        wireQuantity: json["wireQuantity"],
        quantityPlanned: json["quantityPlanned"],
        actualQuantity: json["actualQuantity"],
        productionBin: json["productionBin"],
        referenceStartTime: json["referenceStartTime"],
        referenceEndTime: json["referenceEndTime"],
        scheduleType: json["scheduleType"],
        scheduleId: json["scheduleId"],
        scheduleStatus: json["scheduleStatus"],
        process: json["process"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "finishedGoods": finishedGoods,
        "purchaseOrder": purchaseOrder,
        "startDate": startDate,
        "shiftNumber": shiftNumber,
        "shiftStart": shiftStart,
        "shiftEnd": shiftEnd,
        "shiftType": shiftType,
        "machineNumber": machineNumber,
        "machineGroup": machineGroup,
        "termainalFrom": termainalFrom,
        "applicatorFrom": applicatorFrom,
        "crimpTypeFrom": crimpTypeFrom,
        "crimpHeightFrom": crimpHeightFrom,
        "pullForceFrom": pullForceFrom,
        "stripLengthFrom": stripLengthFrom,
        "terminalTo": terminalTo,
        "applicatorTo": applicatorTo,
        "crimpTypeTo": crimpTypeTo,
        "crimpHeightTo": crimpHeightTo,
        "pullForceTo": pullForceTo,
        "stripLengthTo": stripLengthTo,
        "caplePart": caplePart,
        "cableType": cableType,
        "awg": awg,
        "wireColor": wireColor,
        "length": length,
        "wireQuantity": wireQuantity,
        "quantityPlanned": quantityPlanned,
        "actualQuantity": actualQuantity,
        "productionBin": productionBin,
        "referenceStartTime": referenceStartTime,
        "referenceEndTime": referenceEndTime,
        "scheduleType": scheduleType,
        "scheduleId": scheduleId,
        "scheduleStatus": scheduleStatus,
        "process": process,
    };
}
