import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/screens/operator/location.dart';
enum Status {
  scanBundle,
  rejection,
  scanBin,
}
class ViScanBundle extends StatefulWidget {
  @override
  Vi_ScanStateBundle createState() => Vi_ScanStateBundle();
}

class Vi_ScanStateBundle extends State<ViScanBundle> {
  Status status = Status.scanBundle;
   TextEditingController scanBundleController = new TextEditingController();

     TextEditingController crimpInslController = new TextEditingController();
       TextEditingController insulationSlugController = new TextEditingController();
       TextEditingController windowgapController = new TextEditingController();
       TextEditingController exposedStrandsController = new TextEditingController();
       TextEditingController burrCutOffController = new TextEditingController();
       TextEditingController terminalBendCloseddamageController = new TextEditingController();
       TextEditingController insulationCurlingController = new TextEditingController();
       TextEditingController nickMarkStrandcutController = new TextEditingController();
       TextEditingController seamOpenController = new TextEditingController();
       TextEditingController missCrimpController = new TextEditingController();
       TextEditingController frontBelMouthController = new TextEditingController();
       TextEditingController backBellMouthController = new TextEditingController();
       TextEditingController extructionOnBurrController = new TextEditingController();
       TextEditingController brushLengthController = new TextEditingController();
       TextEditingController cabledamageController = new TextEditingController();
       TextEditingController terminalTwistController = new TextEditingController();

  FocusNode scanFocus = new FocusNode();

  String _output = '';

  TextEditingController maincontroller= new TextEditingController();

  TextEditingController _binController = new TextEditingController();

  String binId;

  TextEditingController passedQtyController = new TextEditingController();
  TextEditingController bundleQtyController = new TextEditingController();

  TextEditingController rejectedQtyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
      SystemChrome.setEnabledSystemUIOverlays([]);
       SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Container(
       height: MediaQuery.of(context).size.height*0.5,
      child: Center(child: main(status)),
    );
  }
  
  Widget main(Status status) {
    switch (status) {
      case Status.scanBundle:
        return viscanbundle();
        break;
      case Status.rejection:
        return vitable();
        break;
        case Status.scanBin:
        return binScan();
        break;
      default:
        return Container();
    }
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
                  child: RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (event) => handleKey(event.data),
                    child: Container(
                      child: TextField(
                        controller: scanBundleController,
                        focusNode: scanFocus,
                        autofocus: true,
                        onTap: () {
                          setState(() {
                          
                          });
                        },
                        decoration: new InputDecoration(
                          labelText: "Scan Bundle",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(7.0),
                            borderSide: new BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                      ),
                    ),
                  ))),
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
                        status= Status.rejection;
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
    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
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


  Widget vitable() {
    return Row(
      children: [
        Container(
       
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
                         quantitycell(
                                name: "Crimp Insl",
                                quantity: 10,
                                textEditingController: crimpInslController,
                              ),
                               quantitycell(
                                name: "Insulation Slug",
                                quantity: 10,
                                textEditingController: insulationSlugController,
                              ),
                               quantitycell(
                                name: "Window Gap",
                                quantity: 10,
                                textEditingController: windowgapController,
                              ),
                               quantitycell(
                                name: "Exposed Strands",
                                quantity: 10,
                                textEditingController: exposedStrandsController,
                              ),
                      ],
                    ),
                    Column(
                      children: [
                          quantitycell(
                                name: "Burr / Cut Off",
                                quantity: 10,
                                textEditingController: burrCutOffController,
                              ),  quantitycell(
                                name: "Terminal Bend / Closed / Damage",
                                quantity: 10,
                                textEditingController: terminalBendCloseddamageController,
                              ),  quantitycell(
                                name: "Insulation Curling / Half Curling",
                                quantity: 10,
                                textEditingController: insulationCurlingController,
                              ),  quantitycell(
                                name: "Nick Mark / Strands Cut",
                                quantity: 10,
                                textEditingController: nickMarkStrandcutController,
                              ),
                      ],
                    ),
                    Column(
                      children: [
                        quantitycell(
                                name: "Seam Open",
                                quantity: 10,
                                textEditingController: seamOpenController,
                              ),
                                 quantitycell(
                                name: "Miss Crimp",
                                quantity: 10,
                                textEditingController: missCrimpController,
                              ),
                                 quantitycell(
                                name: "Front Bell Mouth",
                                quantity: 10,
                                textEditingController: frontBelMouthController,
                              ),
                                 quantitycell(
                                name: "Back Bell Mouth",
                                quantity: 10,
                                textEditingController: backBellMouthController,
                              ),
                      ],
                    ),
                    Column(
                      children: [
                          quantitycell(
                                name: "Extrusion on Burr",
                                quantity: 10,
                                textEditingController: extructionOnBurrController,
                              ),
                                quantitycell(
                                name: "Brush Length",
                                quantity: 10,
                                textEditingController: brushLengthController,
                              ),
                                quantitycell(
                                name: "Cable Damage",
                                quantity: 10,
                                textEditingController: cabledamageController,
                              ),
                                quantitycell(
                                name: "Terminal Twist",
                                quantity: 10,
                                textEditingController: terminalTwistController,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    quantity("Bundle Qty", 10,bundleQtyController),
                    quantity("Passed Qty", 10,passedQtyController),
                    quantity("Rejected Qty", 10,rejectedQtyController),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.green[500];
                                  return Colors
                                      .green[900]; // Use the component's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                status = Status.scanBin;
                              });
                            },
                            child: Text('Save & Scan Next'),
                          ),
                          SizedBox(width:15),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.red[500];
                                  return Colors
                                      .red[900]; // Use the component's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Location(userId: '121200', machineId: '6541531'),
                                ),
                              );
                            },
                            child: Text('Complete Inspection'),
                          ),
                        ]),
                  ],
                ),
              )
            ],
          ),
        ),
          keypad(maincontroller)
      ],
    );
  }

  Widget quantity(String title, int quantity,TextEditingController textEditingController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.16,
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
              height: 30,
              width: 70,
              child: TextField(
                style: TextStyle(fontSize: 12),
                keyboardType: TextInputType.number,
                controller: textEditingController,
                onTap: (){
                   SystemChannels.textInput.invokeMethod('TextInput.hide');
                    setState(() {
                      _output = '';
                      maincontroller = textEditingController;
                    });
                },
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
                height: 32,
                width: 140,
                child: TextField(
                  showCursor: false,
                  controller: textEditingController,
                  focusNode: focusNode,
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    setState(() {
                      _output = '';
                      maincontroller = textEditingController;
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
                   
                        _binController.clear();
                        setState(() {
                        
                        });
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
                'Save & Sacn Next',
              ),
              onPressed: () {
                setState(() {
                  status = Status.scanBundle;
                    Future.delayed(
                        const Duration(milliseconds: 50),
                        () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                      );
                });
              },
            )),
          ),
        ],
      ),
    );
  }

}
