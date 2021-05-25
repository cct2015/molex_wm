import 'package:molex/model_api/Transfer/getBinDetail.dart';
import 'package:molex/model_api/crimping/bundleDetail.dart';

class PreparationScan{
  String employeeId;
  String bundleId;
  String status;
  String binId;
  BundleData bundleDetail;
  PreparationScan({this.bundleId,this.bundleDetail,this.employeeId,this.status,this.binId});
}