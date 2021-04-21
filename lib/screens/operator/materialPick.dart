import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molex/model_api/postrawmatList_model.dart';
import 'package:molex/model_api/rawMaterial_modal.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/models/materialItem.dart';
import 'package:molex/screens/operator/process/process.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';

class MaterialPick extends StatefulWidget {
  final Schedule schedule;
  final String userId;
  final String machineId;
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
  List<PostRawMaterial> selectdItems = [];
  List<RawMaterial> rawMaterial = [];
  bool isCollapsedRawMaterial = false;
  bool isCollapsedScannedMaterial = false;
  DateTime selectedDate = DateTime.now();
  ApiService apiService;
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
    // if (!_qty.hasFocus && partNumber != null) {
    //   checkPartNumber(partNumber);
    //   checkTrackNumber(trackingNumber);
    // }
    if(!_qty.hasFocus){
         SystemChannels.textInput.invokeMethod('TextInput.hide');
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
            padding: EdgeInsets.all(5),
            width: 130,
            //shift
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
          //machineID
          Container(
            padding: EdgeInsets.all(1),
            height: 40,
           
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

          TimeDisplay(),
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
                    height: 40,
                    width: width * 0.25,
                    child: TextField(
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
                      onTap: (){
                        setState(() {
                            SystemChannels.textInput.invokeMethod('TextInput.hide');
                        });
                         
                      },
                      onChanged: (value) {
                        trackingNumber = value;
                      },
                      focusNode: _trackingNumber,
                      decoration: new InputDecoration(
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
                      setState(() {
                        
                      });
                     
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
                        PostRawMaterial postRawmaterial = new PostRawMaterial();
                        for (RawMaterial ip in rawMaterial) {
                          // print(rawMaterial.contains(ip).toString());
                          // print('loop ${ip.partNunber.toString()}');
                          if (ip.partNunber == partNumber) {
                            if (!selectdItems.contains(ip)) {
                              print('loop ${ip.partNunber.toString()}');
                              // postRawmaterial.date = selectedDate;
                              postRawmaterial.partDescription = ip.description;
                              print('qty $qty');
                              postRawmaterial.existingQuantity = int.parse(qty);
                              postRawmaterial.orderidentification =
                                  int.parse(widget.schedule.orderId);
                              postRawmaterial.totalScheduledQuantity =
                                  int.parse(widget.schedule.scheduledQuantity);
                              postRawmaterial.unitOfMeasurement = ip.uom;
                              postRawmaterial.cablePartNumber =
                                  partNumber != null
                                      ? int.parse(partNumber ?? '0')
                                      : null;
                              postRawmaterial.machineIdentification =
                                  "mac"; //TODO machine number
                              postRawmaterial.finishedGoodsNumber = int.parse(
                                  widget.schedule.finishedGoodsNumber);
                              postRawmaterial.schedulerIdentification =
                                  widget.schedule.scheduledId;
                              // ? int.parse(widget.schedule.scheduledId)
                              // : 0;
                              // "${selectedDate.toLocal()}".split(' ')[0];
                              postRawmaterial.color = widget.schedule.color;
                              postRawmaterial.process = widget.schedule.process;
                              postRawmaterial.status = "SUCCESS";
                              postRawmaterial.length =
                                  int.parse(widget.schedule.length);
                              postRawmaterial.traceabilityNumber =
                                  int.parse(trackingNumber);
                              print(postRawmaterial);
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
              _showConfirmationDialog();
            },
            child: Text(
              'Proceed to Process',
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
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  // to Show the raw material required
  Widget buildDataRawMaterial() {
    return FutureBuilder(
        future: apiService.rawMaterial(
            machineId: widget.machineId,
            fgNo: widget.schedule.finishedGoodsNumber,
            scheduleId: widget.schedule.scheduledId),
        // 'EMU-M/C-038B', '367760913', '367870011', '1223445'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RawMaterial> rawmaterial = snapshot.data;

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
                                  'REQ Qty/PC',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Total SCh Qty',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                            rows: rawmaterial
                                .map((e) => DataRow(cells: <DataCell>[
                                      DataCell(Text(
                                        e.partNunber.toString(),
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
                                        e.requireQuantity.toString(),
                                        style: TextStyle(fontSize: 12),
                                      )),
                                      DataCell(Text(
                                        e.toatalScheduleQuantity.toString(),
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
            return CircularProgressIndicator();
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
                      // DataColumn(
                      //   label: Text(
                      //     'UOM',
                      //     style: TextStyle(fontSize: 12),
                      //   ),
                      // ),
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
                                e.cablePartNumber.toString(),
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
                                // "${e.date.toLocal()}".split(' ')[0],
                                "",
                                style: TextStyle(fontSize: 12),
                              )),
                              // DataCell(Text(e.n.toString())),
                              DataCell(Text(e.existingQuantity .toString())),
                              DataCell(Text(e.schedulerIdentification.toString())),
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
            title: Center(child: Text('Confirm Selected Material')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(child: Text('Proceed to Process'))
                ],
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
                  child: Text('    Cancel   ')),
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
                        builder: (context) => ProcessPage(
                              schedule: widget.schedule,
                              userId: widget.userId,
                              machineId: widget.machineId,
                            )),
                  );
                } else {}
              });
                  },
                  child: Text('Proceed to Process')),
            ],
          ),
        );
      },
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
}
