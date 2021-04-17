// To parse this JSON data, do
//
//     final getGenerateLabel = getGenerateLabelFromJson(jsonString);

import 'dart:convert';

PostGenerateLabel getGenerateLabelFromJson(String str) => PostGenerateLabel.fromJson(json.decode(str));

String getGenerateLabelToJson(PostGenerateLabel data) => json.encode(data.toJson());

class PostGenerateLabel {
    PostGenerateLabel({
        this.finishedGoods,
        this.cablePartNumber,
        this.machineIdentification,
        this.rejectedQuantity,
        this.terminalDamage,
        this.terminalBend,
    });

    int finishedGoods;
    int cablePartNumber;
    int machineIdentification;
    int rejectedQuantity;
    int terminalDamage;
    int terminalBend;

    factory PostGenerateLabel.fromJson(Map<String, dynamic> json) => PostGenerateLabel(
        finishedGoods: json["finishedGoods"],
        cablePartNumber: json["cablePartNumber"],
        machineIdentification: json["machineIdentification"],
        rejectedQuantity: json["rejectedQuantity"],
        terminalDamage: json["terminalDamage"],
        terminalBend: json["terminalBend"],
    );

    Map<String, dynamic> toJson() => {
        "finishedGoods": finishedGoods,
        "cablePartNumber": cablePartNumber,
        "machineIdentification": machineIdentification,
        "rejectedQuantity": rejectedQuantity,
        "terminalDamage": terminalDamage,
        "terminalBend": terminalBend,
    };
}
