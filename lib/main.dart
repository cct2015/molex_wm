import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molex/login.dart';
import 'package:molex/screens/operator/Homepage.dart';
import 'package:molex/service/apiService.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences preferences =
  //     await SharedPreferences.getInstance(); //for recent search in search
  // var logged = preferences.getString('login');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final String logged;
  MyApp({this.logged});
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScan(
        ));
  }
}
