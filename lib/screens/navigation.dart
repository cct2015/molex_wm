import 'package:flutter/material.dart';

import 'package:molex/login.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/screens/Preparation/preparationDash.dart';
import 'package:molex/screens/operator%202/Home_0p2.dart';
import 'package:molex/screens/print.dart';
import 'package:molex/screens/visual%20Inspector/Home_visual_inspector.dart';
import 'package:molex/service/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavPage extends StatefulWidget {
  final String userId;
  final MachineDetails machine;
  final Schedule schedule;
  NavPage({this.machine, this.userId, this.schedule});
  @override
  _NavPageState createState() => _NavPageState(); 
}

class _NavPageState extends State<NavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Crimping'),
            onTap: () {
              ApiService apiService = new ApiService();
              apiService.getmachinedetails(widget.machine.machineNumber).then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePageOp2(
                            machine: value[0],
                            userId: widget.userId,
                          )),
                );
              });
            },
          ),
          ListTile(
            title: Text('Preparation'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PreprationDash(
                         
                          userId: widget.userId,
                        )),
              );
            },
          ),
          ListTile(
            title: Text("Visual Inspector"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeVisualInspector(
                          machineId: widget.machine.machineNumber,
                          userId: widget.userId,
                        )),
              );
            },
          ),
          // ListTile(
          //   title: Text("Material Coordinator"),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => HomeMaterialCoordinator(
          //                 machineId: widget.machineId,
          //                 userId: widget.userId,
          //               )),
          //     );
          //   },
          // ),
          ListTile(
            title: Text("Print Test"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrintTest()),
              );
            },
          ),
          ListTile(
            title: Text("Log Out"),
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.remove('login');

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScan()),
              );
            },
          )
        ],
      ),
    );
  }
}
