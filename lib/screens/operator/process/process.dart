import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/models/Schudule.dart';
import 'package:molex/models/bundle_print.dart';
import 'package:molex/screens/operator/bin.dart';
import 'package:molex/screens/operator/process/100complete.dart';
import 'package:molex/screens/operator/process/generateLabel.dart';
import 'package:molex/screens/operator/process/partiallyComplete.dart';

class ProcessPage extends StatefulWidget {
  String userId;
  String machineId;
  Schedule1 schedule;
  ProcessPage({this.machineId, this.userId, this.schedule});
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
          'Process',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0,
        actions: [
          Container(
            padding: EdgeInsets.all(5),
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(1),
            height: 40,
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
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
                            widget.machineId ?? "",
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
          Container(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('MM-dd-yyyy').format(DateTime.now()),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      DateFormat('hh:mm').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 40,
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
        child: StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 2000)),
            builder: (context, snapshot) {
              return Container(
                child: Column(
                  children: [
                    Detail(
                      schedule: widget.schedule,
                      userId: widget.userId,
                      machineId: widget.machineId,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class Detail extends StatefulWidget {
  Schedule1 schedule;
  String rightside;
  String userId;
  String machineId;
  Detail({this.schedule, this.rightside, this.machineId, this.userId});
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
  Future<void> _print() async {
    String printerStatus;

    try {
      final String result = await platform.invokeMethod('Print');
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
          GestureDetector(
            onTap: () {
              setState(() {
                orderDetailExpanded = !orderDetailExpanded;
              });
            },
            child: Container(
              height: 20,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 4),
                    child: Text(
                      "Order Detail",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                  IconButton(
                      iconSize: 15,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(0),
                      icon: orderDetailExpanded
                          ? Icon(Icons.keyboard_arrow_down)
                          : Icon(Icons.keyboard_arrow_right),
                      onPressed: () {
                        setState(() {
                          orderDetailExpanded = !orderDetailExpanded;
                        });
                      })
                ],
              ),
            ),
          ),
          (() {
            if (orderDetailExpanded) {
              return Column(children: [
                tableHeading(),
                buildDataRow(schedule: widget.schedule),
                box(),
              ]);
            } else {
              return Container();
            }
          }()),

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
                Row(
                  children: [
                    Process(type: _chosenValue),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        width: 300,
                        height: 96,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //100% complete
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Label
                                Container(
                                  // height: 40,
                                  width: 145,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Colors.transparent))),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Colors.green[200];
                                          return Colors.green[
                                              500]; // Use the component's default.
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        rightside = "label";
                                      });
                                    },
                                    child: Text(
                                      "Label",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),

                                //100% complete
                                Container(
                                  // height: 40,
                                  width: 145,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              side: BorderSide(
                                                  color: Colors.transparent))),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
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
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //partially complete
                                Container(
                                  // height: 40,
                                  width: 145,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13.0),
                                              side: BorderSide(
                                                  color: Colors.transparent))),
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
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
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                //Reload material
                                Container(
                                  // height: 40,
                                  width: 145,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color:
                                                        Colors.transparent))),
                                        backgroundColor: MaterialStateProperty
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
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                              ],
                            ),
                            //Relaod Material
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
                                return GenerateLabel();
                              } else if (rightside == "complete") {
                                return FullyComplete();
                              } else if (rightside == "partial") {
                                return PartiallyComplete();
                              } else if (rightside == "bundle") {
                                return bundleTable();
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

  Widget keypad() {
    buttonPressed(String buttonText) {
      if (buttonText == 'clear') {
        _output = '';
      } else {
        _output = _output + buttonText;
      }

      print(_output);
      setState(() {
        _qtyController.text = _output;
        output = int.parse(_output).toStringAsFixed(2);
      });
    }

    Widget buildbutton(String buttonText) {
      return new Expanded(
          child: new OutlineButton(
        padding: EdgeInsets.all(12.0),
        child: new Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onPressed: () => {buttonPressed(buttonText)},
        textColor: Colors.black,
      ));
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
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
        height: 70,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            process(
                'Terminal A',
                'From Strip Length Spec(mm) - 40',
                'Process (Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
                '(SC)(4.00-4.50)(367760073)(CIC APPL-1.16-1.23)(5.89)',
                'From Unsheathing Length (mm) - 40'),
            process(
                'Cable',
                'Cut Length Spec(mm) - 2060',
                'Cable Part Number(Description)',
                '884566210(3X20AWG SHIELD PVC GR 4.9MM UL2464)',
                ''),
            process(
                'Terminal B',
                'To Strip Length Spec(mm) - 60',
                'Process(Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
                '(SC)(3.00-3.50)(367760073)(JAM APPL-0.86-0.96)(5.89)(ICH-2.72 REF)',
                'To Unsheathing Length (mm) - 60'),
          ],
        ),
      ),
    );
  }

  Widget process(String p1, String p2, String p3, String p4, String p5) {
    return Padding(
      padding: const EdgeInsets.all(.0),
      child: Container(
        padding: const EdgeInsets.all(0.0),
        height: 70,
        // width: MediaQuery.of(context).size.width * 0.32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                3.0, // Move to right 10  horizontally
                3.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.31,
                child: Column(
                  children: [
                    Text(
                      p2,
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      p3,
                      style: TextStyle(fontSize: 9),
                    ),
                    Text(
                      p4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
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

 
  Widget partialCompletion() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Partial Completion Reason',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ))
              ]),
            ),
            Row(
              children: [
                Container(height: 30, width: 300, child: TextField()),
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
                          quantitycell("Air Pressure Low", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Applicator Changeover	", 10),
                          quantitycell("Sink Height Adjustment", 10),
                          quantitycell("Feeding Adjustment	", 10),
                          quantitycell("Applicator Position Setting	", 10),
                          quantitycell("Validation", 10),
                          quantitycell("CFA Crimping Fault", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Length Changeover", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Cut Off Burr Issue", 10),
                          quantitycell("CVM Error Correction", 10),
                          quantitycell("Cable Feeding Front Unit Problem", 10),
                          quantitycell("Drift Limit Reached	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Changeover", 10),
                          quantitycell("Terminal Twist		", 10),
                          quantitycell("Extrusion Burr Issue", 10),
                          quantitycell("CFM Error", 10),
                          quantitycell("Supplier Taken for Maintenance", 10),
                          quantitycell("Roller Changeover", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Coil Changeover	", 10),
                          quantitycell("Bellmouth Adjustment	", 10),
                          quantitycell("Camera Setting", 10),
                          quantitycell("CVM Error	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Length Variations		", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Last Piece", 10),
                          quantitycell("Curling Adjustment	", 10),
                          quantitycell("Wire Feeding Adjustment", 10),
                          quantitycell("CVM Program Reloading	", 10),
                          quantitycell("Sensor Not Working", 10),
                          quantitycell("Preventive Maintenance", 10),
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
                            child: Text("Accept and Continue Process"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProcessPage()),
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
                                MaterialPageRoute(builder: (context) => Bin()),
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

   Widget buildDataRow({Schedule1 schedule, int c}) {
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

  Widget box() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.5),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                3.0, // Move to right 10  horizontally
                3.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  boxes("FG Description",
                      'OW4441 WIRE ASSY AC110KW BASE FEATURES'),
                  boxes("FG Scheduled", '29/03/2021'),
                  boxes("Customer", 'APC COOLING'),
                  boxes("Drg Rev", 'D'),
                  boxes("Cable #", '1'),
                  boxes('Tolerance ', '± 5 / ± 5'),
                ])),
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
  String type;
  Process({this.type});
  @override
  _ProcessState createState() => _ProcessState();
}

class _ProcessState extends State<Process> {
  bool expanded = true;
  @override
  Widget build(BuildContext context) {
    // Terminal A,Cutlength,Terminal B
    if (widget.type == "Terminal A,Cutlength,Terminal B") {
      return Column(
        children: [
          Row(
            children: [
              Container(
                height: 30,
                padding: const EdgeInsets.all(0.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            "Process Type : \nTerminal A,Cutlength,Terminal B",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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

  Widget table(String type, String pn, String r, String l, String a, String p) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.48,
        color: Colors.grey[200],
        child: Column(children: [
          row('Part No.', 'UOM', 'REQUIRED', 'LOADED', 'AVIALABE', 'PENDING'),
          row('884538504', 'uom', '5000m', '1000m', '1000m', '2500m'),
          row('884538504', 'uom', '5000m', '1000m', '1000m', '2500m'),
          row('884538504', 'uom', '5000m', '1000m', '1000m', '2500m'),
        ]));
  }

  Widget row(String partno, String uom, String require, String loaded,
      String available, String pending) {
    return Row(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[100])),
              height: 20,
              width: MediaQuery.of(context).size.width * 0.1,
              child:
                  Center(child: Text(partno, style: TextStyle(fontSize: 12)))),
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
    ]);
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
