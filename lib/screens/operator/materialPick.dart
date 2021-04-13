import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:molex/models/Schudule.dart';
import 'package:molex/models/materialItem.dart';
import 'package:molex/screens/operator/process.dart';

class MaterialPick extends StatefulWidget {
  Schedule schedule;
  String userId;
  String machineId;
  MaterialPick({this.userId, this.machineId, this.schedule});
  @override
  _MaterialPickState createState() => _MaterialPickState();
}

class _MaterialPickState extends State<MaterialPick> {
  TextEditingController _partNumberController = new TextEditingController();
  TextEditingController _trackingNumberController = new TextEditingController();
  TextEditingController _qtyController = new TextEditingController();
  FocusNode _textNode = new FocusNode();
  FocusNode _trackingNumber = new FocusNode();
  FocusNode _qty = new FocusNode();
  String partNumber;
  String trackingNumber;
  String qty;
  List<ItemPart> items = [];
  List<ItemPart> selectditems = [];
  bool isCollapsedRawMaterial = false;
  bool isCollapsedScannedMaterial = false;
  @override
  void initState() {
    _textNode.requestFocus();
     SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    items.add(ItemPart(
      description: "1X20AWG DISC PVC OR 1.8MM UL 1569 HOOKUP",
      partNo: "884538504",
      uom: "M",
      oty: "2.5",
      schQty: "1.7",
    ));
    items.add(ItemPart(
      description: "1X20AWG DISC PVC OR 1.8MM UL 1569 HOOKUP",
      partNo: "884538505",
      uom: "M",
      oty: "2.5",
      schQty: "1.7",
    ));
    items.add(ItemPart(
      description: "1X20AWG DISC PVC OR 1.8MM UL 1569 HOOKUP",
      partNo: "884538506",
      uom: "M",
      oty: "2.5",
      schQty: "1.7",
    ));
    items.add(ItemPart(
      description: "1X20AWG DISC PVC OR 1.8MM UL 1569 HOOKUP",
      partNo: "884538507",
      uom: "M",
      oty: "2.5",
      schQty: "1.7",
    ));
    items.add(ItemPart(
      description: "1X20AWG DISC PVC OR 1.8MM UL 1569 HOOKUP",
      partNo: "884538508",
      uom: "M",
      oty: "2.5",
      schQty: "1.7",
    ));
    items.add(ItemPart(
      description: "1X20AWG DISC PVC OR 1.8MM UL 1569 HOOKUP",
      partNo: "884538509",
      uom: "M",
      oty: "2.5",
      schQty: "1.7",
    ));
    items.add(ItemPart(
      description: "1X20AWG DISC PVC OR 1.8MM UL 1569 HOOKUP",
      partNo: "884538510",
      uom: "M",
      oty: "2.5",
      schQty: "1.7",
    ));
    super.initState();
  }

  triggerCollapseRawMaterial() {
    setState(() {
      isCollapsedRawMaterial = !isCollapsedRawMaterial;
    });
  }

  triggerCollapseScannedMaterial() {
    setState(() {
      isCollapsedScannedMaterial = !isCollapsedScannedMaterial;
    });
  }

  onSelectedRow(bool selected, ItemPart document) async {
    setState(() {
      if (selected) {
        selectditems.add(document);
      } else {
        selectditems.remove(document);
      }
    });
  }

  void checkPartNumber(String pn) {
    setState(() {
      if (pn?.length == 9) {
        for (ItemPart ip in items) {
          if (ip.partNo == pn) {
            if (!selectditems.contains(ip)) {
              // selectditems.add(ip);
              // partNumber = null;
              // _textController.clear();
              _trackingNumber.requestFocus();
              Future.delayed(
                const Duration(milliseconds: 100),
                () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
              );
            }
          }
        }
      }
    });
  }

  void checkTrackNumber(String trackNumber) {
    setState(() {
      if (trackNumber?.length == 9) {
        trackingNumber = trackNumber;
        _qty.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    if (!_qty.hasFocus && partNumber != null) {
      checkPartNumber(partNumber);
      checkTrackNumber(trackingNumber);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: const Text(
          'Material',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0,
        actions: [
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
          Container(
            padding: EdgeInsets.all(2),
            height: 40,
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SizedBox(height: 5),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Text(
                //           "User Id",
                //           style: TextStyle(color: Colors.grey[100]),
                //         )
                //       ],
                //     ),
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         Text(
                //           widget.userId ?? "12210",
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold, fontSize: 12),
                //         )
                //       ],
                //     )
                //   ],
                // ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 25,
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 25,
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
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ],
                      )),
                    ),
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

      //  AppBar(
      //   backgroundColor: Colors.red[400],
      //   title: const Text('Material'),
      //   actions: [
      //     Container(
      //       height: 40,
      //       width: 150,
      //       child: Column(
      //         children: [
      //           SizedBox(height: 5),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Text(
      //                 "User Id",
      //                 style: TextStyle(color: Colors.grey[100]),
      //               )
      //             ],
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               Text(
      //                 widget.userId ?? "12210",
      //                 style:
      //                     TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      //               )
      //             ],
      //           )
      //         ],
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Container(
      //         height: 40,
      //         width: 40,
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.all(Radius.circular(100)),
      //             image: DecorationImage(
      //                 image: AssetImage(
      //                   'assets/image/profile.jpg',
      //                 ),
      //                 fit: BoxFit.fill)),
      //       ),
      //     )
      //   ],
      // ),

      body: StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 2000)),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                //Shift and machineId
              Divider(
                  color: Colors.redAccent,
                  thickness: 2,
                ),
                tableHeading(),
                buildDataRow(schedule: widget.schedule),
                //Raw material
                buildDataRawMaterial(),

                //Selected material
                showSelectedRawMaterial(),

                //Proceed to Process Button
                Container(
                  height: 50,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Container(
        height: 50,
        width: 200,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProcessPage(
                        schedule: widget.schedule,
                        userId: widget.userId,
                        machineId: widget.machineId,
                      )),
            );
          },
          child: Text('Proceed to Process'),
        ),
      ),
    );
  }

  Widget scannerInput() {
    final node = FocusScope.of(context);
    double width = MediaQuery.of(context).size.width * 0.8;
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Part Number
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => handleKey(event.data),
                child: Container(
                    height: 50,
                    width: width * 0.3,
                    child: TextField(
                      controller: _partNumberController,
                      autofocus: true,
                      focusNode: _textNode,
                      onChanged: (value) {
                        setState(() {
                          partNumber = value;
                        });
                      },
                      onTap: () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      },
                      decoration: new InputDecoration(
                        labelText: "Part No.",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    )),
              ),
              // Tracking Number
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => handleKey(event.data),
                child: Container(
                    height: 50,
                    width: width * 0.3,
                    child: TextField(
                      controller: _trackingNumberController,
                      onChanged: (value) {
                        trackingNumber = value;
                      },
                      focusNode: _trackingNumber,
                      decoration: new InputDecoration(
                        labelText: "Tracking Number",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    )),
              ),
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => {},
                child: Container(
                  height: 50,
                  width: width * 0.15,
                  child: TextField(
                    controller: _qtyController,
                    onTap: () {
                      SystemChannels.textInput.invokeMethod('TextInput.show');
                    },
                    focusNode: _qty,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      qty = value;
                    },
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
              ),
              Container(
                height: 50,
                width: width * 0.18,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.green[200];
                          return Colors
                              .green[500]; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        for (ItemPart ip in items) {
                          if (ip.partNo == partNumber) {
                            if (!selectditems.contains(ip)) {
                              selectditems.add(ip);
                              _partNumberController.clear();
                              _trackingNumberController.clear();
                              _qtyController.clear();
                              partNumber = null;
                              trackingNumber = null;
                              qty = null;
                              _textNode.requestFocus();
                              Future.delayed(
                                const Duration(milliseconds: 100),
                                () {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                },
                              );
                            }
                          }
                        }
                      });
                    },
                    child: Text('Add')),
              ),
            ],
          ),
        ),
      ],
    );
  }

  handleKey(RawKeyEventDataAndroid key) {
    String _keyCode;
    _keyCode = key.keyCode.toString(); //keyCode of key event(66 is return )
    print("why does this run twice $_keyCode");
    print(_partNumberController.text);

    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  // to Show the raw material required
  Widget buildDataRawMaterial() {
    return Container(
      child: Column(
        children: [
          // heading
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  triggerCollapseRawMaterial();
                },
                child: Text(
                  'Raw material Scan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      icon: isCollapsedRawMaterial
                          ? Icon(Icons.keyboard_arrow_down)
                          : Icon(Icons.keyboard_arrow_up),
                      onPressed: () {
                        triggerCollapseRawMaterial();
                      })
                ],
              )
            ],
          ),
          // scrollView
          (() {
            if (!isCollapsedRawMaterial) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: DataTable(
                    showCheckboxColumn: true,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Part No.'),
                      ),
                      DataColumn(
                        label: Text('Description'),
                      ),
                      DataColumn(
                        label: Text('UOM'),
                      ),
                      DataColumn(
                        label: Text('REQ Qty/PC'),
                      ),
                      DataColumn(
                        label: Text('Total SCh Qty'),
                      ),
                    ],
                    rows: items
                        .map((e) => DataRow(
                                selected: selectditems.contains(e),
                                onSelectChanged: (b) {
                                  // onSelectedRow(b, e);
                                },
                                cells: <DataCell>[
                                  DataCell(Text(
                                    e.partNo,
                                    style: TextStyle(fontSize: 16),
                                  )),
                                  DataCell(Text(
                                    e.description,
                                    style: TextStyle(fontSize: 15),
                                  )),
                                  DataCell(Text(e.uom)),
                                  DataCell(Text(e.oty)),
                                  DataCell(Text(e.schQty)),
                                ]))
                        .toList()),
              );
            } else {
              return Container();
            }
          }()),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  // To Show the scanned products with quantity
  Widget showSelectedRawMaterial() {
    return Container(
      child: Column(
        children: [
          //Heading
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  triggerCollapseScannedMaterial();
                },
                child: Text(
                  'Scanned Materials',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      icon: isCollapsedScannedMaterial
                          ? Icon(Icons.keyboard_arrow_down)
                          : Icon(Icons.keyboard_arrow_up),
                      onPressed: () {
                        triggerCollapseScannedMaterial();
                      })
                ],
              )
            ],
          ),
          scannerInput(),
          // Table
          (() {
            if (!isCollapsedScannedMaterial) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(8),
                child: DataTable(
                    columnSpacing: 40,
                    showCheckboxColumn: true,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Part No.'),
                      ),
                      DataColumn(
                        label: Text('Tracking No.'),
                      ),
                      DataColumn(
                        label: Text('Description'),
                      ),
                      DataColumn(
                        label: Text('UOM'),
                      ),
                      DataColumn(
                        label: Text('REQ Qty/PC'),
                      ),
                      DataColumn(
                        label: Text('Total SCh Qty'),
                      ),
                      DataColumn(
                        label: Text('Qty'),
                      ),
                      DataColumn(
                        label: Text('Delete'),
                      ),
                    ],
                    rows: selectditems
                        .map((e) => DataRow(cells: <DataCell>[
                              DataCell(Text(
                                e.partNo,
                                style: TextStyle(fontSize: 16),
                              )),
                              DataCell(Text(
                                e.partNo,
                                style: TextStyle(fontSize: 16),
                              )),
                              DataCell(Text(
                                e.description,
                                style: TextStyle(fontSize: 15),
                              )),
                              DataCell(Text(e.uom)),
                              DataCell(Text(e.oty)),
                              DataCell(Text(e.schQty)),
                              DataCell(Text("30")),
                              DataCell(IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  selectditems.remove(e);
                                },
                              )),
                            ]))
                        .toList()),
              );
            } else {
              return Container();
            }
          }())
        ],
      ),
    );
  }

  Widget tableHeading() {
    Widget cell(String name, double width) {
      return Container(
        width: width,
        height: 25,
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
      height: 25,
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
      height: 25,
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
                    fontSize: 12
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
                    fontSize: 12
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
                     fontSize: 12
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
                     fontSize: 12
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
                     fontSize: 12
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
                     fontSize: 12
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
                     fontSize: 14
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
                     fontSize: 14
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
}
