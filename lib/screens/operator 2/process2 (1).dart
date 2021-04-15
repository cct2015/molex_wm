import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:molex/models/Schudule.dart';
import 'package:molex/models/bundle_print.dart';
import 'package:molex/screens/operator/bin.dart';

class ProcessPage2 extends StatefulWidget {
  String userId;
  String machineId;
  Schedule schedule;
  String bundle;
  ProcessPage2({this.machineId, this.userId, this.schedule});
  @override
  _ProcessPage2State createState() => _ProcessPage2State();
}

class _ProcessPage2State extends State<ProcessPage2> {
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
  Schedule schedule;
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
  String rightside;
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
                    Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Row(
                          children: [
                            Column(
                              children: [
                                //text input
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.18,
                                        height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            controller: _qtyController,
                                            keyboardType: TextInputType.number,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextStyle(fontSize: 12),
                                            decoration: new InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              labelText: "Bundle Qty (SPQ)",
                                              fillColor: Colors.white,
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: new BorderSide(),
                                              ),
                                              //fillColor: Colors.green
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // bundle and generate label button
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            //Generate Label
                                            Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Container(
                                                color: Colors.transparent,
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .transparent))),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .pressed))
                                                            return Colors
                                                                .green[200];
                                                          return Colors.green[
                                                              500]; // Use the component's default.
                                                        },
                                                      ),
                                                    ),
                                                    // style: ButtonStyle(
                                                    //   elevation: ,
                                                    //   backgroundColor: MaterialStateProperty
                                                    //       .resolveWith<Color>(
                                                    //     (Set<MaterialState> states) {
                                                    //       if (states
                                                    //           .contains(MaterialState.pressed))
                                                    //         return Colors.green[200];
                                                    //       return Colors.green[
                                                    //           500]; // Use the component's default.
                                                    //     },
                                                    //   ),
                                                    // ),
                                                    child: Text(
                                                      'Generate Label',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        rightside = "label";
                                                      });
                                                      // showModalBottomSheet(
                                                      //     isScrollControlled:
                                                      //         true,
                                                      //     context: context,
                                                      //     builder: (BuildContext
                                                      //         context) {
                                                      //       return tab2();
                                                      //     });
                                                    }),
                                              ),
                                            ),
                                            SizedBox(width: 0),
                                            //bundel button
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Container(
                                                height: 40,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty
                                                          .all<
                                                              RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .transparent),
                                                        ),
                                                      ),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .pressed))
                                                            return Colors
                                                                .green[200];
                                                          return Colors.red[
                                                              500]; // Use the component's default.
                                                        },
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        rightside = "bundle";
                                                      });
                                                    },
                                                    child: Text(
                                                      bundlePrint.length
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 11),
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
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
                          height: 480,
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: SingleChildScrollView(
                            child: (() {
                              if (rightside == null) {
                                return Container();
                              } else if (rightside == "label") {
                                return rejectioncase();
                              } else if (rightside == "complete") {
                                return productionReport();
                              } else if (rightside == "partial") {
                                return partialCompletion();
                              } else if (rightside == "bundle") {
                                return bundleTable();
                              }
                            }()),
                          ),
                        ),
                      ],
                    ),
                    //buttons
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 450,
                          child: Column(
                            children: [
                              //keypad and button
                              Row(
                                children: [
                                  Container(
                                    height: 192,
                                    child: Center(child: keypad()),
                                  ),
                                ],
                              ),
                              //buttons column
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      //100% complete
                                      Container(
                                        height: 40,
                                        width: 250,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
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
                                            // showModalBottomSheet(
                                            //     isScrollControlled: true,
                                            //     context: context,
                                            //     builder: (BuildContext context) {
                                            //       return productionReport();
                                            //     });
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
                                      //Partially complete button
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 125,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
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
                                                // showModalBottomSheet(
                                                //     isScrollControlled: true,
                                                //     context: context,
                                                //     builder: (BuildContext context) {
                                                //       return partialCompletion();
                                                //     });
                                              },
                                              child: Text(
                                                "Partially  complete",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            width: 110,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                  shape: MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .transparent))),
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .resolveWith<Color>(
                                                    (Set<MaterialState>
                                                        states) {
                                                      if (states.contains(
                                                          MaterialState
                                                              .pressed))
                                                        return Colors
                                                            .green[200];
                                                      return Colors.blue[
                                                          500]; // Use the component's default.
                                                    },
                                                  ),
                                                ),
                                                child: Text(
                                                  'Reload Material',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.normal,
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
                        ),
                      ],
                    ),
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

  Widget rejectioncase() {
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
                Text('WireCutting & Crimping Rejection Cases',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
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
                          quantitycell("Nick mark", 10),
                          quantitycell("Blade mark", 10),
                          quantitycell("strip length", 10),
                          quantitycell(" length variation", 10),
                          quantitycell("end wire", 10),
                          quantitycell("cable damage", 10),
                          quantitycell("roller mark", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Damage / Bend", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Window Gap	", 10),
                          quantitycell("Crimp On Insulation", 10),
                          quantitycell("Bellmouth Less / More", 10),
                          quantitycell("Cut-off Burr	", 10),
                        ],
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            quantitycell(" Strands Cut", 10),
                            quantitycell("Brush Length Less / More", 10),
                            quantitycell(" Half Curling", 10),
                            quantitycell("End terminal", 10),
                            quantitycell("Setups Rejections", 10),
                            quantitycell("Exposure Strands", 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              child: Center(
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * 0.25,
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
                      child: Text("Save & Generate Label"),
                      onPressed: () {
                        setState(() {
                          _print();
                          bundlePrint.add(BundlePrint(
                              bundelId: "0123456789", bundleQty: "100"));
                          rightside = null;
                        });
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget terminal() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Container(
        height: 80,
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
        height: 80,
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

  Widget productionReport() {
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
                Text('Production Report',
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
                      child: Text("Save & Complete Process"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Bin(
                                    userId: widget.userId,
                                    machineId: widget.machineId,
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
                          quantitycell("Machine Taken for Removing CVM", 10),
                          quantitycell("No Material	", 10),
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
                          quantitycell("Cable Entangle", 10),
                          quantitycell("Job Ticket Issue", 10),
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
                          quantitycell("Machine Slow", 10),
                          quantitycell("No Plan for Machine", 10),
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
                          quantitycell("Machine Cleaning", 10),
                          quantitycell("No Operator", 10),
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
                              setState(() {
                                rightside = 'complete';
                              });
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
            color: schedule.status == "Completed"
                ? Colors.green
                : schedule.status == "Pending"
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
            cell(schedule.fgpart, 0.1),
            //Schudule ID
            cell(schedule.scheudleId, 0.1),

            //Cable Part
            cell(schedule.cablePart, 0.1),
            //Process
            cell(schedule.process, 0.1),
            // Cut length
            cell(schedule.cutLength, 0.1),
            //Color
            cell(schedule.color, 0.1),
            //Scheduled Qty
            cell(schedule.scheduledQty, 0.1),
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
          width: MediaQuery.of(context).size.width,
          height: 30,
          // color: Colors.grey[200],
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            boxes("FG Description", 'OW4441 WIRE ASSY AC110KW BASE FEATURES'),
            boxes("FG Scheduled Date", '29/03/2021'),
            boxes("Customer", 'APC COOLING'),
            boxes("Drg Rev", 'D'),
            boxes("Cable Serial No", '1'),
            boxes('Tolerance ', '± 5 / ± 5'),
          ])),
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
        color: Colors.grey[200],
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
                Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      "Process Type : \nTerminal B",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
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
                Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text(
                      "Process Type : \n Preparation",
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
    } else {
      return Container(
        child: Center(
          child: Text(widget.type ?? ""),
        ),
      );
    }
  }

  Widget terminal() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            process(
                'Terminal A',
                'From Strip Length Spec(mm) - 40',
                'Type (Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
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
                'Type(Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)',
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
        height: 80,
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

  Widget table(String type, String pn, String r, String l, String a, String p) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.57,
        color: Colors.grey[200],
        child: Column(children: [
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Center(
                          child: Text(
                        "PART NO.",
                        style: TextStyle(fontSize: 12),
                      ))),
                  Container(
                      height: 20,
                      color: Colors.grey[300],
                      width: MediaQuery.of(context).size.width * 0.07,
                      child: Center(
                          child: Text("UOM", style: TextStyle(fontSize: 12)))),
                  Container(
                      height: 20,
                      color: Colors.grey[300],
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: Center(
                          child: Text("REQUIRED",
                              style: TextStyle(fontSize: 12)))),
                  Container(
                      height: 20,
                      color: Colors.grey[300],
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: Center(
                          child:
                              Text("LOADED", style: TextStyle(fontSize: 12)))),
                  Container(
                      height: 20,
                      color: Colors.grey[300],
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: Center(
                          child: Text("AVAILABLE",
                              style: TextStyle(fontSize: 12)))),
                  Container(
                      height: 20,
                      color: Colors.grey[300],
                      width: MediaQuery.of(context).size.width * 0.10,
                      child: Center(
                          child:
                              Text("PENDING", style: TextStyle(fontSize: 12)))),
                ],
              )
            ],
          ),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.0, color: Colors.grey[100])),
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Center(
                          child: Text('884538504',
                              style: TextStyle(fontSize: 12)))),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.07,
                    child: Center(
                      child: Text(
                        'pcs',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Text(
                        '5000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Text(
                        '25000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Text(
                        '1000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Center(
                      child: Text(
                        '25000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.0, color: Colors.grey[100])),
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Center(
                          child: Text('884538504',
                              style: TextStyle(fontSize: 12)))),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.07,
                    child: Center(
                      child: Text(
                        'pcs',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Text(
                        '5000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Text(
                        '25000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Text(
                        '1000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Center(
                      child: Text(
                        '25000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 0.5, color: Colors.grey[100])),
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Center(
                          child: Text('884538504',
                              style: TextStyle(fontSize: 12)))),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.07,
                    child: Center(
                      child: Text(
                        'pcs',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Text(
                        '5000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Text(
                        '25000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: Center(
                      child: Text(
                        '1000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: Colors.grey[100])),
                    height: 20,
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Center(
                      child: Text(
                        '25000m',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ]));
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
