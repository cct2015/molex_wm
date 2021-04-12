import 'package:flutter/material.dart';
import 'package:molex/models/Schudule.dart';
import 'package:molex/screens/operator%202/process2.dart';
import 'package:molex/screens/operator%203/process3.dart';
import 'package:molex/screens/operator/Home_material_coordinator.dart';
import 'package:molex/screens/visual%20Inspector/Home_visual_inspector.dart';

class NavPage extends StatefulWidget {
  String userId;
  String machineId;
  Schedule schedule;
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
                    builder: (context) => ProcessPage2(
                          schedule: widget.schedule,
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
                    builder: (context) => Processpage3(
                          schedule: widget.schedule,
                          machineId: widget.machineId,
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
                          machineId: widget.machineId,
                          userId: widget.userId,
                        )),
              );
            },
          ),
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
          )
        ],
      ),
    );
  }
}
