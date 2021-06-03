// To parse this JSON data, do
//
//     final getMachineDetails = getMachineDetailsFromJson(jsonString);

import 'dart:convert';

GetMachineDetails getMachineDetailsFromJson(String str) => GetMachineDetails.fromJson(json.decode(str));

String getMachineDetailsToJson(GetMachineDetails data) => json.encode(data.toJson());

class GetMachineDetails {
    GetMachineDetails({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetMachineDetails.fromJson(Map<String, dynamic> json) => GetMachineDetails(
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
        this.machineDetailsList,
    });

    List<MachineDetails> machineDetailsList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        machineDetailsList: List<MachineDetails>.from(json["Machine Details List "].map((x) => MachineDetails.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Machine Details List ": List<dynamic>.from(machineDetailsList.map((x) => x.toJson())),
    };
}

class MachineDetails {
    MachineDetails({
        this.modelName,
        this.machineNumber,
        this.make,
        this.machineType,
        this.machineName,
        this.category,
        this.machineLocation,
        this.process,
        this.segment,
        this.printerIp,
    });

    String modelName;
    String machineNumber;
    String make;
    String machineType;
    String machineName;
    String category;
    String machineLocation;
    String process;
    String segment;
    String printerIp;

    factory MachineDetails.fromJson(Map<String, dynamic> json) => MachineDetails(
        modelName: json["modelName"],
        machineNumber: json["machineNumber"],
        make: json["make"],
        machineType: json["machineType"],
        machineName: json["machineName"],
        category: json["category"],
        machineLocation: json["machineLocation"],
        process: json["process"],
        segment: json["segment"],
        printerIp: json["printerIp"],
    );

    Map<String, dynamic> toJson() => {
        "modelName": modelName,
        "machineNumber": machineNumber,
        "make": make,
        "machineType": machineType,
        "machineName": machineName,
        "category": category,
        "machineLocation": machineLocation,
        "process": process,
        "segment": segment,
        "printerIp": printerIp,
    };
}
