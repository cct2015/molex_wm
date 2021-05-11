// To parse this JSON data, do
//
//     final postCrimpingRejectedDetail = postCrimpingRejectedDetailFromJson(jsonString);

import 'dart:convert';

PostCrimpingRejectedDetail postCrimpingRejectedDetailFromJson(String str) => PostCrimpingRejectedDetail.fromJson(json.decode(str));

String postCrimpingRejectedDetailToJson(PostCrimpingRejectedDetail data) => json.encode(data.toJson());

class PostCrimpingRejectedDetail {
    PostCrimpingRejectedDetail({
        this.bundleIdentification,
        this.bundleQuantity,
        this.passedQuantity,
        this.rejectedQuantity,
        this.crimpInslation,
        this.insulationSlug,
        this.windowGap,
        this.exposedStrands,
        this.burrOrCutOff,
        this.terminalBendOrClosedOrDamage,
        this.nickMarkOrStrandsCut,
        this.seamOpen,
        this.missCrimp,
        this.frontBellMouth,
        this.backBellMouth,
        this.extrusionOnBurr,
        this.brushLength,
        this.cableDamage,
        this.terminalTwist,
        this.orderId,
        this.fgPart,
        this.scheduleId,
        this.binId,
        this.processType,
    });

    String bundleIdentification;
    int bundleQuantity;
    int passedQuantity;
    int rejectedQuantity;
    int crimpInslation;
    int insulationSlug;
    int windowGap;
    int exposedStrands;
    int burrOrCutOff;
    int terminalBendOrClosedOrDamage;
    int nickMarkOrStrandsCut;
    int seamOpen;
    int missCrimp;
    int frontBellMouth;
    int backBellMouth;
    int extrusionOnBurr;
    int brushLength;
    int cableDamage;
    int terminalTwist;
    int orderId;
    int fgPart;
    int scheduleId;
    String binId;
    String processType;

    factory PostCrimpingRejectedDetail.fromJson(Map<String, dynamic> json) => PostCrimpingRejectedDetail(
        bundleIdentification: json["bundleIdentification"],
        bundleQuantity: json["bundleQuantity"],
        passedQuantity: json["passedQuantity"],
        rejectedQuantity: json["rejectedQuantity"],
        crimpInslation: json["crimpInslation"],
        insulationSlug: json["insulationSlug"],
        windowGap: json["windowGap"],
        exposedStrands: json["exposedStrands"],
        burrOrCutOff: json["burrOrCutOff"],
        terminalBendOrClosedOrDamage: json["terminalBendORClosedORDamage"],
        nickMarkOrStrandsCut: json["nickMarkOrStrandsCut"],
        seamOpen: json["seamOpen"],
        missCrimp: json["missCrimp"],
        frontBellMouth: json["frontBellMouth"],
        backBellMouth: json["backBellMouth"],
        extrusionOnBurr: json["extrusionOnBurr"],
        brushLength: json["brushLength"],
        cableDamage: json["cableDamage"],
        terminalTwist: json["terminalTwist"],
        orderId: json["orderId"],
        fgPart: json["fgPart"],
        scheduleId: json["scheduleId"],
        binId: json["binId"],
        processType: json["processType"],
    );

    Map<String, dynamic> toJson() => {
        "bundleIdentification": bundleIdentification,
        "bundleQuantity": bundleQuantity,
        "passedQuantity": passedQuantity,
        "rejectedQuantity": rejectedQuantity,
        "crimpInslation": crimpInslation,
        "insulationSlug": insulationSlug,
        "windowGap": windowGap,
        "exposedStrands": exposedStrands,
        "burrOrCutOff": burrOrCutOff,
        "terminalBendORClosedORDamage": terminalBendOrClosedOrDamage,
        "nickMarkOrStrandsCut": nickMarkOrStrandsCut,
        "seamOpen": seamOpen,
        "missCrimp": missCrimp,
        "frontBellMouth": frontBellMouth,
        "backBellMouth": backBellMouth,
        "extrusionOnBurr": extrusionOnBurr,
        "brushLength": brushLength,
        "cableDamage": cableDamage,
        "terminalTwist": terminalTwist,
        "orderId": orderId,
        "fgPart": fgPart,
        "scheduleId": scheduleId,
        "binId": binId,
        "processType": processType,
    };
}
