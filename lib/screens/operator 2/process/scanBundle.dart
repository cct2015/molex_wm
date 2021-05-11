import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/model_api/crimping/getCrimpingSchedule.dart';
import 'package:molex/model_api/crimping/postCrimprejectedDetail.dart';
import 'package:molex/models/bundle_scan.dart';
import 'package:molex/screens/operator/bin.dart';
import 'package:molex/service/apiService.dart';

enum Status {
  scan,
  rejection,
  showbundle,
  scanBin,
}

class ScanBundle extends StatefulWidget {
  int length;
  String userId;
  String machineId;
  @required CrimpingSchedule schedule;
  ScanBundle({this.length, this.machineId, this.userId,this.schedule});
  @override
  _ScanBundleState createState() => _ScanBundleState();
}

class _ScanBundleState extends State<ScanBundle> {
  TextEditingController mainController = new TextEditingController();
  TextEditingController terminalDamageController = new TextEditingController();
  TextEditingController windowGapController = new TextEditingController();
  TextEditingController cutoffBurrController = new TextEditingController();
  TextEditingController terminalCopperMarkController =
      new TextEditingController();
  TextEditingController terminalBendController = new TextEditingController();
  TextEditingController crimpOnInsulationController =
      new TextEditingController();
  TextEditingController cutoffBendController = new TextEditingController();
  TextEditingController setupRejectionsController = new TextEditingController();
  TextEditingController terminalTwistController = new TextEditingController();
  TextEditingController improperCrimpingController =
      new TextEditingController();
  TextEditingController insulationDamageController =
      new TextEditingController();
  TextEditingController terminalBackOutController = new TextEditingController();
  TextEditingController conductorCurlingUpDownController =
      new TextEditingController();
  TextEditingController tabBendTapOpenController = new TextEditingController();
  TextEditingController exposureStrandsController = new TextEditingController();
  TextEditingController insulationCurlingUpDownController =
      new TextEditingController();
  TextEditingController bellmouthLessMoreController =
      new TextEditingController();
  TextEditingController strandsCutController = new TextEditingController();
  TextEditingController conductorBurrController = new TextEditingController();
  TextEditingController cutOffLessMoreController = new TextEditingController();
  TextEditingController brushLengthLessMoreController =
      new TextEditingController();
  TextEditingController rejectedQtyController = new TextEditingController();
  TextEditingController bundlQtyController = new TextEditingController();
  TextEditingController seamopenController = new TextEditingController();
  TextEditingController missCrimpController = new TextEditingController();
  TextEditingController frontBellMouthController = new TextEditingController();
  TextEditingController backbellmouthController = new TextEditingController();
  TextEditingController cabledamageController = new TextEditingController();
  TextEditingController extrutionOnBurrController = new TextEditingController();
  TextEditingController brushLengthController = new TextEditingController();
   TextEditingController burrOrCutOffController = new TextEditingController();
  FocusNode _scanfocus = new FocusNode();
  TextEditingController _scanIdController = new TextEditingController();
  bool next = false;
  bool showTable = false;
  List<BundleScan> bundleScan = [];
  Status status = Status.scan;

  String _output = '';

  TextEditingController _binController = new TextEditingController();

  bool hasBin;

  String binId;
  //to store the bundle Quantity fetched from api after scanning bundle Id
  String bundleQty='';
  ApiService apiService = new ApiService();
  @override
  void initState() {
    apiService = new ApiService();
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Row(
      children: [
        main(status),
        keypad(mainController),
      ],
    );
  }

  Widget main(Status status) {
    switch (status) {
      case Status.scan:
        return scanBundlePop();
        break;
      case Status.rejection:
        return rejectioncase();
        break;
      case Status.scanBin:
        return binScan();
        break;
      default:
        return Container();
    }
  }

  Widget keypad(TextEditingController controller) {
    // print('NickMark ${windowGapController.text}');
    // print('End wire ${endWireController.text}');
    buttonPressed(String buttonText) {
      if (buttonText == 'X') {
        _output = '';
      } else {
        _output = _output + buttonText;
      }

      print(_output);
      setState(() {
        controller.text = _output;
        // output = int.parse(_output).toStringAsFixed(2);
      });
    }

    Widget buildbutton(String buttonText) {
      return new Expanded(
          child: Container(
        decoration: new BoxDecoration(),
        width: 27,
        height: 50,
        child: new ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.grey[50]))),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.grey[100];

                return Colors.white; // Use the component's default.
              },
            ),
          ),
          child: buttonText == 'X'
              ? Container(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    icon: Icon(
                      Icons.backspace,
                      color: Colors.red[400],
                    ),
                    onPressed: () => {buttonPressed(buttonText)},
                  ))
              : new Text(
                  buttonText,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: buttonText == "X" ? Colors.red : Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
          onPressed: () => {buttonPressed(buttonText)},
        ),
      ));
    }

    return Material(
      elevation: 2,
      shadowColor: Colors.grey[200],
      child: Container(
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.red.withOpacity(0.1),
          //     spreadRadius: 2,
          //     blurRadius: 2,
          //     offset: Offset(0, 0), // changes position of shadow
          //   ),
          // ],
        ),
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
                buildbutton('X'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget scanedTable() {
    if (showTable) {
      return Container(
        height: 250,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DataTable(
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
                            DataCell(Text("1")),
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
                      .toList()),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget scanBundlePop() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 100,
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: 200,
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => handleKey(event.data),
                      child: TextField(
                        onTap: () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                        controller: _scanIdController,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontSize: 14),
                        decoration: new InputDecoration(
                            suffix: _scanIdController.text.length > 1
                            ? Padding(
                              padding: const EdgeInsets.only(top:7.0),
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _scanIdController.clear();
                                    });
                                  },
                                  child: Icon(Icons.clear,
                                      size: 18, color: Colors.red)),
                            )
                            : Container(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 3),
                          labelText: "Scan Bundle",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.redAccent),
                          ),
                          onPressed: () {
                            if (_scanIdController.text.length > 0) {
                              apiService
                                  .scaBundleGetQty(
                                      bundleID: _scanIdController.text)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    clear();
                                    bundleQty = value;
                                    bundlQtyController.text = value;
                                    next = !next;
                                    status = Status.rejection;
                                  });
                                } else {
                                    Fluttertoast.showToast(
                                  msg: "Bundle Not Found",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                                }
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Scan Bundle to proceed",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          },
                          child: Text('Scan Bundle  ')),
                      SizedBox(width: 5),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.green),
                          ),
                          onPressed: () {
                            setState(() {
                              showTable = !showTable;
                            });
                          },
                          child: Text("${bundleScan.length}")),
                    ],
                  ),
                ],
              )),
          scanedTable(),
        ],
      ),
    );
  }

  handleKey(RawKeyEventDataAndroid key) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Widget rejectioncase() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Crimping Rejection Cases',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          quantitycell(
                            name: "Terminal Damage	",
                            quantity: 10,
                            textEditingController: terminalDamageController,
                          ),
                          quantitycell(
                            name: "Window Gap	",
                            quantity: 10,
                            textEditingController: windowGapController,
                          ),
                          quantitycell(
                            name: "Cut-off Burr	",
                            quantity: 10,
                            textEditingController: cutoffBurrController,
                          ),
                          quantitycell(
                            name: "Terminal Copper Mark	",
                            quantity: 10,
                            textEditingController: terminalCopperMarkController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Terminal Bend",
                            quantity: 10,
                            textEditingController: terminalBendController,
                          ),
                          quantitycell(
                            name: "Crimp On Insulation	",
                            quantity: 10,
                            textEditingController: crimpOnInsulationController,
                          ),
                          quantitycell(
                            name: "Cut-off Bend	",
                            quantity: 10,
                            textEditingController: cutoffBendController,
                          ),
                          quantitycell(
                            name: "Setup Rejections	",
                            quantity: 10,
                            textEditingController: setupRejectionsController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Terminal Twist	",
                            quantity: 10,
                            textEditingController: terminalTwistController,
                          ),
                          quantitycell(
                            name: "Improper Crimping	",
                            quantity: 10,
                            textEditingController: improperCrimpingController,
                          ),
                          quantitycell(
                            name: "Insulation Damage	",
                            quantity: 10,
                            textEditingController: insulationDamageController,
                          ),
                          quantitycell(
                            name: "Terminal Back Out	",
                            quantity: 10,
                            textEditingController: terminalBackOutController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Conductor Curling Up & Down	",
                            quantity: 10,
                            textEditingController:
                                conductorCurlingUpDownController,
                          ),
                          quantitycell(
                            name: "Tab Bend / Tap Open	",
                            quantity: 10,
                            textEditingController: tabBendTapOpenController,
                          ),
                          quantitycell(
                            name: "Exposure Strands",
                            quantity: 10,
                            textEditingController: exposureStrandsController,
                          ),
                          quantitycell(
                            name: "Insulation Curling Up & Down",
                            quantity: 10,
                            textEditingController:
                                insulationCurlingUpDownController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Bellmouth Less / More",
                            quantity: 10,
                            textEditingController: bellmouthLessMoreController,
                          ),
                          quantitycell(
                            name: "Strands Cut	",
                            quantity: 10,
                            textEditingController: strandsCutController,
                          ),
                          quantitycell(
                            name: "Conductor Burr	",
                            quantity: 10,
                            textEditingController: conductorBurrController,
                          ),
                          quantitycell(
                            name: "Cut-Off Less / More	",
                            quantity: 10,
                            textEditingController: cutoffBurrController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Brush Length Less / More	",
                            quantity: 10,
                            textEditingController:
                                brushLengthLessMoreController,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  quantitycell(
                    name: "Bundle Qty",
                    quantity: 10,
                    textEditingController: bundlQtyController,
                  ),
                  quantitycell(
                    name: "Rejected Qty",
                    quantity: 10,
                    textEditingController: rejectedQtyController,
                  ),
                  SizedBox(width: 20),
                  Container(
                    height: 50,
                    child: Center(
                      child: Container(
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
                            child: Text("Save & Scan Next"),
                            onPressed: () {
                              PostCrimpingRejectedDetail postCrimpingRejectedDetail = PostCrimpingRejectedDetail(
                                bundleIdentification: _scanIdController.text,
                                bundleQuantity: int.parse(bundleQty),
                                passedQuantity: 0,
                                rejectedQuantity: total(),
                                crimpInslation: int.parse(crimpOnInsulationController.text.length>0?crimpOnInsulationController.text:"0"),
                                insulationSlug: int.parse(insulationCurlingUpDownController.text.length>0?insulationCurlingUpDownController.text:'0'),//TODO check if both are same
                                windowGap: int.parse(windowGapController.text.length>0?windowGapController.text:'0'),
                                exposedStrands: int.parse(exposureStrandsController.text.length>0?exposureStrandsController.text:'0'),
                                burrOrCutOff: int.parse(cutoffBurrController.text.length>0?cutoffBurrController.text:'0'),
                                terminalBendOrClosedOrDamage: int.parse(terminalBendController.text.length>0?terminalBendController.text:'0'),
                                nickMarkOrStrandsCut: int.parse("0" ),//TODO check nick mark in Qty
                                brushLength: int.parse(brushLengthLessMoreController.text.length>0?brushLengthLessMoreController.text:'0'),
                                seamOpen: int.parse(seamopenController.text.length>0?seamopenController.text:'0'),
                                missCrimp: int.parse(missCrimpController.text.length>0?missCrimpController.text:'0'),
                                frontBellMouth: int.parse(frontBellMouthController.text.length>0?frontBellMouthController.text:'0'),
                                backBellMouth: int.parse(backbellmouthController.text.length>0?backbellmouthController.text:'0'),
                                extrusionOnBurr: int.parse(extrutionOnBurrController.text.length>0?extrutionOnBurrController.text:'0'),
                                cableDamage: int.parse(cabledamageController.text.length>0?cabledamageController.text:'0'),
                                terminalTwist: int.parse(terminalTwistController.text.length>0?terminalTwistController.text:'0'),
                                orderId: widget.schedule.purchaseOrder,
                                fgPart: widget.schedule.finishedGoods,
                                scheduleId: widget.schedule.scheduleId,



                                );
                              setState(() {
                                bundleScan.add(BundleScan(
                                    bundleId: _scanIdController.text,
                                    bundleProcessQty: "30",
                                    bundleQty: "$bundleQty"));
                                _scanIdController.clear();
                                Future.delayed(const Duration(milliseconds: 10),
                                    () {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                });
                                status = Status.scanBin;
                              });
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  int total(){
    int total = int.parse(crimpOnInsulationController.text.length>0?crimpOnInsulationController.text:'0')+
    int.parse(insulationCurlingUpDownController.text.length>0?insulationCurlingUpDownController.text:'0')+
    int.parse(windowGapController.text.length>0?windowGapController.text:'0')+
    int.parse(exposureStrandsController.text.length>0?exposureStrandsController.text:'0')+
    int.parse(burrOrCutOffController.text.length>0?burrOrCutOffController.text:'0')+
    int.parse(terminalBendController.text.length>0?terminalBendController.text:'0')+
    int.parse(seamopenController.text.length>0?seamopenController.text:'0')+
    int.parse(missCrimpController.text.length>0?missCrimpController.text:'0')+
    int.parse(frontBellMouthController.text.length>0?frontBellMouthController.text:'0')+
    int.parse(backbellmouthController.text.length>0?backbellmouthController.text:'0')+
    int.parse(extrutionOnBurrController.text.length>0?extrutionOnBurrController.text:'0')+
    int.parse(brushLengthController.text.length>0?brushLengthController.text:'0')+
    int.parse(cabledamageController.text.length>0?cabledamageController.text:'0')+
    int.parse(terminalTwistController.text.length>0?terminalTwistController.text:'0');
    //TODO nickMark
    return total;
  }

  Widget quantitycell(
      {String name,
      int quantity,
      TextEditingController textEditingController,
      FocusNode focusNode}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 33,
                width: 140,
                child: TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onTap: () {
                    setState(() {
                      _output = '';
                      mainController = textEditingController;
                    });
                  },
                  style: TextStyle(fontSize: 12),
                  decoration: new InputDecoration(
                    labelText: name,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                ))
          ],
        ),
      ),
    );
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

  void clear() {
    terminalDamageController.clear();
    terminalBendController.clear();
    terminalTwistController.clear();
    conductorCurlingUpDownController.clear();
    bellmouthLessMoreController.clear();
    brushLengthLessMoreController.clear();
    windowGapController.clear();
    crimpOnInsulationController.clear();
    improperCrimpingController.clear();
    tabBendTapOpenController.clear();
    strandsCutController.clear();
    cutoffBendController.clear();
    cutoffBendController.clear();
    insulationDamageController.clear();
    exposureStrandsController.clear();
    conductorBurrController.clear();
    terminalBackOutController.clear();
    setupRejectionsController.clear();
    terminalBackOutController.clear();
    insulationCurlingUpDownController.clear();
    cutOffLessMoreController.clear();
    bundlQtyController.clear();
    rejectedQtyController.clear();
  }

  Widget binScan() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            width: 250,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => handleKey(event.data),
                child: TextField(
                    controller: _binController,
                    onSubmitted: (value) {
                      hasBin = true;

                      // _bundleFocus.requestFocus();
                      Future.delayed(
                        const Duration(milliseconds: 50),
                        () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                      );
                    },
                    onTap: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                    onChanged: (value) {
                      setState(() {
                        binId = value;
                      });
                    },
                    decoration: new InputDecoration(
                        suffix: _binController.text.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _binController.clear();
                                  });
                                },
                                child: Icon(Icons.clear,
                                    size: 18, color: Colors.red))
                            : Container(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[400], width: 2.0),
                        ),
                        labelText: 'Scan bin',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5.0))),
              ),
            ),
          ),
          //Scan Bin Button
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 4,
                primary: Colors.red, // background
                onPrimary: Colors.white,
              ),
              child: Text(
                'Save  & Scan Next',
              ),
              onPressed: () {
                setState(() {
                  clear();
                  binId = '';
                  bundlQtyController.clear();
                  status = Status.scan;
                });
              },
            )),
          ),
        ],
      ),
    );
  }
}
