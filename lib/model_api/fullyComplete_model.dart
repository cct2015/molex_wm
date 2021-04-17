// To parse this JSON data, do
//
//     final postFullyComplete = postFullyCompleteFromJson(jsonString);

import 'dart:convert';

PostFullyComplete postFullyCompleteFromJson(String str) => PostFullyComplete.fromJson(json.decode(str));

String postFullyCompleteToJson(PostFullyComplete data) => json.encode(data.toJson());

class PostFullyComplete {
    PostFullyComplete({
        this.orderId,
        this.finishedGoodsNumber,
        this.scheduledId,
        this.cablePartNumber,
        this.color,
        this.firstPieceAndPatrol,
        this.applicatorChangeover,
        this.cFaCrimpingFault,
    });

    String orderId;
    String finishedGoodsNumber;
    String scheduledId;
    String cablePartNumber;
    String color;
    String firstPieceAndPatrol;
    String applicatorChangeover;
    String cFaCrimpingFault;

    factory PostFullyComplete.fromJson(Map<String, dynamic> json) => PostFullyComplete(
        orderId: json["orderId"],
        finishedGoodsNumber: json["finishedGoodsNumber"],
        scheduledId: json["scheduledId"],
        cablePartNumber: json["cablePartNumber"],
        color: json["color"],
        firstPieceAndPatrol: json["firstPieceAndPatrol"],
        applicatorChangeover: json["applicatorChangeover"],
        cFaCrimpingFault: json["cFACrimpingFault"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "finishedGoodsNumber": finishedGoodsNumber,
        "scheduledId": scheduledId,
        "cablePartNumber": cablePartNumber,
        "color": color,
        "firstPieceAndPatrol": firstPieceAndPatrol,
        "applicatorChangeover": applicatorChangeover,
        "cFACrimpingFault": cFaCrimpingFault,
    };
}
