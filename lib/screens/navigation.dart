import 'package:flutter/material.dart';

import 'package:molex/login.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/screens/operator%202/Home_0p2.dart';
import 'package:molex/screens/operator%203/Home_0p3.dart';
import 'package:molex/screens/Matrial_Cordinator/Home_material_coordinator.dart';
import 'package:molex/screens/print.dart';
import 'package:molex/screens/visual%20Inspector/Home_visual_inspector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavPage extends StatefulWidget {
  final String userId;
  final String machineId;
  final Schedule schedule;
  NavPage({this.machineId, this.userId, this.schedule});
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
            title: Text('Operator process 2'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePageOp2(
                          machineId: widget.machineId,
                          userId: widget.userId,
                        )),
              );
            },
          ),
          ListTile(
            title: Text('Operator Process 3'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePageOp3(
                          machineId: widget.machineId,
                          userId: widget.userId,
                        )),
              );
            },
          ),
          // ListTile(
          //   title: Text("Visual Inspector"),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => HomeVisualInspector(
          //                 machineId: widget.machineId,
          //                 userId: widget.userId,
          //               )),
          //     );
          //   },
          // ),
          ListTile(
            title: Text("Material Coordinator"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeMaterialCoordinator(
                          machineId: widget.machineId,
                          userId: widget.userId,
                        )),
              );
            },
          ),
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
