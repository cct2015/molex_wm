import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:molex/model_api/RequiredRawMaterialSave_model.dart';
import 'package:molex/model_api/cableDetails_model.dart';
import 'package:molex/model_api/cableTerminalA_model.dart';
import 'package:molex/model_api/cableTerminalB_model.dart';
import 'package:molex/model_api/fgDetail_model.dart';
import 'package:molex/model_api/fullyComplete_model.dart';
import 'package:molex/model_api/generateLabel_model.dart';
import 'package:molex/model_api/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/model_api/materialTrackingCableDetails_model.dart';
import 'package:molex/model_api/materialTrackingTerminalA_model.dart';
import 'package:molex/model_api/materialTrackingTerminalB_model.dart';
import 'package:molex/model_api/partiallyComplete_model.dart';
import 'package:molex/model_api/rawMaterialDetail_model.dart';
import 'package:molex/model_api/rawMaterial_modal.dart';
import 'package:molex/model_api/schedular_model.dart';

class ApiService {
  // String baseUrl = 'http://192.168.1.19:8080/molaxapi/';
  String baseUrl = 'http://mlxbngvwqwip01.molex.com:8080/wipts/';
  Future<Employee> empIdlogin(String empId) async {
    String url = baseUrl + "molex/employee/get-employee-list?empId=$empId";
    var response = await http.get(url);
    print('Login  status Code ${response.statusCode}');
    if (response.statusCode == 200) {
      try {
        Login login = loginFromJson(response.body);
        Employee empolyee = login.data.employeeList;
        return empolyee;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<Schedule1>> getScheduelarData(String machId) async {
    String url = baseUrl + "molex/scheduler/get-scheduler-data?mchNo=$machId";
    var response = await http.get(url);
    print('schedular data status code ${response.statusCode}');
    if (response.statusCode == 200) {
      Schedualr schedualr = schedualrFromJson(response.body);
      print(response.body);
      List<Schedule1> scheduleList = schedualr.data.employeeList;
      return scheduleList;
    } else {
      return [];
    }
  }
  //Update Schedular Tracker information data POST method

  Future<List<MachineDetails>> getmachinedetails(String machineid) async {
    String url =
        baseUrl + "molex/machine/get-by-machine-number?machNo=$machineid";
    var response = await http.get(url);
    print('Machine details status code ${response.statusCode}');
    Fluttertoast.showToast(
        msg: "Machine details status code ${response.statusCode}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    if (response.statusCode == 200) {
      try {
        GetMachineDetails getMachineDetails =
            getmachinedetailsFromJson(response.body);
        List<MachineDetails> machineDetails =
            getMachineDetails.data.machineDetailsList;
        return machineDetails;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<List<RawMaterial>> rawMaterial(
      String machineId, String partNo, String fgNo, String scheduleId) async {
    String url = baseUrl +
        "molex/materialldg/get-req-material-detail?machId=$machineId&partNo=$partNo&fgNo=$fgNo&schdId=$scheduleId";
    var response = await http.get(url);
    print('Raw Material status code ${response.statusCode}');
    if (response.statusCode == 200) {
      try {
        GetRawMaterial getrawMaterial = getRawMaterialFromJson(response.body);
        List<RawMaterial> rawmaterialList = getrawMaterial.data.material;
        return rawmaterialList;
      } catch (e) {
        return [];
      }
    } else {
      return [];
    }
  }

  // Get Raw material detail
  // check where this goes
  Future<RawMaterialDetail> getRawmaterialDetail(String partNo) async {
    String url = baseUrl =
        "molex/ejobticketmaster/get-raw=material-for-add?PartNo=$partNo";
    var response = await http.get(url);
    print('Raw Material details status code ${response.statusCode}');
    if (response.statusCode == 200) {
      GetRawMaterialDetail getRawMaterialDetail =
          getRawMaterialDetailFromJson(response.body);
      RawMaterialDetail rawMaterialDetail =
          getRawMaterialDetail.data.addRawMaterialRequiredDetails;
      return rawMaterialDetail;
    } else {
      return null;
    }
  }

  // Reqired raw material detail save data POST Method
  Future<bool>postRawmaterial(PostRawmaterial postRawmaterial)async{
    String url = baseUrl+"";
    final response = await http.post(url,body:postRawmaterialToJson(postRawmaterial));
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }
  // TODO:
  Future<FgDetails> getFgDetails(String partNo) async {
    String url =
        baseUrl + 'molex/ejobticketmaster/fgDetails-byfgNo?fgPartNo=$partNo';
    var response = await http.get(url);
    print('Fg  details status code ${response.statusCode}');
    if (response.statusCode == 200) {
      GetFgDetails getFgDetails = getFgDetailsFromJson(response.body);
      FgDetails fgDetails = getFgDetails.data.getFgDetaials;
      return fgDetails;
    } else {
      return null;
    }
  }

  //Get Cable Details
  Future<CableDetails> getCableDetails(
      String fgpartNo, String cablepartno) async {
    String url = baseUrl +
        "molex/ejobticketmaster/get-cable-Details-bycableNo?fgPartNo=$fgpartNo & cblPartNo=$cablepartno";
    var response = await http.get(url);
    print('Cable details status code ${response.statusCode}');
    if (response.statusCode == 200) {
      GetCableDetails getCableDetails = getCableDetailsFromJson(response.body);
      CableDetails cableDetails = getCableDetails.data.findCableDetails;
      return cableDetails;
    } else {
      return null;
    }
  }

  //cableTerminalA
  Future<CableTerminalA> getCableTerminalA(String cablepartno) async {
    String url = baseUrl +
        "molex/ejobticketmaster/get-cable-terminalA-bycableNo?cblPartNo=$cablepartno";
    var response = await http.get(url);
    print('Cable termianl A status code ${response.statusCode}');
    if (response.statusCode == 200) {
      GetCableTerminalA getCableTerminalA =
          getCableTerminalAFromJson(response.body);
      CableTerminalA cableTerminalA =
          getCableTerminalA.data.findCableTerminalADto;
      return cableTerminalA;
    } else {
      return null;
    }
  }

  //CableTerminalB
  Future<CableTerminalB> getCableTerminalB(String cablepartno) async {
    String url = baseUrl +
        'molex/material-tracking/tracking-cable-terminalB?partNo=$cablepartno';
    var response = await http.get(url);
    print('Cable termianl A status code ${response.statusCode}');
    if (response.statusCode == 200) {
      GetCableTerminalB getCableTerminalB =
          getCableTerminalBFromJson(response.body);
      CableTerminalB cableTerminalB =
          getCableTerminalB.data.findCableTerminalBDto;
      return cableTerminalB;
    } else {
      return null;
    }
  }

  //MaterialTrackingCableDetails
  Future<List<MaterialTrackingCableDetails>> getMaterialtrackingcableDetails(
      String partNo) async {
    String url =
        baseUrl + 'molex/material-tracking/tracking-cable?partNo=$partNo';
    var response = await http.get(url);
    print('Cable termianl A status code ${response.statusCode}');
    if (response.statusCode == 200) {
      GetMaterialTrackingCableDetails getMaterialTrackingCableDetails =
          getMaterialTrackingCableDetailsFromJson(response.body);
      List<MaterialTrackingCableDetails> materialTrackingCableDetails =
          getMaterialTrackingCableDetails.data.materialTrackingCable;
      return materialTrackingCableDetails;
    } else {
      return null;
    }
  }

  //MaterialTrackingTerminalA
  Future<List<MaterialTrackingTerminalA>> getMaterialtrackingterminalA(
      String partNo) async {
    String url = baseUrl +
        'molex/material-tracking/tracking-cable-terminalA?partNo=$partNo';
    var response = await http.get(url);
    print('Cable termianl A status code ${response.statusCode}');
    if (response.statusCode == 200) {
      GetMaterialTrackingTerminalA getMaterialTrackingTerminalA =
          getMaterialTrackingTerminalAFromJson(response.body);
      List<MaterialTrackingTerminalA> materialTrackingtermianlAList =
          getMaterialTrackingTerminalA.data.materialTrackingTerminalA;
      return materialTrackingtermianlAList;
    } else {
      return null;
    }
  }

  //MaterialTrackingTerminalB
  Future<List<MaterialTrackingTerminalB>> getMaterialtrackingterminalB(
      String partNo) async {
    String url = baseUrl +
        'molex/material-tracking/tracking-cable-terminalB?partNo=$partNo';
    var response = await http.get(url);
    print('Cable termianl A status code ${response.statusCode}');
    if (response.statusCode == 200) {
      GetMaterialTrackingTerminalB getMaterialTrackingTerminalB =
          getMaterialTrackingTerminalBFromJson(response.body);
      List<MaterialTrackingTerminalB> materialTrackingtermianlBList =
          getMaterialTrackingTerminalB.data.materialTrackingTerminalB;
      return materialTrackingtermianlBList;
    } else {
      return null;
    }
  }

  //BundleQuantity api Json missing
  //TODO
  // Generate label request model POst method
  Future<bool> postGeneratelabel(PostGenerateLabel generateLabel) async {
    String url = baseUrl + 'molex/wccr/generate-label';
    var response =
        await http.post(url, body: getGenerateLabelToJson(generateLabel));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // CountBundleQty api Json missing
  //TODO
  // Click on 9999 return value bndle id List api Json missing
  // 100% complete  post method
  Future<bool> post100Complete(PostFullyComplete postFullyComplete) async {
    String url = baseUrl + 'molex/production-report/save-production-report ';
    var response =
        await http.post(url, body: postFullyCompleteToJson(postFullyComplete));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // partially complete post method
  Future<bool> postpartialComplete(
      PostpartiallyComplete postpartiallyComplete) async {
    String url = baseUrl +
        'molex/partial-completion-reason/save-in-partial-completion-reason';
    var response = await http.post(url,
        body: postpartiallyCompleteToJson(postpartiallyComplete));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  // Transfer bundle
  // Location Updation PUT method

}
