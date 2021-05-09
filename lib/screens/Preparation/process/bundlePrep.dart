import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/models/bundle_scan.dart';
import 'package:molex/screens/widgets/time.dart';

enum Status {
  rejection,
  scanBin,
  scanBundle,
}

class ScanBundleP3 extends StatefulWidget {
  String bundleId;
  String machineId;
  String userId;
  // PreparationSchedule schedule;
  ScanBundleP3({this.bundleId, this.machineId, this.userId});
  @override
  _ScanBundleP3State createState() => _ScanBundleP3State();
}

class _ScanBundleP3State extends State<ScanBundleP3> {
  bool next = false;
  List<BundleScan> bundleScan = [];

  String _output = '';

  TextEditingController mainController = new TextEditingController();

  TextEditingController _scanIdController = new TextEditingController();
  Status status = Status.rejection;

  TextEditingController bundleQtyController = new TextEditingController();

  TextEditingController passedQtyController = new TextEditingController();

  TextEditingController rejectedQtyController = new TextEditingController();
  TextEditingController cableDamageController = new TextEditingController();
  TextEditingController cablecrosscutController = new TextEditingController();
  TextEditingController stripLengthController = new TextEditingController();
  TextEditingController stripNickController = new TextEditingController();
  TextEditingController unsheathingLengthController =
      new TextEditingController();
  TextEditingController drainWirecutController = new TextEditingController();
  TextEditingController trimmingCableWrongController =
      new TextEditingController();
  TextEditingController trimmingLengthlessController =
      new TextEditingController();
  TextEditingController hstImproperShrinkingController =
      new TextEditingController();
  TextEditingController hstDamageController = new TextEditingController();
  TextEditingController bootReverseController = new TextEditingController();
  TextEditingController wrongBootInsertionController =
      new TextEditingController();
  TextEditingController bootDamageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: const Text(
          'Preparation',
          style: TextStyle(color: Colors.red),
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
      body: Center(child: main(status)),
    );
  }

  Widget main(Status status) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    switch (status) {
      case Status.rejection:
        return scanbundleidpop();
        break;
      case Status.scanBin:
        return scanBin();
        break;
      case Status.scanBundle:
        return scanBundle();
        break;
      default:
        return Container();
    }
  }

  handleKey(RawKeyEventDataAndroid key) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Widget scanbundleidpop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.55,
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(20.0),
              color: Colors.grey[100],
            ),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: feild(
                              heading: "Bundle Id",
                              value: "${widget.bundleId}",
                              width: 0.12),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: feild(
                              heading: "Bundle Qty", value: "", width: 0.15),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: feild(
                              heading: "Rejected Qty", value: "", width: 0.15),
                        ),
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
                              Column(children: [
                                quantity(
                                    'Cable Damage', 10, cableDamageController),
                                quantity('Cable Cross Cut', 10,
                                    cablecrosscutController),
                                quantity(' Strip Length less / More', 10,
                                    stripLengthController),
                                quantity('Strip Nick mark / blade mark', 10,
                                    stripNickController),
                              ]),
                              Column(children: [
                                quantity('Unsheathing Length less / More', 10,
                                    unsheathingLengthController),
                                quantity('Drain Wire Cut', 10,
                                    drainWirecutController),
                                quantity('Trimming cable Wrong', 10,
                                    trimmingCableWrongController),
                                quantity('Trimming Length less / More', 10,
                                    trimmingLengthlessController),
                              ]),
                              Column(children: [
                                quantity('HST Improper Shrinking', 10,
                                    hstImproperShrinkingController),
                                quantity('HST Damage', 10, hstDamageController),
                                quantity(
                                    'Boot Reverse', 10, bootReverseController),
                                quantity(
                                    'Boot Damage', 10, bootDamageController),
                              ]),
                              Column(children: [
                                quantity('Wrong Boot Insertion', 10,
                                    wrongBootInsertionController),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 4,
                          primary: Colors.green, // background
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                     setState(() {
                       status =Status.scanBin;
                     });
                          // setState(() {
                          //   Future.delayed(
                          //     const Duration(milliseconds: 50),
                          //     () {
                          //       SystemChannels.textInput
                          //           .invokeMethod('TextInput.hide');
                          //     },
                          //   );
                          //   _scanIdController.clear();

                          //   status = Status.scan;
                          //   next = !next;
                          // });
                        },
                        child:
                            Text('Save', style: TextStyle(color: Colors.white)),
                      )),
                    ),
                  ],
                ),
                ),
          ),
        ),
        Container(
            height: 300,
            padding: EdgeInsets.all(20),
            child: Center(child: keypad(mainController))),
      ],
    );
  }

  Widget scanBin() {
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 3),
                          labelText: "Scan Bin",
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: 100,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith(
                                    (states) => Colors.redAccent),
                              ),
                              onPressed: () {
                               Navigator.pop(context);
                              },
                              child: Text('Scan Bin  ')),
                        ),
                      ),
                      SizedBox(width: 5),
                     
                    ],
                  ),
                ],
              )),
          // scanedTable(),
        ],
      ),
    );
  }

  Widget scanBundle() {
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 3),
                          labelText: "Scan Bin",
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
                            setState(() {
                              status = Status.rejection;
                            });
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
                              // showTable = !showTable;
                              status = Status.scanBundle;
                            });
                          },
                          child: Text("${bundleScan.length}")),
                    ],
                  ),
                ],
              )),
          // scanedTable(),
        ],
      ),
    );
  }

  // To Show the bundle Id and  Bundle Qty and rejected Quantity
  Widget feild({String heading, String value, double width}) {
    width = MediaQuery.of(context).size.width * width;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        // color: Colors.red[100],
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  heading,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.normal,
                  )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                children: [
                  Text(
                    value ?? '',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget keypad(TextEditingController controller) {
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

  Widget quantity(
      String title, int quantity, TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 140,
              child: TextField(
                controller: textEditingController,
                style: TextStyle(fontSize: 13),
                onTap: () {
                  setState(() {
                    _output = '';
                    mainController = textEditingController;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: title,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 13),
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
}
