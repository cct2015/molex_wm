import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/login.dart';
import 'package:molex/screens/utils/SharePref.dart';
import 'package:molex/screens/utils/changeIp.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPref sharedPref = new SharedPref();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPref.init();
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
        title: 'Molex',
        theme: ThemeData(
          // fontFamily: 'OpenSans',
          primarySwatch: Colors.blue,
        ),
        home: ChangeIp()
        );
  }
}
