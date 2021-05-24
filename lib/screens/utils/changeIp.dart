import 'package:flutter/material.dart';
import 'package:molex/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeIp extends StatefulWidget {
  @override
  _ChangeIpState createState() => _ChangeIpState();
}

class _ChangeIpState extends State<ChangeIp> {
  SharedPreferences preferences;
  String baseip;
  getSharedPref() async {
    SharedPreferences preferenc = await SharedPreferences.getInstance();
    setState(() {
      preferences = preferenc;
      baseip = preferences.getString('baseIp');
    });
  }

  @override
  void initState() {
    getSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    baseip = preferences.getString('baseIp');
    print(baseip);
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Ip "),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              tileColor: baseip == "http://justerp.in:8080/wipts/"
                  ? Colors.red[200]
                  : Colors.white,
              title: Text("http://justerp.in:8080/wipts/"),
              onTap: () {
                setState(() {
                  preferences.setString(
                      'baseIp', "http://justerp.in:8080/wipts/");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScan()),
                  );
                });
              },
            ),
            ListTile(
              tileColor: baseip == "http://10.221.46.8:8080/wipts/"
                  ? Colors.red[200]
                  : Colors.white,
              title: Text("http://10.221.46.8:8080/wipts/"),
              onTap: () {
                setState(() {
                  preferences.setString(
                      'baseIp', "http://10.221.46.8:8080/wipts/");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScan()),
                  );
                });
              },
            ),
            ListTile(
              tileColor: baseip == "http://192.168.1.252:8080/wipts/"
                  ? Colors.red[200]
                  : Colors.white,
              title: Text("http://192.168.1.252:8080/wipts/"),
              onTap: () {
                setState(() {
                  preferences.setString(
                      'baseIp', "http://192.168.1.252:8080/wipts/");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScan()),
                  );
                });
              },
            ),
            ListTile(
              tileColor: baseip == "http://mlxbngvwqwip01.molex.com:8080/wipts/"
                  ? Colors.red[200]
                  : Colors.white,
              title: Text("http://mlxbngvwqwip01.molex.com:8080/wipts/"),
              onTap: () {
                setState(() {
                  preferences.setString(
                      'baseIp', "http://mlxbngvwqwip01.molex.com:8080/wipts/");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScan()),
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
