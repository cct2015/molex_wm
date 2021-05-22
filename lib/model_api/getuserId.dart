// To parse this JSON data, do
//
//     final getUser = getUserFromJson(jsonString);

import 'dart:convert';

GetUser getUserFromJson(String str) => GetUser.fromJson(json.decode(str));

String getUserToJson(GetUser data) => json.encode(data.toJson());

class GetUser {
    GetUser({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetUser.fromJson(Map<String, dynamic> json) => GetUser(
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

    List<Userid> userId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: List<Userid>.from(json["User Id "].map((x) => Userid.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "User Id ": List<dynamic>.from(userId.map((x) => x.toJson())),
    };
}

class Userid {
    Userid({
        this.empId,
    });

    String empId;

    factory Userid.fromJson(Map<String, dynamic> json) => Userid(
        empId: json["empId"],
    );

    Map<String, dynamic> toJson() => {
        "empId": empId,
    };
}
