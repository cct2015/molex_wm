// To parse this JSON data, do
//
//     final postGenerateLabel = postGenerateLabelFromJson(jsonString);

import 'dart:convert';

PostGenerateLabel postGenerateLabelFromJson(String str) => PostGenerateLabel.fromJson(json.decode(str));

String postGenerateLabelToJson(PostGenerateLabel data) => json.encode(data.toJson());

class PostGenerateLabel {
    PostGenerateLabel({
        this.finishedGoods,
        this.purchaseorder,
        this.orderIdentification,
        this.cablePartNumber,
        this.cutLength,
        this.color,
        this.scheduleIdentification,
        this.scheduledQuantity,
        this.machineIdentification,
        this.operatorIdentification,
        this.bundleIdentification,
        this.rejectedQuantity,
        this.terminalDamage,
        this.terminalBend,
        this.terminalTwist,
        this.conductorCurlingUpDown,
        this.insulationCurlingUpDown,
        this.conductorBurr,
        this.windowGap,
        this.crimpOnInsulation,
        this.improperCrimping,
        this.tabBendOrTabOpen,
        this.bellMouthLessOrMore,
        this.cutOffLessOrMore,
        this.cutOffBurr,
        this.cutOffBend,
        this.insulationDamage,
        this.exposureStrands,
        this.strandsCut,
        this.brushLengthLessorMore,
        this.terminalCoppermark,
        this.setupRejections,
        this.terminalBackOut,
        this.cableDamage,
        this.crimpingPositionOutOrMissCrimp,
        this.terminalSeamOpen,
        this.rollerMark,
        this.lengthLessOrLengthMore,
        this.gripperMark,
        this.endWire,
        this.endTerminal,
        this.entangledCable,
        this.troubleShootingRejections,
        this.wireOverLoadRejectionsJam,
        this.halfCurlingA,
        this.brushLengthLessOrMoreC,
        this.exposureStrandsD,
        this.cameraPositionOutE,
        this.crimpOnInsulationF,
        this.cablePositionMovementG,
        this.crimpOnInsulationC,
        this.crimpingPositionOutOrMissCrimpD,
        this.crimpPositionOut,
        this.stripPositionOut,
        this.offCurling,
        this.cFmPfmRejections,
        this.incomingIssue,
        this.bladeMark,
        this.crossCut,
        this.insulationBarrel,
        this.method,
        this.terminalFrom,
        this.terminalTo,
    });


    String finishedGoods;
    String purchaseorder;
    String orderIdentification;
    String cablePartNumber;
    String cutLength;
    String color;
    String scheduleIdentification;
    String scheduledQuantity;
    String machineIdentification;
    String operatorIdentification;
    String bundleIdentification;
    String rejectedQuantity;
    String terminalDamage;
    String terminalBend;
    String terminalTwist;
    String conductorCurlingUpDown;
    String insulationCurlingUpDown;
    String conductorBurr;
    String windowGap;
    String crimpOnInsulation;
    String improperCrimping;
    String tabBendOrTabOpen;
    String bellMouthLessOrMore;
    String cutOffLessOrMore;
    String cutOffBurr;
    String cutOffBend;
    String insulationDamage;
    String exposureStrands;
    String strandsCut;
    String brushLengthLessorMore;
    String terminalCoppermark;
    String setupRejections;
    String terminalBackOut;
    String cableDamage;
    String crimpingPositionOutOrMissCrimp;
    String terminalSeamOpen;
    String rollerMark;
    String lengthLessOrLengthMore;
    String gripperMark;
    String endWire;
    String endTerminal;
    String entangledCable;
    String troubleShootingRejections;
    String wireOverLoadRejectionsJam;
    String halfCurlingA;
    String brushLengthLessOrMoreC;
    String exposureStrandsD;
    String cameraPositionOutE;
    String crimpOnInsulationF;
    String cablePositionMovementG;
    String crimpOnInsulationC;
    String crimpingPositionOutOrMissCrimpD;
    String crimpPositionOut;
    String stripPositionOut;
    String offCurling;
    String cFmPfmRejections;
    String incomingIssue;
    String bladeMark;
    String crossCut;
    String insulationBarrel;
    String method;
    String terminalFrom;
    String terminalTo;

    factory PostGenerateLabel.fromJson(Map<String, dynamic> json) => PostGenerateLabel(
        finishedGoods: json["finishedGoods"],
        purchaseorder: json["purchaseorder"],
        orderIdentification: json["orderIdentification"],
        cablePartNumber: json["cablePartNumber"],
        cutLength: json["cutLength"],
        color: json["color"],
        scheduleIdentification: json["scheduleIdentification"],
        scheduledQuantity: json["scheduledQuantity"],
        machineIdentification: json["machineIdentification"],
        operatorIdentification: json["operatorIdentification"],
        bundleIdentification: json["bundleIdentification"],
        rejectedQuantity: json["rejectedQuantity"],
        terminalDamage: json["terminalDamage"],
        terminalBend: json["terminalBend"],
        terminalTwist: json["terminalTwist"],
        conductorCurlingUpDown: json["conductorCurlingUpDown"],
        insulationCurlingUpDown: json["insulationCurlingUpDown"],
        conductorBurr: json["conductorBurr"],
        windowGap: json["windowGap"],
        crimpOnInsulation: json["crimpOnInsulation"],
        improperCrimping: json["improperCrimping"],
        tabBendOrTabOpen: json["tabBendOrTabOpen"],
        bellMouthLessOrMore: json["bellMouthLessOrMore"],
        cutOffLessOrMore: json["cutOffLessOrMore"],
        cutOffBurr: json["cutOffBurr"],
        cutOffBend: json["cutOffBend"],
        insulationDamage: json["insulationDamage"],
        exposureStrands: json["exposureStrands"],
        strandsCut: json["strandsCut"],
        brushLengthLessorMore: json["brushLengthLessorMore"],
        terminalCoppermark: json["terminalCoppermark"],
        setupRejections: json["setupRejections"],
        terminalBackOut: json["terminalBackOut"],
        cableDamage: json["cableDamage"],
        crimpingPositionOutOrMissCrimp: json["crimpingPositionOutOrMissCrimp"],
        terminalSeamOpen: json["terminalSeamOpen"],
        rollerMark: json["rollerMark"],
        lengthLessOrLengthMore: json["lengthLessOrLengthMore"],
        gripperMark: json["gripperMark"],
        endWire: json["endWire"],
        endTerminal: json["endTerminal"],
        entangledCable: json["entangledCable"],
        troubleShootingRejections: json["troubleShootingRejections"],
        wireOverLoadRejectionsJam: json["wireOverLoadRejectionsJam"],
        halfCurlingA: json["halfCurling_A"],
        brushLengthLessOrMoreC: json["brushLengthLessOrMore_C"],
        exposureStrandsD: json["exposureStrands_D"],
        cameraPositionOutE: json["cameraPositionOut_E"],
        crimpOnInsulationF: json["crimpOnInsulation_F"],
        cablePositionMovementG: json["cablePositionMovement_G"],
        crimpOnInsulationC: json["crimpOnInsulation_C"],
        crimpingPositionOutOrMissCrimpD: json["crimpingPositionOutOrMissCrimp_D"],
        crimpPositionOut: json["crimpPositionOut"],
        stripPositionOut: json["stripPositionOut"],
        offCurling: json["offCurling"],
        cFmPfmRejections: json["cFM_PFM_Rejections"],
        incomingIssue: json["incomingIssue"],
        bladeMark: json["bladeMark"],
        crossCut: json["crossCut"],
        insulationBarrel: json["insulationBarrel"],
        method: json["method"],
        terminalFrom: json["terminalFrom"],
        terminalTo: json["terminalTo"],
    );

    Map<String, dynamic> toJson() => {
        "finishedGoods": finishedGoods,
        "purchaseorder": purchaseorder,
        "orderIdentification": orderIdentification,
        "cablePartNumber": cablePartNumber,
        "cutLength": cutLength,
        "color": color,
        "scheduleIdentification": scheduleIdentification,
        "scheduledQuantity": scheduledQuantity,
        "machineIdentification": machineIdentification,
        "operatorIdentification": operatorIdentification,
        "bundleIdentification": bundleIdentification,
        "rejectedQuantity": rejectedQuantity,
        "terminalDamage": terminalDamage,
        "terminalBend": terminalBend,
        "terminalTwist": terminalTwist,
        "conductorCurlingUpDown": conductorCurlingUpDown,
        "insulationCurlingUpDown": insulationCurlingUpDown,
        "conductorBurr": conductorBurr,
        "windowGap": windowGap,
        "crimpOnInsulation": crimpOnInsulation,
        "improperCrimping": improperCrimping,
        "tabBendOrTabOpen": tabBendOrTabOpen,
        "bellMouthLessOrMore": bellMouthLessOrMore,
        "cutOffLessOrMore": cutOffLessOrMore,
        "cutOffBurr": cutOffBurr,
        "cutOffBend": cutOffBend,
        "insulationDamage": insulationDamage,
        "exposureStrands": exposureStrands,
        "strandsCut": strandsCut,
        "brushLengthLessorMore": brushLengthLessorMore,
        "terminalCoppermark": terminalCoppermark,
        "setupRejections": setupRejections,
        "terminalBackOut": terminalBackOut,
        "cableDamage": cableDamage,
        "crimpingPositionOutOrMissCrimp": crimpingPositionOutOrMissCrimp,
        "terminalSeamOpen": terminalSeamOpen,
        "rollerMark": rollerMark,
        "lengthLessOrLengthMore": lengthLessOrLengthMore,
        "gripperMark": gripperMark,
        "endWire": endWire,
        "endTerminal": endTerminal,
        "entangledCable": entangledCable,
        "troubleShootingRejections": troubleShootingRejections,
        "wireOverLoadRejectionsJam": wireOverLoadRejectionsJam,
        "halfCurling_A": halfCurlingA,
        "brushLengthLessOrMore_C": brushLengthLessOrMoreC,
        "exposureStrands_D": exposureStrandsD,
        "cameraPositionOut_E": cameraPositionOutE,
        "crimpOnInsulation_F": crimpOnInsulationF,
        "cablePositionMovement_G": cablePositionMovementG,
        "crimpOnInsulation_C": crimpOnInsulationC,
        "crimpingPositionOutOrMissCrimp_D": crimpingPositionOutOrMissCrimpD,
        "crimpPositionOut": crimpPositionOut,
        "stripPositionOut": stripPositionOut,
        "offCurling": offCurling,
        "cFM_PFM_Rejections": cFmPfmRejections,
        "incomingIssue": incomingIssue,
        "bladeMark": bladeMark,
        "crossCut": crossCut,
        "insulationBarrel": insulationBarrel,
        "method": method,
        "terminalFrom": terminalFrom,
        "terminalTo": terminalTo,
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
