import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:molex/model_api/cableDetails_model.dart';
import 'package:molex/model_api/cableTerminalA_model.dart';
import 'package:molex/model_api/cableTerminalB_model.dart';
import 'package:molex/model_api/fgDetail_model.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/model_api/startProcess_model.dart';
import 'package:molex/models/bundle_print.dart';
import 'package:molex/screens/operator/bin.dart';
import 'package:molex/screens/operator/process/100complete.dart';
import 'package:molex/screens/operator/process/generateLabel.dart';
import 'package:molex/screens/operator/process/partiallyComplete.dart';
import 'package:molex/screens/widgets/P1AutoCurScheduledetail.dart';
import 'package:molex/screens/widgets/P1processDetail.dart';
import 'package:molex/screens/widgets/P3scheduleDetaiLWIP.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';

class ProcessPage extends StatefulWidget {
  String userId;
  MachineDetails machine;
  Schedule schedule;
  ProcessPage({this.machine, this.userId, this.schedule});
  @override
  _ProcessPageState createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
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
          'Auto Cut & Crimp',
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
          Container(
            padding: EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.person,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            widget.userId,
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ],
                      )),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.settings,
                              size: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            widget.machine.machineNumber ?? "",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ],
                      )),
                    ),
                  ],
                )
              ],
            ),
          ),

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
                schedule: widget.schedule,
                userId: widget.userId,
                machine: widget.machine,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Detail extends StatefulWidget {
  Schedule schedule;
  String rightside;
  String userId;
  MachineDetails machine;
  Detail({this.schedule, this.rightside, this.machine, this.userId});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String _chosenValue;
  String value;
  String output = '';
  String _output = '';
  TextEditingController _qtyController = new TextEditingController();
  List<BundlePrint> bundlePrint = [];
  static const platform = const MethodChannel('com.impereal.dev/tsc');
  String _printerStatus = 'Waiting';
  bool orderDetailExpanded = true;
  String rightside = 'label';
  ApiService apiService;
  @override
  void initState() {
    apiService = new ApiService();
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

   void continueProcess(String name) {
    setState(() {
      rightside = name;
    });
  }
  Future<void> _print({
    String ipaddress,
    String bq,
    String qr,
    String routenumber1,
    String fgPartNumber,
    String cutlength,
    String cablepart,
    String wireGauge,
    String terminalfrom,
    String terminalto,
  }) async {
    String printerStatus;

    try {
      final String result = await platform.invokeMethod('Print', {
        "ipaddress": ipaddress,
        "bundleQty": bq,
        "qr": qr,
        "routenumber1": routenumber1,
        "fgPartNumber": fgPartNumber,
        "cutlength": cutlength,
        "cutpart": cablepart,
        "wireGauge": wireGauge,
        "terminalfrom": terminalfrom,
        "terminalto": terminalto,
      });
      printerStatus = 'Printer status : $result % .';
    } on PlatformException catch (e) {
      printerStatus = "Failed to get printer: '${e.message}'.";
    }
    Fluttertoast.showToast(
        msg: "$printerStatus",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    setState(() {
      _printerStatus = printerStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          P1ScheduleDetailWIP(schedule: widget.schedule),

          // terminal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              startProcess(),
            ],
          ),
          (() {
            if (_chosenValue != null) {
              return Column(children: [
                terminal(),
                // P1ProcessDetail(cablePartNo: widget.schedule.cablePartNumber,fgpartNo: widget.schedule.finishedGoodsNumber),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Process(
                      type: _chosenValue,
                      schedule: widget.schedule,
                      machine: widget.machine,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        width: 350,
                        height: 96,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //100% complete
                                Container(
                                  width: 330,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //100% complete
                                      Container(
                                        height: 40,
                                        width: 160,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: BorderSide(
                                                        color: Colors
                                                            .transparent))),
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed))
                                                  return Colors.green[200];
                                                return Colors.green[
                                                    500]; // Use the component's default.
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              rightside = 'complete';
                                            });
                                          },
                                          child: Text(
                                            "100% complete",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //partially complete
                                      Container(
                                        height: 40,
                                        width: 160,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: BorderSide(
                                                        color: Colors
                                                            .transparent))),
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                                if (states.contains(
                                                    MaterialState.pressed))
                                                  return Colors.green[200];
                                                return Colors.red[
                                                    500]; // Use the component's default.
                                              },
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              rightside = "partial";
                                            });
                                          },
                                          child: Text(
                                            "Partially  Complete",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 330,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      //partially complete
                                      //Reload material
                                      Container(
                                        height: 40,
                                        width: 160,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .transparent))),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                      MaterialState.pressed))
                                                    return Colors.green[200];
                                                  return Colors.blue[
                                                      500]; // Use the component's default.
                                                },
                                              ),
                                            ),
                                            child: Text(
                                              'Reload Material',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                //Relaod Material
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]);
            } else {
              return Container();
            }
          }()),
          (() {
            if (_chosenValue != null) {
              return Container(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: (() {
                              if (rightside == null) {
                                return Container();
                              } else if (rightside == "label") {
                                return GenerateLabel(
                                  schedule: widget.schedule,
                                  machine: widget.machine ,
                                  userId: widget.userId,
                                );
                              } else if (rightside == "complete") {
                                return FullyComplete(
                                  userId: widget.userId,
                                  machine: widget.machine,
                                );
                              } else if (rightside == "partial") {
                                return PartiallyComplete(
                                  userId: widget.userId,
                                  machine: widget.machine,
                                  continueProcess: continueProcess,
                                );
                              } else if (rightside == "bundle") {
                                return bundleTable();
                              } else {
                                return Container();
                              }
                            }()),
                          ),
                        ),
                      ],
                    ),
                    //buttons
                    // Table for bundles generated
                  ],
                ),
              );
            } else {
              return Container();
            }
          }())
        ],
      ),
    );
  }

  //Bundle table
  Widget bundleTable() {
    return DataTable(
        columnSpacing: 40,
        columns: const <DataColumn>[
          DataColumn(
            label: Text('No.'),
          ),
          DataColumn(
            label: Text('Bundle Id'),
          ),
          DataColumn(
            label: Text('Bundel Qty'),
          ),
          DataColumn(
            label: Text('Action'),
          ),
        ],
        rows: bundlePrint
            .map((e) => DataRow(cells: <DataCell>[
                  DataCell(Text("1")),
                  DataCell(Text(e.bundelId)),
                  DataCell(Text(e.bundleQty)),
                  DataCell(ElevatedButton(
                    onPressed: () {
                      _print();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.red))),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.redAccent;
                          return Colors.red; // Use the component's default.
                        },
                      ),
                    ),
                    child: Text(
                      "Print",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ))
                ]))
            .toList());
  }

  Future<void> _showConfirmationDialog() async {
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Transfer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Status ${_printerStatus}')],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Future.delayed(
                    const Duration(milliseconds: 50),
                    () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                  );
                },
                child: Text('Cancel Transfer')),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.green),
                ),
                onPressed: () {},
                child: Text('Confirm Transfer')),
          ],
        );
      },
    );
  }

  //Material Sheet for qty

  Widget terminal() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        height: 91,
        width: MediaQuery.of(context).size.width,
        // color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // terminal A
            Container(
              height: 91,
              child: FutureBuilder(
                  future: apiService.getCableTerminalA(
                      cablepartno: widget.schedule.cablePartNumber ??
                          widget.schedule.finishedGoodsNumber),
                  builder: (context, snapshot) {
                    CableTerminalA terminalA = snapshot.data;
                    if (snapshot.hasData) {
                      return process(
                          'From Process',
                          '',
                          // 'From Strip Length Spec(mm) - ${terminalA.fronStripLengthSpec}',
                          'Process (Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
                          '(${terminalA.processType})(${terminalA.stripLength})(${terminalA.terminalPart})(${terminalA.specCrimpLength})(${terminalA.comment})',
                          '',
                          0.35);
                    } else {
                      return process(
                          'From Process',
                          '',
                          'Process (Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
                          '(-)()(-)(-)(-)',
                          '',
                          0.325);
                    }
                  }),
            ),
            FutureBuilder(
                future: apiService.getCableDetails(
                    fgpartNo: widget.schedule.finishedGoodsNumber,
                    cablepartno: widget.schedule.cablePartNumber ?? "0"),
                builder: (context, snapshot) {
                  CableDetails cableDetail = snapshot.data;
                  if (snapshot.hasData) {
                    return process(
                        'Cable',
                        'Cut Length Spec(mm) -${cableDetail.cutLengthSpec}',
                        'Cable Part Number(Description)',
                        '${cableDetail.cablePartNumber}(${cableDetail.description })',
                        'From Strip Length Spec(mm) ${cableDetail.stripLengthFrom} \n To Strip Length Spec(mm) ${cableDetail.stripLengthTo}',
                        0.28);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            FutureBuilder(
                future: apiService.getCableTerminalB(
                    cablepartno: widget.schedule.cablePartNumber ??
                        widget.schedule.finishedGoodsNumber),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    CableTerminalB cableTerminalB = snapshot.data;
                    return process(
                        'To Process',
                        '',
                        // 'To Strip Length Spec(mm) - ${cableTerminalB.stripLength}',
                        'Process(Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
                        '(${cableTerminalB.processType})(${cableTerminalB.stripLength})(${cableTerminalB.terminalPart})(${cableTerminalB.specCrimpLength})(${cableTerminalB.pullforce})(${cableTerminalB.comment})',
                        '',
                        0.34);
                  } else {
                    return process(
                        'To Process',
                        'From Strip Length Spec(mm) - 40}',
                        'Process (Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
                        '(-)()(-)(-)(-)',
                        '',
                        0.325);
                  }
                })
          ],
        ),
      ),
    );
  }
  // "localhost:9090//molex/scheduler/get-req-material-detail?machId=EMU-m/c-006C&fgNo=367680784&schdId=1223445
  //       localhost:9090//molex/scheduler/get-req-material-detail-from?machId=EMU-m/c-006C&fgNo=367680784&schdId=1223445
  //       localhost:9090//molex/scheduler/get-req-material-detail-to?machId=EMU-m/c-006C&fgNo=367680784&schdId=1223445"

  Widget process(
      String p1, String p2, String p3, String p4, String p5, double width) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey[100],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
        height: 91,
        width: MediaQuery.of(context).size.width * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(.3),
          //     blurRadius: 20.0, // soften the shadow
          //     spreadRadius: 0.0, //extend the shadow
          //     offset: Offset(
          //       3.0, // Move to right 10  horizontally
          //       3.0, // Move to bottom 10 Vertically
          //     ),
          //   )
          // ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.31,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          p1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          p2,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      p3,
                      style: TextStyle(fontSize: 9),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * width,
                      child: Text(
                        p4,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      p5,
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget quantitycell(String title, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25 * 0.6,
              child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  )),
            ),
            Container(
              height: 20,
              width: 60,
              child: TextField(
                readOnly: true,
                style: TextStyle(fontSize: 12),
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  hintText: "Qty",
                  labelStyle: TextStyle(fontSize: 10),
                  fillColor: Colors.white,

                  //fillColor: Colors.green
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tableHeading() {
    double width = MediaQuery.of(context).size.width;
    Widget cell(String name, double d) {
      return Container(
        color: Colors.white,
        width: width * d,
        height: 15,
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ),
      );
    }

    return Container(
      height: 15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cell("Order Id", 0.1),
              cell("FG Part", 0.1),
              cell("Schedule ID", 0.1),
              cell("Cable Part No.", 0.1),
              cell("Process", 0.1),
              cell("Cut Length(mm)", 0.1),
              cell("Color", 0.1),
              cell("Scheduled Qty", 0.1),
              cell("Schedule", 0.1)
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDataRow({Schedule schedule, int c}) {
    double width = MediaQuery.of(context).size.width;

    Widget cell(String name, double d) {
      return Container(
        width: width * d,
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 20,
      color: Colors.grey[100],
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
            color: schedule.scheduledStatus == "Completed"
                ? Colors.green
                : schedule.scheduledStatus == "Pending"
                    ? Colors.red
                    : Colors.green,
            width: 5,
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // orderId
            cell(schedule.orderId, 0.1),
            //Fg Part
            cell(schedule.finishedGoodsNumber, 0.1),
            //Schudule ID
            cell(schedule.scheduledId, 0.1),

            //Cable Part
            cell(schedule.cablePartNumber, 0.1),
            //Process
            cell(schedule.process, 0.1),
            // Cut length
            cell(schedule.length, 0.1),
            //Color
            cell(schedule.color, 0.1),
            //Scheduled Qty
            cell(schedule.scheduledQuantity, 0.1),
            //Schudule
            Container(
              width: width * 0.1,
              child: Center(
                child: Text(
                  "11:00 - 12:00",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fgDetails() {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: apiService.getFgDetails(widget.schedule.finishedGoodsNumber),
          builder: (context, snapshot) {
            print('fg number ${widget.schedule.finishedGoodsNumber}');
            if (snapshot.hasData) {
              FgDetails fgDetail = snapshot.data;
              return Container(
                decoration: BoxDecoration(),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          boxes("FG Description", fgDetail.fgDescription ?? ''),
                          boxes("FG Scheduled", fgDetail.fgScheduleDate ?? ''),
                          boxes("Customer", fgDetail.customer ?? ''),
                          boxes("Drg Rev", fgDetail.drgRev ?? ''),
                          boxes("Cable #", "${fgDetail.cableSerialNo ?? ''}"),
                          boxes('Tolerance ',
                              '± ${fgDetail.tolrance} / ±${fgDetail.tolrance}'),
                        ])),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget boxes(
    String str1,
    String str2,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            str1,
            style: TextStyle(fontSize: 10),
          ),
          Text(str2,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 12,
                  color: Colors.black)),
        ]),
      ),
    );
  }

  //tearmial A b and cable
  Widget startProcess() {
    if (_chosenValue == null) {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          child: Row(
            children: [
              DropdownButton<String>(
                focusColor: Colors.white,
                value: _chosenValue,
                //elevation: 5,
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,

                items: <String>[
                  'Terminal A,Cutlength,Terminal B',
                  'Terminal A,Cutlength',
                  'Cutlenght, Terminal B',
                  'Terminal A',
                  'Terminal B',
                  'Preparation',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                hint: Text(
                  'Select Terminal',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                onChanged: (String value) {
                  setState(() {
                    _chosenValue = value;
                    value = value;
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class Process extends StatefulWidget {
  final String type;
  final Schedule schedule;
  final MachineDetails machine;
  Process({this.type, this.schedule, this.machine});
  @override
  _ProcessState createState() => _ProcessState();
}

class _ProcessState extends State<Process> {
  bool expanded = true;
  PostStartProcessP1 process;
  ApiService apiService;
  @override
  void initState() {
    process = new PostStartProcessP1();
    print('check ${widget.schedule.scheduledId.toString()}');
    process.cablePartNumber = widget.schedule.cablePartNumber ?? "0";
    process.color = widget.schedule.color;
    process.finishedGoodsNumber = widget.schedule.finishedGoodsNumber ?? "0";
    process.lengthSpecificationInmm = widget.schedule.length ?? "0";
    process.machineIdentification = widget.machine.machineNumber;
    process.orderIdentification = widget.schedule.orderId ?? "0";
    //TODO: schedule id is giving empt string and not null
    // process.scheduledIdentification = int.parse(widget.schedule.scheduledId??"0");
    process.scheduledIdentification = widget.schedule.scheduledId;
    process.scheduledQuantity = widget.schedule.scheduledQuantity ?? "0";
    apiService = new ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Terminal A,Cutlength,Terminal B
    if (widget.type == "Terminal A,Cutlength,Terminal B") {
      return FutureBuilder(
          future: apiService.startProcess1(process),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 140,
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Text(
                                    "Process Type : \nTerminal A,\nCutlength,\nTerminal B",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        tableRow('Terminal A,Cutlength,Terminal B'),
                      ],
                    ),
                  ],
                );
              } else {
                return Center(child: Text('Could not Start Process'));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    }
    // Terminal A

    if (widget.type == "Terminal A") {
      return Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Process Type : \nTerminal A",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
              ],
            ),
          ),
          (() {
            if (expanded) {
              return Column(
                children: [
                  Row(
                    children: [],
                  ),
                  tableRow('Terminal A,Cutlength,Terminal B'),
                ],
              );
            } else {
              return Container();
            }
          }()),
        ],
      );
    }
    // Terminal B

    if (widget.type == "Terminal B") {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Process Type : Terminal B",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      )),
                ),
                tableRow('Terminal A,Cutlength,Terminal B'),
              ],
            ),
          ),
        ],
      );
    }
    if (widget.type == "Terminal A,Cutlength") {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Process Type :\n Terminal A,\nCutlength",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )),
                tableRow('Terminal A,Cutlength,Terminal B'),
              ],
            ),
          ),
          (() {
            if (expanded) {
              return Column(
                children: [
                  Row(
                    children: [],
                  ),
                ],
              );
            } else {
              return Container();
            }
          }()),
        ],
      );
    }

    if (widget.type == "Cutlenght, Terminal B") {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      "Process Type : \nCutlenght,\nTerminal B",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                tableRow('Terminal A,Cutlength,Terminal B'),
              ],
            ),
          ),
          (() {
            if (expanded) {
              return Column(
                children: [
                  Row(
                    children: [],
                  ),
                ],
              );
            } else {
              return Container();
            }
          }()),
        ],
      );
    }
    if (widget.type == "Preparation") {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Process Type : \n Preparation",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                ),
                tableRow('Terminal A,Cutlength,Terminal B'),
              ],
            ),
          ),
          (() {
            if (expanded) {
              return Column(
                children: [
                  Row(
                    children: [],
                  ),
                ],
              );
            } else {
              return Container();
            }
          }()),
        ],
      );
    } else {
      return Container(
        child: Center(
          child: Text(widget.type ?? ""),
        ),
      );
    }
  }

  Widget table(String type, String pn, String r, String l, String a, String p) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.47,
        child: Column(children: [
          row('Part No.', 'UOM', 'REQUIRED', 'LOADED', 'AVIALABE', 'PENDING',
              Colors.blue[100]),
          row('884538504', 'uom', '5000m', '1000m', '1000m', '2500m',
              Colors.grey[100]),
          row('884538504', 'uom', '5000m', '1000m', '1000m', '2500m',
              Colors.grey[100]),
          row('884538504', 'uom', '5000m', '1000m', '1000m', '2500m',
              Colors.grey[100]),
        ]));
  }

  Widget row(String partno, String uom, String require, String loaded,
      String available, String pending, Color color) {
    return Container(
      color: color,
      child: Row(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey[100])),
                height: 20,
                width: MediaQuery.of(context).size.width * 0.1,
                child: Center(
                    child: Text(partno, style: TextStyle(fontSize: 12)))),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[100])),
              height: 20,
              width: MediaQuery.of(context).size.width * 0.05,
              child: Center(
                child: Text(
                  uom,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[100])),
              height: 20,
              width: MediaQuery.of(context).size.width * 0.08,
              child: Center(
                child: Text(
                  require,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[100])),
              height: 20,
              width: MediaQuery.of(context).size.width * 0.08,
              child: Center(
                child: Text(
                  loaded,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[100])),
              height: 20,
              width: MediaQuery.of(context).size.width * 0.08,
              child: Center(
                child: Text(
                  available,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[100])),
              height: 20,
              width: MediaQuery.of(context).size.width * 0.08,
              child: Center(
                child: Text(
                  pending,
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }

  Widget tableRow(String name) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      table(
        name,
        '884538504',
        '5000m',
        '2500m',
        '1000m',
        '2500m',
      ),
    ]);
  }
}
