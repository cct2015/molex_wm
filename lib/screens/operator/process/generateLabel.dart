import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/model_api/generateLabel_model.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/model_api/transferBundle_model.dart';
import 'package:molex/service/apiService.dart';

enum Status {
  quantity,
  generateLabel,
  scanBundle,
  scanBin,
}

class GenerateLabel extends StatefulWidget {
  Schedule schedule;
  MachineDetails machine;
  String userId;
  GenerateLabel({this.machine, this.schedule, this.userId});
  @override
  _GenerateLabelState createState() => _GenerateLabelState();
}

class _GenerateLabelState extends State<GenerateLabel> {
  // Text Editing Controller for all rejection cases

  // All Quantity Contolle
  TextEditingController endWireController = new TextEditingController();
  FocusNode endWireFocus = new FocusNode();
  TextEditingController cableDamageController = new TextEditingController();
  FocusNode cableDamageFocus = new FocusNode();
  TextEditingController rollerMarkController = new TextEditingController();
  FocusNode rollerMarkFocus = new FocusNode();
  TextEditingController terminalDamangeController = new TextEditingController();
  FocusNode terminalDamangeFocus = new FocusNode();
  TextEditingController terminalBendController = new TextEditingController();
  TextEditingController terminalTwistController = new TextEditingController();
  TextEditingController windowGapController = new TextEditingController();
  TextEditingController brushLengthLessMoreController =
      new TextEditingController();

  TextEditingController halfCurlingController = new TextEditingController();

  TextEditingController setupRejectionsController = new TextEditingController();
  TextEditingController bellmouthLessMoreController =
      new TextEditingController();
  TextEditingController conductorCurlingUpDownController =
      new TextEditingController();
  TextEditingController insulationCurlingUpDownController =
      new TextEditingController();
  TextEditingController improperCrimpingController =
      new TextEditingController();
  TextEditingController tabBendTapOpenController = new TextEditingController();
  TextEditingController cutOffLessMoreController = new TextEditingController();
  TextEditingController cutoffBurrController = new TextEditingController();
  TextEditingController insulationDamageController =
      new TextEditingController();
  TextEditingController exposureStrandsController = new TextEditingController();
  TextEditingController strandsCutController = new TextEditingController();

  TextEditingController terminalBackOutController = new TextEditingController();
  TextEditingController entangledCableController = new TextEditingController();
  TextEditingController troubleshootingRejectionsController =
      new TextEditingController();
  TextEditingController wireOverloadRejectionsController =
      new TextEditingController();
  TextEditingController terminalSeamOpenController =
      new TextEditingController();

  TextEditingController lengthlessLengthMoreController =
      new TextEditingController();
  TextEditingController gripperMarkController = new TextEditingController();
  TextEditingController crimpingPositionOutMissCrimpController =
      new TextEditingController();
  TextEditingController crimpOnInsulationController =
      new TextEditingController();
  TextEditingController endTerminalController = new TextEditingController();
  TextEditingController conductorBurrController = new TextEditingController();
  TextEditingController cutoffBendController = new TextEditingController();
  TextEditingController terminalCopperMarkController =
      new TextEditingController();
  TextEditingController windowgapController = new TextEditingController();
  TextEditingController cablePositionController = new TextEditingController();
  TextEditingController cameraPositionOutController =
      new TextEditingController();
  TextEditingController bundleQty = new TextEditingController();
  TextEditingController bundleQtyFocus = new TextEditingController();
  TextEditingController _binController = new TextEditingController();
  TextEditingController maincontroller = new TextEditingController();
  TextEditingController bladeMarkController = new TextEditingController();
  FocusNode blademarkFocus = new FocusNode();
  FocusNode striplengthFocus = new FocusNode();
  TextEditingController stripLengthController = new TextEditingController();
  TextEditingController lengthvariationController = new TextEditingController();
  FocusNode lengthvariationFocus = new FocusNode();


/// Main Content



  bool labelGenerated = false;
  String _output = '';
  String binState;
  String binId;
  String bundleId;
  bool hasBin = false;
  Status status = Status.quantity;
  TransferBundle transferBundle = new TransferBundle();
  PostGenerateLabel postGenerateLabel = new PostGenerateLabel();
  static const platform = const MethodChannel('com.impereal.dev/tsc');
  String _printerStatus = 'Waiting';
  Future<void> _print({
    String ipaddress,
    String bq,
    String qr,
    String routenumber1,
    String fgPartNumber,
    String cutlength,
    String cablepart,
    String wireGauge,
    String terminalfrom,
    String terminalto,
  }) async {
    String printerStatus;

    try {
      final String result = await platform.invokeMethod('Print', {
        "ipaddress": ipaddress,
        "bundleQty": bq,
        "qr": qr,
        "routenumber1": routenumber1,
        "fgPartNumber": fgPartNumber,
        "cutlength": cutlength,
        "cutpart": cablepart,
        "wireGauge": wireGauge,
        "terminalfrom": terminalfrom,
        "terminalto": terminalto,
      });
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
  ApiService apiService;
  @override
  void initState() {
    apiService = new ApiService();
    transferBundle = new TransferBundle();

    transferBundle.cablePartDescription = widget.schedule.cablePartNumber;
    transferBundle.scheduledQuantity =
        int.parse(widget.schedule.scheduledQuantity);
    transferBundle.orderIdentification = int.parse(widget.schedule.orderId);
    transferBundle.machineIdentification = widget.machine.machineNumber;
    transferBundle.scheduledId = widget.schedule.scheduledId == ''
        ? 0
        : int.parse(widget.schedule.scheduledId);
    binState = "Scan Bin";
    super.initState();
  }

  void clear(){
        terminalDamangeController.clear();
    brushLengthLessMoreController.clear();
    setupRejectionsController.clear();
    improperCrimpingController.clear();
    insulationDamageController.clear();
    terminalBackOutController.clear();
    terminalSeamOpenController.clear();
    exposureStrandsController.clear();
    crimpingPositionOutMissCrimpController.clear();
    terminalBendController.clear();
    cableDamageController.clear();
    bellmouthLessMoreController.clear();
    tabBendTapOpenController.clear();
    exposureStrandsController.clear();
    entangledCableController.clear();
    rollerMarkController.clear();
    cameraPositionOutController.clear();
    terminalTwistController.clear();
    halfCurlingController.clear();
    conductorCurlingUpDownController.clear();
    cutOffLessMoreController.clear();
    strandsCutController.clear();
    troubleshootingRejectionsController.clear();
    lengthlessLengthMoreController.clear();
    windowGapController.clear();
    endWireController.clear();
    insulationCurlingUpDownController.clear();
    cutoffBurrController.clear();
    brushLengthLessMoreController.clear();
    wireOverloadRejectionsController.clear();
    wireOverloadRejectionsController.clear();
    cablePositionController.clear();
    endTerminalController.clear();
    conductorBurrController.clear();
    cutoffBendController.clear();
    terminalCopperMarkController.clear();
    crimpingPositionOutMissCrimpController.clear();
    crimpOnInsulationController.clear();
  }
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Container(
      child: Row(
        children: [
          main(status),
          keypad(maincontroller),
        ],
      ),
    );
  }

  Widget main(Status status) {
    switch (status) {
      case Status.quantity:
        return generateLabel();
        break;
      case Status.generateLabel:
         
        return rejectioncase();
        break;
      case Status.scanBin:
        return binScan();
        break;
      case Status.scanBundle:
        return bundleScan();
      default:
        return Container();
    }
  }

  Widget keypad(TextEditingController controller) {
    print('NickMark ${windowGapController.text}');
    print('End wire ${endWireController.text}');
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
          child: buttonText == "X"
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
                      color: Colors.black,
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

  Widget generateLabel() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: [
          //Quantity Feild
          Container(
            width: 190,
            height: 50,
            child: TextField(
              textAlign: TextAlign.center,
              controller: bundleQty,
              onEditingComplete: () {
                setState(() {
                  labelGenerated = !labelGenerated;
                  status = Status.generateLabel;
                });
              },
              onTap: () {
                setState(() {
                  _output = '';
                  maincontroller = bundleQty;
                });
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              },
              showCursor: false,
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 15),
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 3),
                labelText: "  Bundle Qty (SPQ)",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
            ),
          ),
          Container(
            width: 190,
            height: 60,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.135,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    color: Colors.transparent,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.transparent))),
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
                        child: Text(
                          'Generate Label',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            labelGenerated = !labelGenerated;
                            status = Status.generateLabel;
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.05,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.transparent),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.green[200];
                            return Colors
                                .red[500]; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text(
                        '1',
                        // bundlePrint.length.toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rejectioncase() {
  
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
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
                          quantitycell(
                            name: "Terminal Damage",
                            quantity: 10,
                            textEditingController: terminalDamangeController,
                          ),
                          quantitycell(
                            name: "Brush length Less / More	",
                            quantity: 10,
                            textEditingController:
                                brushLengthLessMoreController,
                          ),
                          quantitycell(
                            name: "Setup Rejections	",
                            quantity: 10,
                            textEditingController: setupRejectionsController,
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
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Terminal Back Out",
                            quantity: 10,
                            textEditingController: terminalBackOutController,
                          ),
                          quantitycell(
                            name: "Terminal Seam Open",
                            quantity: 10,
                            textEditingController: terminalSeamOpenController,
                          ),
                          quantitycell(
                            name: "Exposure Strands	",
                            quantity: 10,
                            textEditingController: exposureStrandsController,
                          ),
                          quantitycell(
                            name: "Crimping Position Out / Miss Crimp",
                            quantity: 10,
                            textEditingController:
                                crimpingPositionOutMissCrimpController,
                          ),
                          quantitycell(
                            name: "Terminal Bend",
                            quantity: 10,
                            textEditingController: terminalBendController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Cable Damage",
                            quantity: 10,
                            textEditingController: cableDamageController,
                          ),
                          quantitycell(
                            name: "Bellmouth Less / More",
                            quantity: 10,
                            textEditingController: bellmouthLessMoreController,
                          ),
                          quantitycell(
                            name: "Tab Bend / Tap Open",
                            quantity: 10,
                            textEditingController: tabBendTapOpenController,
                          ),
                          quantitycell(
                            name: "Exposure Strands	",
                            quantity: 10,
                            textEditingController: exposureStrandsController,
                          ),
                          quantitycell(
                            name: "Entangled Cable",
                            quantity: 10,
                            textEditingController: entangledCableController,
                          ),
                        ],
                      ),
                      Column(
                        children: [],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Roller Mark",
                            quantity: 10,
                            textEditingController: rollerMarkController,
                          ),
                          quantitycell(
                            name: "Camera Position Out",
                            quantity: 10,
                            textEditingController: cameraPositionOutController,
                          ),
                          quantitycell(
                            name: "Terminal Twist	",
                            quantity: 10,
                            textEditingController: terminalTwistController,
                          ),
                          quantitycell(
                            name: "Half Curling",
                            quantity: 10,
                            textEditingController: halfCurlingController,
                          ),
                          quantitycell(
                            name: "Conductor Curling Up & Down",
                            quantity: 10,
                            textEditingController:
                                conductorCurlingUpDownController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Cut-Off Less / More	",
                            quantity: 10,
                            textEditingController: cutOffLessMoreController,
                          ),
                          quantitycell(
                            name: "Strands Cut",
                            quantity: 10,
                            textEditingController: strandsCutController,
                          ),
                          quantitycell(
                            name: "Trouble shooting Rejections	",
                            quantity: 10,
                            textEditingController:
                                troubleshootingRejectionsController,
                          ),
                          quantitycell(
                            name: "Length less / Length More	",
                            quantity: 10,
                            textEditingController:
                                lengthlessLengthMoreController,
                          ),
                          quantitycell(
                            name: "Window Gap	",
                            quantity: 10,
                            textEditingController: windowGapController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "End Wire",
                            quantity: 10,
                            textEditingController: endWireController,
                          ),
                          quantitycell(
                            name: "Insulation Curling Up & Down",
                            quantity: 10,
                            textEditingController:
                                insulationCurlingUpDownController,
                          ),
                          quantitycell(
                            name: "Cut-off Burr",
                            quantity: 10,
                            textEditingController: cutoffBurrController,
                          ),
                          quantitycell(
                            name: "Brush Length Less / More",
                            quantity: 10,
                            textEditingController:
                                brushLengthLessMoreController,
                          ),
                          quantitycell(
                            name: "Wire Over load Rejections ",
                            quantity: 10,
                            textEditingController:
                                wireOverloadRejectionsController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Gripper Mark",
                            quantity: 10,
                            textEditingController: gripperMarkController,
                          ),
                          quantitycell(
                            name: "Cable Position Movement",
                            quantity: 10,
                            textEditingController: cablePositionController,
                          ),
                          quantitycell(
                            name: "End Terminal",
                            quantity: 10,
                            textEditingController: endTerminalController,
                          ),
                          quantitycell(
                            name: "Conductor Burr",
                            quantity: 10,
                            textEditingController: conductorBurrController,
                          ),
                          quantitycell(
                            name: "Cut-off Bend	",
                            quantity: 10,
                            textEditingController: cutoffBendController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Terminal Copper Mark	",
                            quantity: 10,
                            textEditingController: terminalCopperMarkController,
                          ),
                          quantitycell(
                            name: "Crimping Position Out / Miss Crimp",
                            quantity: 10,
                            textEditingController: crimpingPositionOutMissCrimpController,
                          ),
                          quantitycell(
                            name: "Crimp On Insulation",
                            quantity: 10,
                            textEditingController: crimpOnInsulationController,
                          ),
                        ],
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
                          postGenerateLabel = new PostGenerateLabel();
                          postGenerateLabel.cablePartNumber = widget.schedule.cablePartNumber;
                          postGenerateLabel.finishedGoods = widget.schedule.finishedGoodsNumber;
                          postGenerateLabel.machineIdentification = widget.machine.machineNumber;
                          postGenerateLabel.terminalBend = terminalBendController.text;
                          postGenerateLabel.terminalDamage = terminalDamangeController.text;
                          apiService.postGeneratelabel(postGenerateLabel, bundleQty.text).then((value) {
                            if(value!=null){
                              ResponseGenerateLabel response;
                              response = value;
                               _print(
                              // ipaddress: "192.168.1.130",
                              ipaddress: "172.26.59.14",
                              bq: bundleQty.text,
                              qr: response.data.generateLabel.bundleId,
                              routenumber1: "${response.data.generateLabel.routeNo}",
                              fgPartNumber: widget.schedule.finishedGoodsNumber,
                              cutlength: "${widget.schedule.length}",
                              cablepart: "${widget.schedule.cablePartNumber}",
                              wireGauge: "${widget.schedule.finishedGoodsNumber}",
                              terminalfrom: "${response.data.generateLabel.terminalFrom}",
                              terminalto: "${response.data.generateLabel.terminalTo}");
                            }
  clear();
                          });
                          labelGenerated = !labelGenerated;
                          status = Status.scanBin;
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
                height: 30,
                width: 140,
                child: TextField(
                  showCursor: false,
                  controller: textEditingController,
                  focusNode: focusNode,
                  onTap: () {
                    setState(() {
                      _output = '';
                      maincontroller = textEditingController;
                    });
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  style: TextStyle(fontSize: 12),
                  keyboardType: TextInputType.textscan,
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
                      binState = "Scan Next bin";
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
                      if (binState == "Scan Next bin") {
                        _binController.clear();
                        setState(() {
                          binId = null;
                          binState = "Scan Bin";
                        });
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        binId = value;
                      });
                    },
                    decoration: new InputDecoration(
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
                'Scan Bundle',
              ),
              onPressed: () {
                setState(() {
                  status = Status.scanBundle;
                });
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget bundleScan() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        children: [
          Container(
            width: 250,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => handleKey(event.data),
                child: TextField(
                    // focusNode: _bundleFocus,
                    // controller: _bundleController,
                    onSubmitted: (value) {
                      setState(() {
                        hasBin = true;
                        // bundleList.add(Bundle(
                        //   binId: binId,
                        //   bundleId: value,
                        // ));
                        // print(bundleList);
                        // _bundleController.clear();
                        // bundleId = null;
                      });
                    },
                    onTap: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                    onChanged: (value) {
                      setState(() {
                        bundleId = value;
                      });
                    },
                    decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[400], width: 2.0),
                        ),
                        labelText: 'Scan Bundle',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5.0))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 4,
                primary: Colors.red, // background
                onPrimary: Colors.white,
              ),
              child: Text(
                'Save & Scan Next',
              ),
              onPressed: () {
                setState(() {
                  status = Status.quantity;
                });
              },
            )),
          ),
        ],
      ),
    );
  }

  handleKey(RawKeyEventDataAndroid key) {
    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }
}
