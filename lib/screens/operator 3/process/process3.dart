import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:molex/models/Schudule.dart';
import 'package:molex/models/bundle_scan.dart';
import 'package:molex/screens/operator%203/process/scanBundle.dart';
import 'package:molex/screens/operator/bin.dart';

class Processpage3 extends StatefulWidget {
  String userId;
  String machineId;
  Schedule schedule;
  Processpage3({this.machineId, this.userId, this.schedule});
  @override
  _Processpage3State createState() => _Processpage3State();
}

class _Processpage3State extends State<Processpage3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      SystemChrome.setEnabledSystemUIOverlays([]);

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
          'Process 3',
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
  bool scanTap = false;
  bool userTap = false;
  bool orderDetailExpanded = true;
  String rightside;
    String output = '';
  String _output = '';
  TextEditingController scanBundleController = new TextEditingController();
  FocusNode scanFocus = new FocusNode();
  TextEditingController userScanController = new TextEditingController();
  FocusNode userScanFocus = new FocusNode();
  List<BundleScan> bundleScan = [];
  List<String> userId = [];
  String mainb;
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Container(
        height: double.maxFinite,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      child: Column(
                        children: [
                          Process(type: _chosenValue),
                          Container(
                            height: MediaQuery.of(context).size.height*0.45,
                            width: MediaQuery.of(context).size.width * 0.76,
                           child:  mainbox(mainb)
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: MediaQuery.of(context).size.width * .20,
                                    padding: const EdgeInsets.all(0.0),
                                    child: Container(
                                      color: Colors.transparent,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.blue[900], // background
                                            onPrimary: Colors.white,
                                          ),
                                          child: Text(
                                            'Scan Bundle',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                             mainb="scanBundle";
                                              Future.delayed(
                                                const Duration(milliseconds: 50),
                                                () {
                                                  SystemChannels.textInput
                                                      .invokeMethod(
                                                          'TextInput.hide');
                                                },
                                              );
                                            });
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) => Bundle()),
                                            // );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                              // 100 % Button
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 200,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.green, // background
                                        onPrimary: Colors.white,
                                      ),
                                      onPressed: () {
                                       setState(() {
                                         mainb = "100";
                                       });
                                      },
                                      child: Text(
                                        "100% complete",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Partially complete
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 200,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red, // background
                                        onPrimary: Colors.white,
                                      ),
                                      onPressed: () {
                                        mainb="partial";
                                      },
                                      child: Text(
                                        "Partially  complete",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //Load user
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 200,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Colors.yellow[8000], // background
                                          onPrimary: Colors.white,
                                        ),
                                        child: Text(
                                          'Load User',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            mainb ="user";
                                          });
                                        }),
                                  ),
                                  (() {
                                    if (userTap) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(width: 10),
                                          Container(
                                            height: 50,
                                            width: 200,
                                            padding: const EdgeInsets.all(0.0),
                                            child: Container(
                                              color: Colors.transparent,
                                              child: RawKeyboardListener(
                                                focusNode: FocusNode(),
                                                onKey: (event) =>
                                                    handleKey(event.data),
                                                child: Container(
                                                    child: TextField(
                                                  controller: userScanController,
                                                  focusNode: userScanFocus,
                                                  autofocus: false,
                                                  onTap: () {
                                                    SystemChannels.textInput
                                                        .invokeMethod(
                                                            'TextInput.hide');
                                                  },
                                                  decoration: new InputDecoration(
                                                    labelText: "Scan Bundle",
                                                    fillColor: Colors.white,
                                                    border: new OutlineInputBorder(
                                                      borderRadius:
                                                          new BorderRadius.circular(
                                                              5.0),
                                                      borderSide: new BorderSide(),
                                                    ),
                                                    //fillColor: Colors.green
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Container(
                                            height: 50,
                                            width: 150,
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
                                              child: Container(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/image/scan.png"))),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      'Add',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  if (userScanController
                                                          .text.length >
                                                      0) {
                                                    userId.add(
                                                        userScanController.text);
                                                    userScanController.clear();
                                                  }
                                                });
                                              },
                                            ),
                                          )
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }())
                                ],
                              ),
                              //Reaload Material
                              Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 200,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue, // background
                                          onPrimary: Colors.white,
                                        ),
                                        child: Text(
                                          'Reload Material',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ],
                              ),
                            
                            ],
                          ),
                            Container(
                                      height: 165,
                                      child: Center(child: keypad()),
                                    ),
                           
                        ],
                      ),
                    )
                  ],
                ),
              ]);
            } else {
              return Container();
            }
          }()),
      
         
         
        ]));
  }
  Widget mainbox(String mainbr){
    if(mainbr=="scanBundle"){
      return ScanBundleP3();
    }
    if(mainbr=="100"){
      return rejectionCase();

    }
    if(mainbr=="partial"){
      return partialcompletepop();
    }
    if(mainb == "user"){
      return  loaduserpop();
    }
    else{
      return Container();
    }
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
        // _scanIdController.text = _output;
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

 

  Widget scanTable() {
    int i = 1;
    if (scanTap) {
      return DataTable(
          columnSpacing: 30,
          columns: const <DataColumn>[
            DataColumn(
              label: Text('S No.'),
            ),
            DataColumn(
              label: Text('Bundle Id'),
            ),
            DataColumn(
              label: Text('Bundle Qty'),
            ),
            DataColumn(
              label: Text('Process Qty'),
            ),
            DataColumn(
              label: Text('Remove'),
            ),
          ],
          rows: bundleScan
              .map((e) => DataRow(cells: <DataCell>[
                    DataCell(Text("${i++}")),
                    DataCell(Text(
                      e.bundleId,
                    )),
                    DataCell(Text(
                      e.bundleQty,
                    )),
                    DataCell(Text(
                      e.bundleProcessQty,
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          bundleScan.remove(e);
                        });
                      },
                    )),
                  ]))
              .toList());
    } else {
      return Container();
    }
  }

  Widget scanUser() {
    int a = 1;
    if (userTap) {
      return Column(
        children: [
          SizedBox(height: 50),
          DataTable(
              columnSpacing: 35,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('S No.'),
                ),
                DataColumn(
                  label: Text('User Id'),
                ),
                DataColumn(
                  label: Text('Remove'),
                ),
              ],
              rows: userId
                  .map((e) => DataRow(cells: <DataCell>[
                        DataCell(Text("${a++}")),
                        DataCell(Text(
                          e,
                        )),
                        DataCell(IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              userId.remove(e);
                            });
                          },
                        )),
                      ]))
                  .toList()),
        ],
      );
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

  Widget rejectionCase() {
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
                Text('WireCutting & Crimping Rejection Cases',
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
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              child: Center(
                child: Container(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // background
                        onPrimary: Colors.white,
                      ),
                      child: Text("Save & Complete Process"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Bin()),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tab2() {
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
                Text('WireCutting & Crimping Rejection Cases',
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
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell("Terminal Damage	", 10),
                          quantitycell("Terminal Bend	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Terminal Twist", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                          quantitycell("Conductor Curling Up & Down	", 10),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              child: Center(
                child: Container(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                      child: Text("Save & Generate Label"),
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      }),
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
        width: MediaQuery.of(context).size.width * 0.25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25 * 0.6,
              child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  )),
            ),
            Container(
              height: 30,
              width: 90,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "Qty",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
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

  Widget scheduleDetail() {
    Widget cell(String name, double width) {
      return Container(
        width: MediaQuery.of(context).size.width * width,
        height: 40,
        child: Center(
          child: Text(name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 90,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cell(
                "Order Id",
                0.1,
              ),
              cell(
                "FG Part",
                0.1,
              ),
              cell("Schedule ID", 0.08),
              cell("Cable Part No.", 0.08),
              cell("Process", 0.1),
              cell("Cut Length(mm)", 0.1),
              cell("Color", 0.1),
              cell("Scheduled Qty", 0.1),
              cell("Scheduled", 0.1),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cell("846478041", 120),
              cell("367810109", 140),
              cell("945810107", 140),
              cell("824923001", 140),
              cell("Wirecutting", 140),
              cell("2060", 140),
              cell("RED", 70),
              cell("500 Pcs", 115),
              cell("11:00-12:00AM", 160),
            ],
          ),
        ],
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


  Widget partialcompletepop() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(20.0),
          color: Colors.grey[100],
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Partial Completion Reason',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.4 * 0.9,
                child: TextField(
                  controller: scanBundleController,
                  focusNode: scanFocus,
                  autofocus: true,
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  decoration: new InputDecoration(
                    hintText: "Type the Reason",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(7.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
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
                      onPressed: () {},
                      child: Text('Accept and Continue Process'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.blue[900];
                            return Colors
                                .blue[900]; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Save & End Process'),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }

  Widget loaduserpop() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(20.0),
        color: Colors.grey[100],
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3 * 0.7,
              child: TextField(
                controller: scanBundleController,
                focusNode: scanFocus,
                autofocus: true,
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                decoration: new InputDecoration(
                  hintText: "Scan User ID",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(7.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.red[500];
                          return Colors
                              .red[900]; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Scan User ID'),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
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
