import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:molex/model_api/postrawmatList_model.dart';
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
import 'package:molex/model_api/startProcess_model.dart';
import 'package:molex/model_api/transferBundle_model.dart';
import 'package:molex/model_api/visualInspection/VI_scheduler_model.dart';
import 'package:molex/model_api/visualInspection/postViSchedule_model.dart';
import 'package:molex/model_api/visualInspection/saveVIBundleQty.dart';
import 'package:molex/model_api/visualInspection/updateBundleStatus_model.dart';
import 'package:molex/model_api/visualInspection/updatebundleStsScheStartTracking_mode.dart';


class ApiService {
  String baseUrl = "http://justerp.in:8080/wipts/";
  // String baseUrl = "http://192.168.1.252:8080/wipts/";

  // String baseUrl = 'http://mlxbngvwqwip01.molex.com:8080/wipts/';
  Map<String, String> headerList = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    "Keep-Alive": "timeout=0",
  };
  //open null empty

  Future<Employee> empIdlogin(String empId) async {
    var url =
        Uri.parse(baseUrl + "molex/employee/get-employee-list/empid=$empId");
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

  Future<List<Schedule>> getScheduelarData({String machId, String type}) async {
    print("called api");
      print("called $machId");
        print("called $type");
    // var url = Uri.parse(baseUrl +
    //     "molex/scheduler/get-scheduler-same-machine-data?schdTyp=A&mchNo=$machId&sameMachine=true");
    var url = Uri.parse(baseUrl +
        "molex/scheduler/get-scheduler-same-machine-data?schdTyp=$type&mchNo=$machId&sameMachine=true");
    var response = await http.get(url);
    print('schedular data status code ${response.statusCode}');
    if (response.statusCode == 200) {
      Schedualr schedualr = schedualrFromJson(response.body);
      print(response.body);
      List<Schedule> scheduleList = schedualr.data.employeeList;
      return scheduleList;
    } else {
      return [];
    }
  }
  //Update Schedular Tracker information data POST method

  Future<List<MachineDetails>> getmachinedetails(String machineid) async {
    var url = Uri.parse(
        baseUrl + "molex/machine/get-by-machine-number?machNo=$machineid");
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
      {String machineId, String partNo, String fgNo, String scheduleId}) async {
    print('fgpart : ${fgNo}');
    print('schedule: ${scheduleId}');
    print('machineID: ${machineId}');
    //TODO : variables in api
    var url1 = Uri.parse(baseUrl +
        "molex/scheduler/get-req-material-detail?machId=$machineId&fgNo=${fgNo}&schdId=${scheduleId}");
    var url2 = Uri.parse(baseUrl +
        "molex/scheduler/get-req-material-detail-from?machId=$machineId&fgNo=$fgNo&schdId=$scheduleId");
    var url3 = Uri.parse(baseUrl +
        "molex/scheduler/get-req-material-detail-to?machId=$machineId&fgNo=$fgNo&schdId=$scheduleId");
    var response1 = await http.get(url1);
    var response2 = await http.get(url2);
    var response3 = await http.get(url3);
    print('Raw Material1 status code ${response1.statusCode}');
    print('Raw Material2 status code ${response1.statusCode}');
    print('Raw Material3 status code ${response1.statusCode}');
    if (response3.statusCode == 200) {
      try {
        print(response1.body);
        GetRawMaterial getrawMaterial1 = getRawMaterialFromJson(response1.body);

        GetRawMaterial getrawMaterial2 = getRawMaterialFromJson(response2.body);
              print(response2.body);
        GetRawMaterial getrawMaterial3 = getRawMaterialFromJson(response3.body);
             print(response3.body);
        List<RawMaterial> rawmaterialList1 =
            getrawMaterial1.data.rawMaterialDetails;
        List<RawMaterial> rawmaterialList2 =
            getrawMaterial2.data.rawMaterialDetails;
        List<RawMaterial> rawmaterialList3 =
            getrawMaterial3.data.rawMaterialDetails;
        List<RawMaterial> rawMateriallist =
            rawmaterialList1 + rawmaterialList2 + rawmaterialList3;
        print(rawMateriallist);
        return rawMateriallist;
      } catch (e) {
        print('error');
        return [];
      }
    } else {
      return [];
    }
  }

  // Get Raw material detail
  // check where this goes
  Future<RawMaterialDetail> getRawmaterialDetail(String partNo) async {
    var url = Uri.parse(baseUrl =
        "molex/ejobticketmaster/get-raw=material-for-add?PartNo=$partNo");
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
  Future<bool> postRawmaterial(
      List<PostRawMaterial> postRawmaterialList) async {
    var url = Uri.parse(baseUrl + "molex/materialldg/post-req-material");
    final response = await http.post(url,
        body: postRawMaterialListToJson(postRawmaterialList),
        headers: headerList);
    print('post raw material ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // TODO:
  Future<FgDetails> getFgDetails(String partNo) async {
    var url = Uri.parse(
        baseUrl + 'molex/ejobticketmaster/fgDetails-byfgNo?fgPartNo=$partNo');
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
      {String fgpartNo, String cablepartno}) async {
    var url = Uri.parse(baseUrl +
        "/molex/ejobticketmaster/get-cable-Details-bycableNo?fgPartNo=$fgpartNo&cblPartNo=$cablepartno");
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
  Future<CableTerminalA> getCableTerminalA({String cablepartno}) async {
    //TODO variable in url
    print("cable No TA : $cablepartno");
    var url = Uri.parse(baseUrl +
        "/molex/ejobticketmaster/get-cable-terminalA-bycableNo?cblPartNo=$cablepartno");
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
  Future<CableTerminalB> getCableTerminalB({String cablepartno}) async {
    //TODO variable in url
    var url = Uri.parse(baseUrl +
        'molex/ejobticketmaster/get-cable-terminalB-bycableNo?cblPartNo=$cablepartno');
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

  //Start Process
  Future<bool> startProcess1(StartProcess process) async {
    var url = Uri.parse(baseUrl +
        "molex/schedule-start-tracking/start-process-save-in-schedule-tracking");
    var response = await http.post(url,
        body: startProcessToJson(process), headers: headerList);
    print("start proces response = ${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //MaterialTrackingCableDetails
  Future<List<MaterialTrackingCableDetails>> getMaterialtrackingcableDetails(
      String partNo) async {
    var url = Uri.parse(
        baseUrl + 'molex/material-tracking/tracking-cable?partNo=$partNo');
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
    var url = Uri.parse(baseUrl +
        'molex/material-tracking/tracking-cable-terminalA?partNo=$partNo');
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
    var url = Uri.parse(baseUrl +
        'molex/material-tracking/tracking-cable-terminalB?partNo=$partNo');
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
    var url = Uri.parse(baseUrl + 'molex/wccr/generate-label');
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
    var url =
        Uri.parse(baseUrl + 'molex/production-report/save-production-report');
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
    var url = Uri.parse(baseUrl +
        'molex/partial-completion-reason/save-in-partial-completion-reason');
    var response = await http.post(url,
        body: postpartiallyCompleteToJson(postpartiallyComplete));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Transfer bundle
  Future<bool> transferBundle(TransferBundle transferBundle) async {
    var url = Uri.parse(baseUrl + '');
    var response = await http.post(url,
        body: transferBundleToJson(transferBundle), headers: headerList);
    print("response of transefer bundle ${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<bool> postpartialComplete(
  // Location Updation PUT method

//Visual Inspection
//
//get Visual inspection Data
//TODO VISUAL INSPECTION
  Future<List<ViScheduler>> getviSchedule() async {
    var url = Uri.parse(
        baseUrl + 'molex/visual-inspection/get-visual-inspection-data');
    var response = await http.get(url);
    print('ViScheduler status Code: ${response.statusCode}');
    print(response.body);
    if (response.statusCode == 200) {
      GetViSchedule getViSchedule = getViScheduleFromJson(response.body);
      List<ViScheduler> viScheduleList =
          getViSchedule.data.visualInspectionScheduler;
      return viScheduleList;
    } else {
      return [];
    }
  }

  //pOST Accept viual inspection schedular data
  Future<bool> postVisualInspectionSchedular(
      PostViSchedule postViSchedule) async {
    var url = Uri.parse(baseUrl +
        'molex/visual-inspection/accept-visual-inspection-scheduler-data');
    var response = await http.post(url,
        body: postViScheduleToJson(postViSchedule), headers: headerList);
    print('Post ViSchedular status code:${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //Save Visual Inspected bundle quantity
  Future<bool> postVisualInspectedBundleQuantity(
      PostSaveViBundleQty postSaveViBundleQty) async {
    var url = Uri.parse(baseUrl +
        'molex/visual-inspection/accept-visual-inspection-scheduler-data');
    var response = await http.post(url,
        body: postSaveViBundleQtyToJson(postSaveViBundleQty),
        headers: headerList);
    print("Post Save Visual Inspected Bundle Quality :${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Update Bundle Status in Schedule Master
  Future<bool> updateBundleStatus(
      ViUpdateBundleStatus viUpdateBundleStatus) async {
    var url = Uri.parse(
        baseUrl + 'molex/scheduler/update-bundle-status-in-schedule-master');
    var response = await http.post(url,
        body: viUpdateBundleStatusToJson(viUpdateBundleStatus),
        headers: headerList);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  //Update bundle Status in Schedule Start Track
  Future<bool> viUpdateBundleStartTracking(
      ViUpdateBundleStatusScheduleStartTracking viUpdateBundleStatusScheduleStartTracking) async {
    var url = Uri.parse(
        baseUrl + 'molex/scheduler/update-bundle-status-in-schedule-master');
    var response = await http.post(url,
        body: viUpdateBundleStatusScheduleStartTrackingToJson(viUpdateBundleStatusScheduleStartTracking),
        headers: headerList);
        print("post update bundle status in track: ${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
