// To parse this JSON data, do
//
//     final transferBinToLocation = transferBinToLocationFromJson(jsonString);

import 'dart:convert';

TransferBinToLocation transferBinToLocationFromJson(String str) => TransferBinToLocation.fromJson(json.decode(str));

String transferBinToLocationToJson(TransferBinToLocation data) => json.encode(data.toJson());

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
