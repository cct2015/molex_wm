// To parse this JSON data, do
//
//     final postpartiallyComplete = postpartiallyCompleteFromJson(jsonString);

import 'dart:convert';

PostpartiallyComplete postpartiallyCompleteFromJson(String str) => PostpartiallyComplete.fromJson(json.decode(str));

String postpartiallyCompleteToJson(PostpartiallyComplete data) => json.encode(data.toJson());

class PostpartiallyComplete {
    PostpartiallyComplete({
        this.finishedGoods,
        this.purchaseOrder,
        this.orderIdentification,
        this.cablePartNumber,
        this.cutLength,
    });

    int finishedGoods;
    String purchaseOrder;
    String orderIdentification;
    String cablePartNumber;
    String cutLength;

    factory PostpartiallyComplete.fromJson(Map<String, dynamic> json) => PostpartiallyComplete(
        finishedGoods: json["finishedGoods"],
        purchaseOrder: json["purchaseOrder"],
        orderIdentification: json["orderIdentification"],
        cablePartNumber: json["cablePartNumber"],
        cutLength: json["cutLength"],
    );

    Map<String, dynamic> toJson() => {
        "finishedGoods": finishedGoods,
        "purchaseOrder": purchaseOrder,
        "orderIdentification": orderIdentification,
        "cablePartNumber": cablePartNumber,
        "cutLength": cutLength,
    };
}
