import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static SharedPreferences _sharedPref;
  init() async {
    if(_sharedPref==null){
      _sharedPref = await SharedPreferences.getInstance();
    }
  }
  String get baseIp =>_sharedPref.getString("baseIp")?? "";

}
final sharedPrefs = SharedPref();