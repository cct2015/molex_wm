import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/models/bundle_scan.dart';
import 'package:molex/screens/operator%202/process/scanBundle.dart';

enum Status {
  scan,
  rejection,
}

class ScanBundleP3 extends StatefulWidget {
  @override
  _ScanBundleP3State createState() => _ScanBundleP3State();
}

class _ScanBundleP3State extends State<ScanBundleP3> {
  bool next = false;
  List<BundleScan> bundleScan = [];

  String _output = '';

  TextEditingController mainController = new TextEditingController();

  TextEditingController _scanIdController = new TextEditingController();
  Status status = Status.scan;

  TextEditingController bundleQtyController= new TextEditingController();

  TextEditingController passedQtyController= new TextEditingController();

  TextEditingController rejectedQtyController= new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return main(status);
  }

  Widget main(Status status) {
    switch (status) {
      case Status.scan:
        return scanBundlePop();
        break;
      case Status.rejection:
        return scanbundleidpop();
        break;
      default:
        return Container();
    }
  }
  // Widget scanbundlepop() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width * 0.3,
  //     height: 150,
  //     decoration: BoxDecoration(
  //       borderRadius: new BorderRadius.circular(20.0),
  //       color: Colors.grey[100],
  //     ),
  //     child: Center(
  //       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Container(
  //             height: 50,
  //             width: MediaQuery.of(context).size.width * 0.3 * 0.7,
  //             child: TextField(
  //               // controller: scanBundleController,
  //               // focusNode: scanFocus,
  //               autofocus: true,
  //               onTap: () {
  //                 SystemChannels.textInput.invokeMethod('TextInput.hide');
  //               },
  //               decoration: new InputDecoration(
  //                 hintText: "Scan Bundle",
  //                 fillColor: Colors.white,
  //                 border: new OutlineInputBorder(
  //                   borderRadius: new BorderRadius.circular(7.0),
  //                   borderSide: new BorderSide(),
  //                 ),
  //                 //fillColor: Colors.green
  //               ),
  //             ),
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Container(
  //                 child: ElevatedButton(
  //                   style: ButtonStyle(
  //                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
  //                       (Set<MaterialState> states) {
  //                         if (states.contains(MaterialState.pressed))
  //                           return Colors.red[500];
  //                         return Colors
  //                             .red[900]; // Use the component's default.
  //                       },
  //                     ),
  //                   ),
  //                   onPressed: () {
  //                     setState(() {
  //                       next = !next;
  //                     });
  //                   },
  //                   child: Text('Scan Bundle'),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Container(
  //                   child: ElevatedButton(
  //                 style: ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.resolveWith<Color>(
  //                     (Set<MaterialState> states) {
  //                       if (states.contains(MaterialState.pressed))
  //                         return Colors.grey[200];
  //                       return Colors.grey[100]; // Use the component's default.
  //                     },
  //                   ),
  //                 ),
  //                 onPressed: () {},
  //                 child: Text('999', style: TextStyle(color: Colors.black)),
  //               )),
  //             ),
  //           ],
  //         )
  //       ]),
  //     ),
  //   );
  // }

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

  handleKey(RawKeyEventDataAndroid key) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  Widget scanbundleidpop() {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.55,
          decoration: BoxDecoration(
            borderRadius: new BorderRadius.circular(20.0),
            color: Colors.grey[100],
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Bundle Id - BUN123412129',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                quantity('Bundle Qty', 10,bundleQtyController),
                quantity('Passed Qty', 10,passedQtyController),
                quantity('Rejected Qty', 10,rejectedQtyController),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.green[300];
                        return Colors
                            .green[800]; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      status = Status.scan;
                      next = !next;
                    });
                  },
                  child: Text('Save and Scan next',
                      style: TextStyle(color: Colors.white)),
                )),
              ),
            ],
          )),
        ),
        Container(
            padding: EdgeInsets.all(50),
            child: Center(child: keypad(mainController))),
      ],
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

  Widget quantity(String title, int quantity,TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 120,
              child: TextField(
                controller: textEditingController,
                style: TextStyle(fontSize: 12),
                onTap: (){
                    setState(() {
                    _output = '';
                    mainController = textEditingController;
                  });
                },
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
}
