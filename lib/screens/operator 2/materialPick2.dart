import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:molex/model_api/crimping/getCrimpingSchedule.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/model_api/postrawmatList_model.dart';
import 'package:molex/model_api/rawMaterial_modal.dart';
import 'package:molex/models/materialItem.dart';
import 'package:molex/screens/operator%202/process/process2.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';

class MaterialPickOp2 extends StatefulWidget {
  final CrimpingSchedule schedule;
  final String userId;
  final MachineDetails machine;
  MaterialPickOp2({this.userId, this.machine, this.schedule});
  @override
  _MaterialPickOp2State createState() => _MaterialPickOp2State();
}

class _MaterialPickOp2State extends State<MaterialPickOp2> {
  TextEditingController _partNumberController = new TextEditingController();
  TextEditingController _trackingNumberController = new TextEditingController();
  TextEditingController _qtyController = new TextEditingController();
  FocusNode _textNode = new FocusNode();
  FocusNode _trackingNumber = new FocusNode();
  FocusNode _qty = new FocusNode();
  String partNumber;
  String trackingNumber;
  String qty;
  List<ItemPart> selectditems = [];
  bool isCollapsedRawMaterial = false;
  bool isCollapsedScannedMaterial = false;
  DateTime selectedDate = DateTime.now();
  ApiService apiService;
  List<RawMaterial> rawMaterial = [];
  bool keyBoard = false;
  List<RawMaterial> rawmaterial1;
  List<PostRawMaterial> selectdItems = [];
  @override
  void initState() {
    apiService = new ApiService();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _textNode.requestFocus();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );

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
      if (pn?.length == 9) {}
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
    print("key $keyBoard");
    if (!keyBoard) {
      if (!_qty.hasFocus) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: Text(
          'Raw Material Loading',
          style: GoogleFonts.openSans(textStyle: TextStyle(color: Colors.red)),
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
            Divider(
              color: Colors.red[100],
              thickness: 2,
            ),

            //Selected material
            showSelectedRawMaterial(),

            //Proceed to Process Button
            Container(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget scannerInput() {
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
                    height: 40,
                    width: width * 0.25,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      controller: _partNumberController,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      focusNode: _textNode,
                      onSubmitted: (value) {
                        for (RawMaterial ip in rawMaterial) {
                          if (ip.partNunber.toString() == value) {
                            if (!rawMaterial.contains(ip)) {
                              _trackingNumber.requestFocus();
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
                      },
                      onChanged: (value) {
                        setState(() {
                          partNumber = value;
                        });
                      },
                      onTap: () {
                        setState(() {
                          keyBoard
                              ? SystemChannels.textInput
                                  .invokeMethod('TextInput.show')
                              : SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                        });
                      },
                      decoration: new InputDecoration(
                        suffix: _partNumberController.text.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _partNumberController.clear();
                                  });
                                },
                                child: Icon(Icons.clear,
                                    size: 18, color: Colors.red))
                            : Container(),
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
                    height: 40,
                    width: width * 0.25,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: _trackingNumberController,
                      onSubmitted: (value) async {
                        trackingNumber = value;
                        final DateTime picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate, // Refer step 1
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        );
                        if (picked != null && picked != selectedDate)
                          setState(() {
                            selectedDate = picked;
                            Future.delayed(
                              const Duration(milliseconds: 100),
                              () {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              },
                            );
                          });
                        _qty.requestFocus();
                      },
                      onTap: () {
                        setState(() {
                          keyBoard
                              ? SystemChannels.textInput
                                  .invokeMethod('TextInput.show')
                              : SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                        });
                      },
                      onChanged: (value) {
                        trackingNumber = value;
                      },
                      focusNode: _trackingNumber,
                      decoration: new InputDecoration(
                        suffix: _trackingNumberController.text.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _trackingNumberController.clear();
                                  });
                                },
                                child: Icon(Icons.clear,
                                    size: 18, color: Colors.red))
                            : Container(),
                        labelText: "Tracebility Number",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    )),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      keyBoard = !keyBoard;
                    });
                  },
                  child: Icon(Icons.keyboard,
                      color: keyBoard ? Colors.green : Colors.grey)),
              GestureDetector(
                onTap: () async {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate, // Refer step 1
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      selectedDate = picked;
                      Future.delayed(
                        const Duration(milliseconds: 100),
                        () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                      );
                    });
                },
                child: Container(
                  height: 50,
                  child: Row(
                    children: [
                      Icon(
                        Icons.event,
                        color: Colors.grey,
                        size: 25,
                      ),
                      Text(
                        "${selectedDate.toLocal()}".split(' ')[0],
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => {},
                child: Container(
                  height: 40,
                  width: width * 0.15,
                  child: TextField(
                    controller: _qtyController,
                    onTap: () {
                      setState(() {});
                    },
                    focusNode: _qty,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        qty = value;
                      });
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
                height: 40,
                width: width * 0.12,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.green[200];
                          return Colors.blue; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      print('rawmaterial = $rawMaterial');
                      setState(() {
                        for (RawMaterial ip in rawMaterial) {
                          if (ip.partNunber == partNumber) {
                            if (!selectdItems.contains(ip)) {
                              print('loop ${ip.partNunber.toString()}');
                              PostRawMaterial postRawmaterial =
                                  new PostRawMaterial(
                                      partDescription: ip.description,
                                      existingQuantity: 0,
                                      schedulerIdentification:
                                          "${widget.schedule.scheduleId}",
                                      date: DateFormat.yMd('en')
                                          .format(selectedDate), //TODO
                                      machineIdentification:
                                          widget.machine.machineNumber,
                                      finishedGoodsNumber:
                                          widget.schedule.finishedGoods,
                                      // purchaseOrder:
                                      //     "${widget.schedule.purchaseOrder}",
                                      partNumber: int.parse(ip.partNunber),
                                      requiredQuantityOrPiece:
                                          double.parse(ip.requireQuantity),
                                      totalScheduledQuantity:
                                          int.parse(ip.toatalScheduleQuantity),
                                      unitOfMeasurement: ip.uom,
                                      traceabilityNumber:
                                          int.parse(trackingNumber),
                                      scannedQuantity: int.parse(qty),
                                      cablePartNumber:
                                          widget.schedule.cablePartNo,
                                      length: widget.schedule.length,
                                      color: "${widget.schedule.wireColour}",
                                      process: widget.schedule.process,
                                      status: 'SUCCESS');

                              selectdItems.add(postRawmaterial);
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
        Container(
          height: 40,
          width: width * 0.22,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              primary: Colors.green, // background
              onPrimary: Colors.white,
            ),
            onPressed: () {
              List<int> rawPartNo = rawmaterial1.map((e) {
                return int.tryParse(e.partNunber);
              }).toList();
              print(rawPartNo.toSet());
              List<int> scannedPartNo = selectdItems.map((e) {
                return e.partNumber;
              }).toList();
              print(scannedPartNo.toSet());
              if (true) {
                _showConfirmationDialog();
              } else {
                Fluttertoast.showToast(
                    msg: "Add All Raw Material To Start Process",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            child: Text(
              'Start Process',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  handleKey(RawKeyEventDataAndroid key) {
    setState(() {
      keyBoard
          ? SystemChannels.textInput.invokeMethod('TextInput.show')
          : SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  // to Show the raw material required
  Widget buildDataRawMaterial() {
    return FutureBuilder(
        future: apiService.rawMaterial(
            machineId: widget.machine.machineNumber,
            fgNo: "${widget.schedule.finishedGoods}",
            scheduleId: "${widget.schedule.scheduleId}"),
        // 'EMU-M/C-038B', '367760913', '367870011', '1223445'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RawMaterial> rawmaterial = snapshot.data;
            rawmaterial1 = snapshot.data;

            rawMaterial = snapshot.data;

            return Container(
              child: Column(
                children: [
                  // heading
                  SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          triggerCollapseRawMaterial();
                        },
                        child: Text(
                          'Required Raw Material',
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
                        padding: EdgeInsets.all(2),
                        child: DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Part No.',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Description',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'UOM',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Req. Per Unit',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Req Schedule Unit',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                            rows: rawmaterial
                                .map((e) => DataRow(cells: <DataCell>[
                                      DataCell(Text(
                                        e.partNunber,
                                        style: TextStyle(fontSize: 12),
                                      )),
                                      DataCell(Text(
                                        e.description,
                                        style: TextStyle(fontSize: 12),
                                      )),
                                      DataCell(Text(
                                        e.uom,
                                        style: TextStyle(fontSize: 12),
                                      )),
                                      DataCell(Text(
                                        e.requireQuantity,
                                        style: TextStyle(fontSize: 12),
                                      )),
                                      DataCell(Text(
                                        e.toatalScheduleQuantity,
                                        style: TextStyle(fontSize: 12),
                                      )),
                                    ]))
                                .toList()),
                      );
                    } else {
                      return Container();
                    }
                  }()),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  // To Show the scanned products with quantity
  Widget showSelectedRawMaterial() {
    return Container(
      child: Column(
        children: [
          scannerInput(),
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
                  GestureDetector(
                      onTap: () {
                        triggerCollapseScannedMaterial();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(isCollapsedScannedMaterial
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_up),
                      ))
                ],
              )
            ],
          ),

          // Table
          (() {
            if (!isCollapsedScannedMaterial) {
              return Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(4),
                child: DataTable(
                    columnSpacing: 20,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'PART NO.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'DESCRIPTION',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'TRACEBILITY',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'DATE',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'EXIST QTY	',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'SCANNED QTY',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Delete',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                    rows: selectdItems
                        .map((e) => DataRow(cells: <DataCell>[
                              DataCell(Text(
                                e.partNumber.toString(),
                                style: TextStyle(fontSize: 12),
                              )),
                              DataCell(Text(
                                e.partDescription,
                                style: TextStyle(fontSize: 12),
                              )),
                              DataCell(Text(
                                e.traceabilityNumber.toString(),
                                style: TextStyle(fontSize: 12),
                              )),
                              DataCell(Text(
                                "${e.date}".split(' ')[0],
                                style: TextStyle(fontSize: 12),
                              )),
                              DataCell(Text(e.existingQuantity.toString())),
                              DataCell(Text(e.scannedQuantity.toString())),
                              DataCell(IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectdItems.remove(e);
                                  });
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

  Widget buildDataRow({CrimpingSchedule schedule, int c}) {
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
            // border: Border(
            //     left: BorderSide(
            //   color: schedule.scheduledStatus == "Completed"
            //       ? Colors.green
            //       : schedule.scheduledStatus == "Pending"
            //           ? Colors.red
            //           : Colors.green[100],
            //   width: 5,
            // )),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // orderId
            cell(schedule.purchaseOrder.toString(), 0.1),
            //Fg Part
            cell(schedule.finishedGoods.toString(), 0.1),
            //Schudule ID
            cell(schedule.scheduleId.toString(), 0.1),

            //Cable Part
            cell(schedule.cablePartNo.toString(), 0.1),
            //Process
            cell(schedule.process, 0.1),
            // Cut length
            cell(schedule.length.toString(), 0.1),
            //Color
            cell(schedule.wireColour, 0.1),
            //Scheduled Qty
            cell(schedule.bundleQuantityTotal.toString(), 0.1),
            //Schudule
            Container(
              width: width * 0.1,
              child: Center(
                child: Text(
                  "null",
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
        return Center(
          child: AlertDialog(
            title: Center(child: Text('Proceed to Process')),
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
                  child: Text('       Cancel      ')),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.green),
                  ),
                  onPressed: () {
                    apiService.postRawmaterial(selectdItems).then((value) {
                      if (value) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProcessPage2(
                                    schedule: widget.schedule,
                                    userId: widget.userId,
                                    machine: widget.machine,
                                  )),
                        );
                      } else {}
                    });
                  },
                  child: Text('       Confirm      ')),
            ],
          ),
        );
      },
    );
  }
}
