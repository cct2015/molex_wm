// To parse this JSON data, do
//
//     final getBundleQtyCrimp = getBundleQtyCrimpFromJson(jsonString);

import 'dart:convert';

GetBundleQtyCrimp getBundleQtyCrimpFromJson(String str) => GetBundleQtyCrimp.fromJson(json.decode(str));

String getBundleQtyCrimpToJson(GetBundleQtyCrimp data) => json.encode(data.toJson());

class GetBundleQtyCrimp {
    GetBundleQtyCrimp({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetBundleQtyCrimp.fromJson(Map<String, dynamic> json) => GetBundleQtyCrimp(
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
        this.crimpingProcess,
    });

    List<CrimpingProcess> crimpingProcess;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        crimpingProcess: List<CrimpingProcess>.from(json["Crimping process "].map((x) => CrimpingProcess.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Crimping process ": List<dynamic>.from(crimpingProcess.map((x) => x.toJson())),
    };
}

class CrimpingProcess {
    CrimpingProcess({
        this.bundleQuantity,
    });

    int bundleQuantity;

    factory CrimpingProcess.fromJson(Map<String, dynamic> json) => CrimpingProcess(
        bundleQuantity: json["bundleQuantity"],
    );

    Map<String, dynamic> toJson() => {
        "bundleQuantity": bundleQuantity,
    };
}
