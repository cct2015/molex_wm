import 'package:molex/model_api/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:molex/model_api/schedular_model.dart';


class ApiService{

  Future<Employee> empIdlogin(String empId)async{
    String url = 'http://192.168.1.19:8080/molaxapi/molex/employee/get-employee-list?empId=$empId';
    var response = await http.get(url);
    print('Login  status Code ${response.statusCode}');
    if(response.statusCode==200){
      Login login = loginFromJson(response.body);
      Employee empolyee = login.data.employeeList;
      return empolyee;
    }else{
      return null;
    }

  }

  Future<List<Schedule1>> getScheduelarData(String machId)async{
    String url='';
    var response= await http.get(url);
    print('schedular data status code ${response.statusCode}');
    if(response.statusCode==200){
      Schedualr schedualr = schedualrFromJson(response.body);
      List<Schedule1> scheduleList = schedualr.data.employeeList;
      return scheduleList;
    }
    else{
      return [];
    }



  }

}