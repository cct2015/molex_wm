import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/screens/operator/bin.dart';

class FullCompleteP2 extends StatefulWidget {
  String userId;
  String machineId;
  FullCompleteP2({this.userId, this.machineId});
  @override
  _FullCompleteP2State createState() => _FullCompleteP2State();
}

class _FullCompleteP2State extends State<FullCompleteP2> {
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
  TextEditingController bundleQuantityController = new TextEditingController();
  TextEditingController passedQuantityController = new TextEditingController();
  TextEditingController rejectedQuantityController =
      new TextEditingController();
  String _output = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Container(
      child: Row(
        children: [rejectioncase(), keypad(mainController)],
      ),
    );
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
              padding: const EdgeInsets.all(8.0),
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
                            textEditingController: terminalDamageController,
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
                  quantity("Bundle Qty", 10, bundleQuantityController),
                  quantity("Passed Qty", 10, passedQuantityController),
                  quantity("Rejected Qty", 10, rejectedQuantityController),
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
                height: 33,
                width: 140,
                child: TextField(
                  showCursor: false,
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

  Widget quantity(
      String title, int quantity, TextEditingController textEditingController) {
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
                onTap: () {
                  setState(() {
                    _output = '';
                    mainController = textEditingController;
                  });
                },
                style: TextStyle(fontSize: 12),
                controller: textEditingController,
                keyboardType: TextInputType.number,
                showCursor: false,
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
}
