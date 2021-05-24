import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:molex/model_api/cableDetails_model.dart';
import 'package:molex/model_api/cableTerminalA_model.dart';
import 'package:molex/model_api/cableTerminalB_model.dart';
import 'package:molex/model_api/crimping/getCrimpingSchedule.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/model_api/materialTrackingCableDetails_model.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/models/bundle_scan.dart';
import 'package:molex/screens/Crimping%20Patrol/CrimpingPartrolDash.dart';
import 'package:molex/screens/operator%202/process/FullyCompleteP2.dart';
import 'package:molex/screens/operator%202/process/partialCompletion.dart';
import 'package:molex/screens/operator%202/process/scanBundle.dart';
import 'package:molex/screens/operator/bin.dart';
import 'package:molex/screens/widgets/P2CrimpingScheduledetail.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';

class ProcessPage2 extends StatefulWidget {
  final String userId;
  final MachineDetails machine;
  final CrimpingSchedule schedule;
  ProcessPage2({this.machine, this.userId, this.schedule});
  @override
  _ProcessPage2State createState() => _ProcessPage2State();
}

class _ProcessPage2State extends State<ProcessPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Crimping',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        actions: [

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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CrimpingPatrolDash(
                          userId: widget.userId,
                          machineId: widget.machine.machineNumber,
                        )),
              );
            },
            child: Padding(
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
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: Stream.periodic(const Duration(milliseconds: 2000)),
          builder: (context, snapshot) {
            return Column(
              children: [
                Detail(
                  schedule: widget.schedule,
                  userId: widget.userId,
                  machine: widget.machine,
                ),
              ],
            );
          }),
    );
  }
}

class Detail extends StatefulWidget {
  String userId;
  MachineDetails machine;
  CrimpingSchedule schedule;
  Detail({this.schedule, this.machine, this.userId});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String _chosenValue;
  String value;
  bool scanTap = false;
  FocusNode scanBundleFocus = new FocusNode();
  List<BundleScan> bundleScan = [];
  String scanId;
  TextEditingController _scanIdController = new TextEditingController();
  bool orderDetailExpanded = true;
  String rightside;
  String output = '';
  String _output = '';
  String mainb;
  ApiService apiService;
  @override
  void initState() {
    apiService = new ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(children: [
          P2ScheduleDetailWIP(
            schedule: widget.schedule,
          ),
          // tableHeading(),
          // buildDataRow(schedule: widget.schedule),
          // fgDetails(),
        ]),
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        color: Colors.transparent,
                        child: Process(
                          type: _chosenValue,
                          schedule: widget.schedule,
                        )),

                    //buttons and num pad
                    Container(
                        width: 350,
                        height: 96,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 330,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //Scan Bundle Button
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
                                            child: Text(
                                              'Scan Bundle',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                mainb = "scanBundle";
                                                Future.delayed(
                                                  const Duration(
                                                      milliseconds: 50),
                                                  () {
                                                    SystemChannels.textInput
                                                        .invokeMethod(
                                                            'TextInput.hide');
                                                  },
                                                );
                                              });
                                            }),
                                      ),

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
                                              mainb = "100";
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
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 330,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      //Partially complete
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
                                              mainb = "partial";
                                            });
                                          },
                                          child: Text(
                                            "Partially  complete",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Reload Material
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
                                              Future.delayed(
                                                const Duration(
                                                    milliseconds: 10),
                                                () {
                                                  SystemChannels.textInput
                                                      .invokeMethod(
                                                          'TextInput.hide');
                                                },
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              mainBox(mainb),
            ]);
          } else {
            return Container();
          }
        }()),
      ]),
    );
  }

  Widget mainBox(String main) {
    if (main == "scanBundle") {
      return ScanBundle(
        machineId: widget.machine.machineNumber,
        userId: widget.userId,
        schedule: widget.schedule,
      );
    }
    if (main == "100") {
      return FullCompleteP2(
        userId: widget.userId,
        machine: widget.machine,
      );
    }
    if (main == "partial") {
      return PartialCompletionP2(
        machine: widget.machine,
        userId: widget.userId,
      );
    } else {
      return Container();
    }
  }

  Widget quantity(String title, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.25 * 0.4,
            //   child: Text(title,
            //       style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //         fontSize: 15,
            //       )),
            // ),
            Container(
              height: 35,
              width: 130,
              child: TextField(
                style: TextStyle(fontSize: 12),
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: title,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 15),
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),

                //fillColor: Colors.green
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget partialCompletion() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Partial Completion Reason',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ))
                      ]),
                ),
                Container(height: 25, width: 300, child: TextField()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          quantitycell("First Piece & Patrol", 10),
                          quantitycell("Spare Changeover", 10),
                          quantitycell("Crimp Height Setting", 10),
                          quantitycell("Resetting CFM Program	", 10),
                          quantitycell("New Program Setting CVM/CFM", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Air Pressure Low", 10),
                          quantitycell("Machine Taken for Removing CVM", 10),
                          quantitycell("No Material	", 10),
                          quantitycell("Applicator Changeover	", 10),
                          quantitycell("Sink Height Adjustment", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Feeding Adjustment	", 10),
                          quantitycell("Applicator Position Setting	", 10),
                          quantitycell("Validation", 10),
                          quantitycell("CFA Crimping Fault", 10),
                          quantitycell("Cable Entangle", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Job Ticket Issue", 10),
                          quantitycell("Length Changeover", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Cut Off Burr Issue", 10),
                          quantitycell("CVM Error Correction", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Cable Feeding Front Unit Problem", 10),
                          quantitycell("Drift Limit Reached	", 10),
                          quantitycell("Machine Slow", 10),
                          quantitycell("No Plan for Machine", 10),
                          quantitycell("Terminal Changeover", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Extrusion Burr Issue", 10),
                          quantitycell("CFM Error", 10),
                          quantitycell("Supplier Taken for Maintenance", 10),
                          quantitycell("Roller Changeover", 10),
                          quantitycell("Gripen Unit Problem", 10),
                          quantitycell("Technician Not Available", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Coil Changeover	", 10),
                          quantitycell("Bellmouth Adjustment	", 10),
                          quantitycell("Camera Setting", 10),
                          quantitycell("CVM Error	", 10),
                          quantitycell("Length Variations		", 10),
                          quantitycell("Power Failure", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Last Piece", 10),
                          quantitycell("Curling Adjustment	", 10),
                          quantitycell("Wire Feeding Adjustment", 10),
                          quantitycell("CVM Program Reloading	", 10),
                          quantitycell("Sensor Not Working", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Machine Cleaning", 10),
                          quantitycell("No Operator", 10),
                          quantitycell("Preventive Maintenance", 10),
                          quantitycell("Meeting", 10),
                          quantitycell("System Fault", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Machine Cleaning", 10),
                          quantitycell("No Operator", 10),
                          quantitycell("Preventive Maintenance", 10),
                          quantitycell("Meeting", 10),
                          quantitycell("System Fault", 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 95.0),
                  child: Container(
                    child: Center(
                      child: Container(
                        height: 40,
                        width: 250,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: Colors.transparent))),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.green[200];
                                  return Colors.green[
                                      500]; // Use the component's default.
                                },
                              ),
                            ),
                            child: Text("Accept and Continue Process"),
                            onPressed: () {
                              Navigator.pop(
                                context,
                              );
                            }),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Container(
                        height: 45,
                        width: 250,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      side: BorderSide(
                                          color: Colors.transparent))),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.green[200];
                                  return Colors.green[
                                      500]; // Use the component's default.
                                },
                              ),
                            ),
                            child: Text("Save & End Process"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Bin(
                                          userId: widget.userId,
                                          machine: widget.machine,
                                        )),
                              );
                            }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bundlerejection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Crimping Rejection Cases',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          quantitycell("Terminal Damage", 10),
                          quantitycell("Window Gap	", 10),
                          quantitycell("Cut-off Burr", 10),
                          quantitycell("Terminal Copper Mark", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Crimp On Insulation	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Cut-off Bend	", 10),
                          quantitycell("Setup Rejections", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Improper Crimping", 10),
                          quantitycell("Insulation Damage	", 10),
                          quantitycell("Terminal Back Out", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Conductor Curling Up & Down", 10),
                          quantitycell("Tab Bend / Tap Open	", 10),
                          quantitycell("Exposure Strands		", 10),
                          quantitycell("Insulation Curling Up & Down", 10),
                          quantitycell("Bellmouth Less / More", 10),
                          quantitycell("Strands Cut", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Changeover", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Extrusion Burr Issue", 10),
                          quantitycell("CFM Error", 10),
                          quantitycell("Supplier Taken for Maintenance", 10),
                          quantitycell("Roller Changeover	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Conductor Burr	", 10),
                          quantitycell("Cut-Off Less / More	", 10),
                          quantitycell("Brush Length Less / More", 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  quantity("Bundle Qty", 10),
                  quantity("Passed Qty", 10),
                  quantity("Rejected Qty", 10),
                ],
              ),
            ),
            Container(
              height: 50,
              child: Center(
                child: Container(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side:
                                        BorderSide(color: Colors.transparent))),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.green[200];
                            return Colors
                                .green[500]; // Use the component's default.
                          },
                        ),
                      ),
                      child: Text("Save & Scan Next"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bin(
                                    userId: widget.userId,
                                    machine: widget.machine,
                                  )),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget keypad() {
    buttonPressed(String buttonText) {
      if (buttonText == 'clear') {
        _output = '';
      } else {
        _output = _output + buttonText;
      }

      print(_output);
      setState(() {
        _scanIdController.text = _output;
        output = int.parse(_output).toStringAsFixed(2);
      });
    }

    Widget buildbutton(String buttonText) {
      return new Expanded(
          child: Container(
        width: 30,
        height: 40,
        child: new OutlineButton(
          padding: EdgeInsets.all(10.0),
          child: new Text(
            buttonText,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          onPressed: () => {buttonPressed(buttonText)},
          textColor: Colors.black,
        ),
      ));
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      height: MediaQuery.of(context).size.height * 0.27,
      child: Column(
        children: [
          Row(
            children: [
              buildbutton("7"),
              buildbutton('8'),
              buildbutton('9'),
            ],
          ),
          Row(
            children: [
              buildbutton('4'),
              buildbutton('5'),
              buildbutton('6'),
            ],
          ),
          Row(
            children: [
              buildbutton('1'),
              buildbutton('2'),
              buildbutton('3'),
            ],
          ),
          Row(
            children: [
              buildbutton('00'),
              buildbutton('0'),
              buildbutton('clear'),
            ],
          ),
        ],
      ),
    );
  }

  Widget scanedTable() {
    int a = 1;
    if (bundleScan.length > 0) {
      return DataTable(
          columnSpacing: 35,
          columns: <DataColumn>[
            DataColumn(
              label: Text('S No.',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(fontWeight: FontWeight.bold))),
            ),
            DataColumn(
              label: Text('Bundle Id',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(fontWeight: FontWeight.bold))),
            ),
            DataColumn(
              label: Text('Bundle Qty',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(fontWeight: FontWeight.bold))),
            ),
            DataColumn(
              label: Text('Process Qty',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(fontWeight: FontWeight.bold))),
            ),
            DataColumn(
              label: Text('Remove',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
          rows: bundleScan
              .map((e) => DataRow(cells: <DataCell>[
                    DataCell(Text("${a++}",
                        style: GoogleFonts.openSans(textStyle: TextStyle()))),
                    DataCell(Text(e.bundleId,
                        style: GoogleFonts.openSans(textStyle: TextStyle()))),
                    DataCell(Text(
                      e.bundleQty,
                    )),
                    DataCell(Text(e.bundleProcessQty,
                        style: GoogleFonts.openSans(textStyle: TextStyle()))),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        bundleScan.remove(e);
                      },
                    )),
                  ]))
              .toList());
    } else {
      return Container();
    }
  }

  handleKey(RawKeyEventDataAndroid key) {
    String _keyCode;
    _keyCode = key.keyCode.toString(); //keyCode of key event(66 is return )
    print("why does this run twice $_keyCode");

    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }
  //Material Sheet for qty

  Widget quantitycell(String title, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
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
      width: MediaQuery.of(context).size.width,
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
                    : Colors.green[100],
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
                      cablepartno:
                          "${widget.schedule.cablePartNo.toString()}" ??
                              "${widget.schedule.finishedGoods}"),
                  builder: (context, snapshot) {
                    CableTerminalA terminalA = snapshot.data;
                    if (snapshot.hasData) {
                      return process(
                          'From Process',
                          '',
                          // 'From Strip Length Spec(mm) - ${terminalA.fronStripLengthSpec}',
                          'Process (Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
                          '(${terminalA.processType})(${terminalA.stripLength})(${terminalA.terminalPart})(${terminalA.specCrimpLength})(${terminalA.pullforce})(${terminalA.comment})',
                          '',
                          // 'From Unsheathing Length (mm) - 40',
                          0.35);
                    } else {
                      return process(
                          'From Process',
                          '',
                          'Process (Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
                          '(-)()(-)(-)(-)',
                          '',
                          // 'From Unsheathing Length (mm) - 40',
                          0.325);
                    }
                  }),
            ),
            FutureBuilder(
                future: apiService.getCableDetails(
                    fgpartNo: "${widget.schedule.finishedGoods}",
                    cablepartno: "${widget.schedule.cablePartNo}" ?? "0"),
                builder: (context, snapshot) {
                  CableDetails cableDetail = snapshot.data;
                  if (snapshot.hasData) {
                    return process(
                        'Cable',
                        'Cut Length Spec(mm) -${cableDetail.cutLengthSpec}',
                        'Cable Part Number(Description)',
                        '${cableDetail.cablePartNumber}(${cableDetail.description})',
                        'From Strip Length Spec(mm) ${cableDetail.stripLengthFrom}} \n To Strip Length Spec(mm) ${cableDetail.stripLengthTo}}',
                        0.28);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            FutureBuilder(
                future: apiService.getCableTerminalB(
                    cablepartno: "${widget.schedule.cablePartNo}" ??
                        "${widget.schedule.finishedGoods}"),
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
                        // 'From Unsheathing Length (mm) - 40',''
                        '',
                        0.325);
                  }
                })
          ],
        ),
      ),
    );
  }

  // Widget terminal() {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 2.0),
  //     child: Container(
  //       height: 80,
  //       width: MediaQuery.of(context).size.width,
  //       color: Colors.white,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           process(
  //               'From Process',
  //               'From Strip Length Spec(mm) - 40',
  //               'Process (Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
  //               '(SC)(4.00-4.50)(367760073)(CIC APPL-1.16-1.23)(5.89)',
  //               'From Unsheathing Length (mm) - 40'),
  //           process(
  //               'Cable',
  //               'Cut Length Spec(mm) - 2060',
  //               'Cable Part Number(Description)',
  //               '884566210(3X20AWG SHIELD PVC GR 4.9MM UL2464)',
  //               ''),
  //           process(
  //               'To Process',
  //               'To Strip Length Spec(mm) - 60',
  //               'Process(Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
  //               '(SC)(3.00-3.50)(367760073)(JAM APPL-0.86-0.96)(5.89)(ICH-2.72 REF)',
  //               'To Unsheathing Length (mm) - 60'),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                  'Terminal A Crimping',
                  'Terminal B Crimping',
                  'Terminal A,B Crimping',
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
                  'Select Process',
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
  String type;
  CrimpingSchedule schedule;
  Process({this.type, this.schedule});
  @override
  _ProcessState createState() => _ProcessState();
}

class _ProcessState extends State<Process> {
  bool expanded = true;
  @override
  Widget build(BuildContext context) {
    // Terminal A,Cutlength,Terminal B
    if (widget.type != null) {
      return Column(
        children: [
          Row(
            children: [
              Container(
                width: 140,
                height: 70,
                padding: const EdgeInsets.all(0.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
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
              ),
              tableRow('Terminal A,Cutlength,Terminal B'),
            ],
          ),
          // table for Process
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
                      "Process Type :\n Terminal A,Cutlength",
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
                      "Process Type : \nCutlenght, Terminal B",
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

  Widget process(String p1, String p2, String p3, String p4, String p5) {
    return Padding(
      padding: const EdgeInsets.all(.0),
      child: Container(
        height: 70,
        // width: MediaQuery.of(context).size.width * 0.32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(0.0),
            //   child: Container(
            //     height: 80.0,
            //     width: 85,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage('assets/image/terminal_a.jpg'),
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   width: 8,
            // ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.31,
                child: Column(
                  children: [
                    // Text(
                    //   p1,
                    //   style: TextStyle(
                    //     fontSize: 10,
                    //   ),
                    // ),
                    Text(
                      p2,
                      style: TextStyle(
                        fontSize: 0,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      p3,
                      style: TextStyle(fontSize: 0),
                    ),
                    Text(
                      p4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      p5,
                      style: TextStyle(fontSize: 0),
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

  Widget table() {
    ApiService apiService = new ApiService();
    return FutureBuilder(
        future: apiService.getMaterialTrackingCableDetail(
            partNo: "${widget.schedule.cablePartNo}"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            MaterialTrackingCable materialTrackingCable = snapshot.data;
            return Container(
                width: MediaQuery.of(context).size.width * 0.47,
                child: Column(children: [
                  row('Part No.', 'UOM', 'REQUIRED', 'LOADED', 'AVIALABE',
                      'PENDING', Colors.blue[100]),
                  row(
                      "${materialTrackingCable.partNumber.toString()}",
                      "${materialTrackingCable.uom}",
                      "${materialTrackingCable.required1.toString()}",
                      "${materialTrackingCable.loaded.toString()}",
                      "${materialTrackingCable.available.toString()}",
                      "${materialTrackingCable.pending.toString()}",
                      Colors.grey[100]),
                ]));
          } else {
            return Container(
                width: MediaQuery.of(context).size.width * 0.47,
                child: Column(
                  children: [
                    row('Part No.', 'UOM', 'REQUIRED', 'LOADED', 'AVIALABE',
                        'PENDING', Colors.blue[100]),
                  ],
                ));
          }
        });
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
      ),
    ]);
  }
}
