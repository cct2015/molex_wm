// To parse this JSON data, do
//
//     final saveVisualInspectionBundleQty = saveVisualInspectionBundleQtyFromJson(jsonString);

import 'dart:convert';

SaveVisualInspectionBundleQty saveVisualInspectionBundleQtyFromJson(String str) => SaveVisualInspectionBundleQty.fromJson(json.decode(str));

String saveVisualInspectionBundleQtyToJson(SaveVisualInspectionBundleQty data) => json.encode(data.toJson());

class SaveVisualInspectionBundleQty {
    SaveVisualInspectionBundleQty({
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
    });

    String bundleIdentification;
    String bundleQuantity;
    String passedQuantity;
    String rejectedQuantity;
    String crimpInslation;
    String insulationSlug;
    String windowGap;
    String exposedStrands;
    String burrOrCutOff;
    String terminalBendOrClosedOrDamage;
    String seamOpen;
    String missCrimp;
    String frontBellMouth;
    String backBellMouth;
    String extrusionOnBurr;
    String brushLength;
    String cableDamage;
    String terminalTwist;
    String orderId;
    String fgPart;
    String scheduleId;
    String binId;

    factory SaveVisualInspectionBundleQty.fromJson(Map<String, dynamic> json) => SaveVisualInspectionBundleQty(
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
    };
}
