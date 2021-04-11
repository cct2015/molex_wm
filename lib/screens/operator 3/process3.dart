import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:molex/models/Schudule.dart';
import 'package:molex/screens/operator%202/scanbundle.dart';
import 'package:molex/screens/operator/bin.dart';
import 'package:molex/screens/operator%203/scanid.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text('Material'),
        backwardsCompatibility: false,
        leading: Container(
          width: 0,
        ),
        actions: [
          Container(
            height: 40,
            width: 150,
            child: Column(
              children: [
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "User Id",
                      style: TextStyle(color: Colors.grey[100]),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.userId ?? "12210",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
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
      body: StreamBuilder(
          stream: Stream.periodic(const Duration(milliseconds: 2000)),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 7),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 250,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                ),
                                                child: Center(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4.0),
                                                      child: Icon(
                                                        Icons.schedule,
                                                        size: 18,
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Shift A",
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(100)),
                                              ),
                                              child: Center(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4.0),
                                                    child: Icon(
                                                      Icons.settings,
                                                      size: 18,
                                                      color: Colors.redAccent,
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.machineId ?? "",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 208,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          DateFormat('MM-dd-yyyy')
                                              .format(DateTime.now()),
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Text(
                                            DateFormat('hh:mm')
                                                .format(DateTime.now()),
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23,
                                            )),
                                      ],
                                    ),
                                    SizedBox(width: 10)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Detail(
                    schedule: widget.schedule,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class Detail extends StatefulWidget {
  Schedule schedule;
  Detail({this.schedule});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String _chosenValue;
  String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          tableHeading(),
          buildDataRow(schedule: widget.schedule),
          box(),
          terminal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              startProcess(),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white,
                      ),
                  onPressed: () {
                    setState(() {
                      value = _chosenValue;
                    });
                  },
                  child: Text('start Process')),
            ],
          ),
          Process(type: value),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 150,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    color: Colors.transparent,
                    child: ElevatedButton(
                       style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
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
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Bundle()),
                        );
                        }
                        ),
                  ),
                ),
                Container(
                  height: 50,
                  width:160,
                  child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white,
                      ),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return tab1();
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
                Container(
                  height: 50,
                  width: 190,
                  child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white,
                      ),
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return tab1();
                          });
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
                    Container(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
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
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => USerID()),
                        );
                      }),
                ),
                Container(
                  height: 50,
                  width: 160,
                  child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
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
          ),
        ],
      ),
    );
  }
  //Material Sheet for qty

  Widget tab1() {
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
    Widget cell(String name, double width) {
      return Container(
        width: width,
        height: 45,
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cell("Order Id", 120),
              cell("FG Part", 140),
              cell("Schedule ID", 140),
              cell("Cable Part No.", 140),
              cell("Process", 140),
              cell("Cut Length(mm)", 140),
              cell("Color", 70),
              cell("Scheduled Qty", 115),
              cell("Schedule", 115)
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDataRow({Schedule schedule, int c}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
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
            Container(
              width: 120,
              child: Center(
                child: Text(
                  schedule.orderId,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //Fg Part
            Container(
              width: 140,
              child: Center(
                child: Text(
                  schedule.fgpart,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //Schudule ID
            Container(
              width: 140,
              child: Center(
                child: Text(
                  schedule.scheudleId,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //Cable Part
            Container(
              width: 140,
              child: Center(
                child: Text(
                  schedule.cablePart ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //Process
            Container(
              width: 140,
              child: Center(
                child: Text(
                  schedule.process ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Cut length
            Container(
              width: 140,
              child: Center(
                child: Text(
                  schedule.cutLength ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //Color
            Container(
              width: 70,
              child: Center(
                child: Text(
                  schedule.color ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //Scheduled Qty
            Container(
              width: 115,
              child: Center(
                child: Text(
                  schedule.scheduledQty ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //Schudule
            Container(
              width: 115,
              child: Center(
                child: Text(
                  "11:00 - 12:00",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
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

  Widget box() {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 55,
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
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[200],
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            str1,
            style: TextStyle(fontSize: 12),
          ),
          Text(str2,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ]),
      ),
    );
  }

  Widget terminal() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 310,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            process(
                'Terminal A',
                'From Strip Length Spec(mm) - 40',
                'Process Type(Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Comments)(SC)(4.00-4.50)(367760073)(CIC APPL-1.16-1.23)(5.89)',
                'From Unsheathing Length (mm) - 40'),
            process(
                'Cable',
                'Cut Length Spec(mm) - 2060',
                'Cable Part Number(Description),884566210(3X20AWG SHIELD PVC GR 4.9MM UL2464)',
                ''),
            process(
                'Terminal B',
                'To Strip Length Spec(mm) - 60',
                'Process Type(Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Comments) (SC)(3.00-3.50)(367760073)(JAM APPL-0.86-0.96)(5.89)(ICH-2.72 REF)',
                'To Unsheathing Length (mm) - 60'),
          ],
        ),
      ),
    );
  }

  Widget process(String p1, String p2, String p3, String p4) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            padding: const EdgeInsets.all(15.0),
            height: 285,
            width: MediaQuery.of(context).size.width * 0.31,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[200],
            ),
            child: Center(
              child: Column(children: [
                Text(p1,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(p2,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 140.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/terminal_a.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    p3,
                    style:
                        TextStyle(fontSize: 11.50, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(p4, style: TextStyle(fontSize: 12)),
              ]),
            )));
  }

  Widget startProcess() {
    return Padding(
        padding: const EdgeInsets.all(60.0),
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
                  });
                },
              ),
            ],
          ),
        ));
  }
}

class Process extends StatefulWidget {
  String type;
  Process({this.type});
  @override
  _ProcessState createState() => _ProcessState();
}

class _ProcessState extends State<Process> {
  @override
  Widget build(BuildContext context) {
    // Terminal A,Cutlength,Terminal B
    if (widget.type == "Terminal A,Cutlength,Terminal B") {
      return Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Process Type : Terminal A,Cutlength,Terminal B",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
          // table for Process
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
          ]),
        ],
      );
    }
    // Terminal A

    if (widget.type == "Terminal A") {
      return Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Process Type : Terminal A",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
          ]),
        ],
      );
    }
    // Terminal B

    if (widget.type == "Terminal B") {
      return Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Process Type : Terminal B",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
          ]),
        ],
      );
    }
    if (widget.type == "Terminal A,Cutlength") {
      return Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Process Type : Terminal A,Cutlength",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
          ]),
        ],
      );
    }

    if (widget.type == "Cutlenght, Terminal B") {
      return Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Process Type : Cutlenght, Terminal B",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
          ]),
        ],
      );
    }
    if (widget.type == "Preparation") {
      return Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Process Type : Preparation",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
            table(
              'Terminal A,Cutlength,Terminal B',
              '884538504',
              '5000m',
              '2500m',
              '1000m',
              '2500m',
            ),
          ]),
        ],
      );
    } else {
      return Container(
        child: Center(
          child: Text('Select Process To Start'),
        ),
      );
    }
  }

  Widget table(String type, String pn, String r, String l, String a, String p) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.30,
        color: Colors.grey[200],
        child: Column(children: [
          Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.30 * 0.5,
                      child: Center(child: Text("PART NO."))),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.30 * 0.5,
                      child: Center(child: Text(pn))),
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
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.30 * 0.25,
                      child: Center(child: Text('REQUIRED'))),
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.0, color: Colors.grey[100])),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.30 * 0.25,
                      child: Center(child: Text('LOADED'))),
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.0, color: Colors.grey[100])),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.30 * 0.25,
                      child: Center(child: Text('AVAILABLE'))),
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.0, color: Colors.grey[100])),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.30 * 0.25,
                      child: Center(child: Text('PENDING'))),
                ],
              )
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          //color: Colors.red,
                          border: Border.all(width: 1.0, color: Colors.white)),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.30 * 0.25,
                      child: Center(child: Text(r))),
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.0, color: Colors.grey[100])),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.30 * 0.25,
                      child: Center(child: Text(l))),
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.0, color: Colors.grey[100])),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.30 * 0.25,
                      child: Center(child: Text(a))),
                  Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2.0, color: Colors.grey[100])),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.30 * 0.25,
                      child: Center(child: Text(p))),
                ],
              )
            ],
          )
        ]));
  }
 
}
