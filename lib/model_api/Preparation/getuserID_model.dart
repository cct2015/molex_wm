// To parse this JSON data, do
//
//     final getuserId = getuserIdFromJson(jsonString);

import 'dart:convert';

GetuserId getuserIdFromJson(String str) => GetuserId.fromJson(json.decode(str));

String getuserIdToJson(GetuserId data) => json.encode(data.toJson());

class GetuserId {
    GetuserId({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetuserId.fromJson(Map<String, dynamic> json) => GetuserId(
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
        this.userId,
    });

    List<UserId> userId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: List<UserId>.from(json["User Id "].map((x) => UserId.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "User Id ": List<dynamic>.from(userId.map((x) => x.toJson())),
    };
}

class UserId {
    UserId({
        this.empId,
    });

    String empId;

    factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        empId: json["empId"],
    );

    Map<String, dynamic> toJson() => {
        "empId": empId,
    };
}
