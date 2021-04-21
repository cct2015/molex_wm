// To parse this JSON data, do
//
//     final postViSchedule = postViScheduleFromJson(jsonString);

import 'dart:convert';

PostViSchedule postViScheduleFromJson(String str) => PostViSchedule.fromJson(json.decode(str));

String postViScheduleToJson(PostViSchedule data) => json.encode(data.toJson());

class PostViSchedule {
    PostViSchedule({
        this.orderId,
        this.finishedGoodsNumber,
        this.scheduledId,
        this.cablePartNumber,
        this.length,
        this.color,
        this.scheduledQuantity,
        this.scheduledStatus,
        this.process,
    });

    int orderId;
    int finishedGoodsNumber;
    int scheduledId;
    int cablePartNumber;
    int length;
    String color;
    int scheduledQuantity;
    String scheduledStatus;
    String process;

    factory PostViSchedule.fromJson(Map<String, dynamic> json) => PostViSchedule(
        orderId: json["orderId"],
        finishedGoodsNumber: json["finishedGoodsNumber"],
        scheduledId: json["scheduledId"],
        cablePartNumber: json["cablePartNumber"],
        length: json["length"],
        color: json["color"],
        scheduledQuantity: json["scheduledQuantity"],
        scheduledStatus: json["scheduledStatus"],
        process: json["process"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "finishedGoodsNumber": finishedGoodsNumber,
        "scheduledId": scheduledId,
        "cablePartNumber": cablePartNumber,
        "length": length,
        "color": color,
        "scheduledQuantity": scheduledQuantity,
        "scheduledStatus": scheduledStatus,
        "process": process,
    };
}
