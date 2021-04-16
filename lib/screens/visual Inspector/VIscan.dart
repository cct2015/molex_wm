

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:molex/models/Schudule.dart';
import 'package:molex/models/bundle_print.dart';
import 'package:molex/models/vi_schedule.dart';
import 'package:molex/screens/operator/bin.dart';

class Viscan extends StatefulWidget {
  String userId;
  String machineId;
  Schedule schedule;

  Viscan({this.userId, this.schedule, this.machineId});
  @override
  _ViscanState createState() => _ViscanState();
}

class _ViscanState extends State<Viscan> {
  Schedule schedule;
  @override
  void initState() {
    schedule = widget.schedule;
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
      )
    );
  }
}

class Detail extends StatefulWidget {
  Schedule schedule;
  String rightside;
  String userId;
  String machineId;

  @override
  Detail({this.schedule, this.rightside, this.machineId, this.userId});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool orderDetailExpanded = true;
  String _chosenValue;
  bool scanTap = false;
  TextEditingController scanBundleController = new TextEditingController();
  FocusNode scanFocus = new FocusNode();
  TextEditingController userScanController = new TextEditingController();
  FocusNode userScanFocus = new FocusNode();
  @override
  Widget build(BuildContext context) {
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
                terminal(),
              ]);
            } else {
              return Container();
            }
          }()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              scanTap?Container():viscanbundle(),
              scanTap?vitable():Container(),
            ],
          ),
        ]));
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
        decoration: BoxDecoration(),
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

  Widget viscanbundle() {
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
                  hintText: "Scan Bundle",
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
                    onPressed: () {
                      setState(() {
                        scanTap=!scanTap;
                      });
                    },
                    child: Text('Scan Bundle'),
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  handleKey(RawKeyEventDataAndroid key) {
    String _keyCode;
    _keyCode = key.keyCode.toString(); //keyCode of key event(66 is return )
    print("why does this run twice $_keyCode");

    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  Widget vitable() {
    return Container(
      
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(20.0),
        color: Colors.grey[100],
      ),
      child: Column(
        children: [
       
             Container(
                height: 32,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Bundle ID',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'BUN13241551',
                        style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )),
          
          Text('Reason For Rejection',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              )),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      quantitycell("Crimp Insl", 10),
                      quantitycell("Insulation Slug", 10),
                      quantitycell("Window Gap", 10),
                      quantitycell("Exposed Strands", 10),
                     
                     
                    ],
                  ),
                  Column(
                    children: [
                       quantitycell("Burr / Cut Off", 10),
                      quantitycell("Terminal Bend / Closed / Damage", 10),
                       quantitycell("Insulation Curling / Half Curling", 10),
                      quantitycell("Nick Mark / Strands Cut", 10),
                     
                     
                    ],
                  ),
                   Column(
                    children: [
                       quantitycell("Seam Open", 10),
                      quantitycell("Miss Crimp", 10),
                      quantitycell("Front Bell Mouth", 10),
                      quantitycell("Back Bell Mouth", 10),
                      
                    ],
                  ),
                   Column(
                    children: [
                      quantitycell("Extrusion on Burr", 10),
                      quantitycell("Brush Length", 10),
                      quantitycell("Cable Damage", 10),
                      quantitycell("Terminal Twist", 10),
                      
                     
                     
                    ],
                  ),
                ],
              ),
          ),
           Padding(
                 padding: const EdgeInsets.all(4.0),
                 child:  Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                             quantity("Bundle Qty", 10),
                              quantity("Passed Qty", 10),
                              quantity("Rejected Qty", 10),
                             
                            ],),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(children: [
                     Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                          ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.blue[500];
                            return Colors
                                .blue[900]; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          scanTap = false;
                        });
                      },
                      child: Text('Next Bundle'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.green[500];
                            return Colors
                                .green[900]; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: Text('Save & Submit'),
                    ),
                     ElevatedButton(
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
                      onPressed: () {
                        Navigator.push(context,  MaterialPageRoute(builder: (context) => Bin(userId:'121200',machineId: '6541531'),),);
                      },
                      child: Text('Complete Inspection'),
                    ),
                       ]
                     ),
                    
                   ],),
                 )
               
          
        ],
      ),
    );
  }
   Widget quantity(String title, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.14,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.15 * 0.4,
              child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  )),
            ),
            Container(
              height: 25,
              width: 70,
              child: TextField(
                style: TextStyle(fontSize: 12),
                keyboardType: TextInputType.number,
               decoration: new InputDecoration(
                      labelText: "Qty",
                      fillColor: Colors.white,
                       labelStyle: TextStyle(fontSize: 10),
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

  Widget quantitycell(String title, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25 * 0.5,
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

class VIProcess extends StatefulWidget {
  @override
  _VIProcessState createState() => _VIProcessState();
}

class _VIProcessState extends State<VIProcess> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}