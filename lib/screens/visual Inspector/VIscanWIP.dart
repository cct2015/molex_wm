import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:molex/model_api/visualInspection/VI_scheduler_model.dart';
import 'package:molex/model_api/visualInspection/saveVIBundleQty.dart';
import 'package:molex/screens/visual%20Inspector/scanBundle.dart';
import 'package:molex/screens/widgets/VIscheduleDetailWIP.dart';
import 'package:molex/screens/widgets/time.dart';

class Viscan extends StatefulWidget {
  final String userId;
  final String machineId;
  final ViScheduler viSchedule;

  Viscan({this.userId, this.viSchedule, this.machineId});
  @override
  _ViscanState createState() => _ViscanState();
}

class _ViscanState extends State<Viscan> {
  ViScheduler viSchedule;
  PostSaveViBundleQty saveViBundleQty;
  @override
  void initState() {
    saveViBundleQty = new PostSaveViBundleQty();
    viSchedule = widget.viSchedule;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.red,
          ),
          title: const Text(
            'Visual Inspection',
            style: TextStyle(color: Colors.red),
          ),
          elevation: 0,
          actions: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Icon(
                          Icons.schedule,
                          size: 18,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                        "Shift A",
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ],
                  )),
                ),
              ],
            ),

            //machineID
            // Container(
            //   padding: EdgeInsets.all(1),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Container(
            //             padding: EdgeInsets.symmetric(horizontal: 10),
            //             height: 24,
            //             decoration: BoxDecoration(
            //               color: Colors.grey[100],
            //               borderRadius: BorderRadius.all(Radius.circular(100)),
            //             ),
            //             child: Center(
            //                 child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 Padding(
            //                   padding:
            //                       const EdgeInsets.symmetric(horizontal: 4.0),
            //                   child: Icon(
            //                     Icons.person,
            //                     size: 18,
            //                     color: Colors.redAccent,
            //                   ),
            //                 ),
            //                 Text(
            //                   widget.userId,
            //                   style:
            //                       TextStyle(fontSize: 13, color: Colors.black),
            //                 ),
            //               ],
            //             )),
            //           ),
                     
            //         ],
            //       )
            //     ],
            //   ),
            // ),

            TimeDisplay(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent[100],
                        offset: const Offset(
                          2.0,
                          2.0,
                        ),
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //Bo
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/image/profile.jpg',
                        ),
                        fit: BoxFit.fill)),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Detail(
                  viSchedule: widget.viSchedule,
                  userId: widget.userId,
                ),
              ],
            ),
          ),
        ));
  }
}

class Detail extends StatefulWidget {
  ViScheduler viSchedule;
  String rightside;
  String userId;
  
  @override
  Detail({this.viSchedule, this.rightside, this.userId});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool orderDetailExpanded = true;
  bool scanTap = false;
  TextEditingController scanBundleController = new TextEditingController();
  FocusNode scanFocus = new FocusNode();
  TextEditingController userScanController = new TextEditingController();
  FocusNode userScanFocus = new FocusNode();
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height-100,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          // ScheduleDetailWIP(
          //   viSchedule: widget.viSchedule,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height*0.6,
                   child: Center(child: ViScanBundle())),
            ],
          )
        ]));
  }
}
