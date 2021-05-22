import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/model_api/visualInspection/saveinspectedBundle_model.dart';
import 'package:molex/models/preparationScan.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';

enum Status {
  dash,
  rejCase,
  binScan,
}

class VIWIP_Home extends StatefulWidget {
  String userId;
  VIWIP_Home({this.userId});
  @override
  _VIWIP_HomeState createState() => _VIWIP_HomeState();
}

class _VIWIP_HomeState extends State<VIWIP_Home> {
  TextEditingController _userScanController = new TextEditingController();
  FocusNode _userScanFocus = new FocusNode();
  TextEditingController _bundleIdScanController = new TextEditingController();
  FocusNode _bundleIdScanFocus = new FocusNode();
  String userId;
  String bundleId;
  List<ViInspectedbudle> viIspectionBundleList = [];
  TextEditingController scanBundleController = new TextEditingController();

  TextEditingController crimpInslController = new TextEditingController();
  TextEditingController insulationSlugController = new TextEditingController();
  TextEditingController windowgapController = new TextEditingController();
  TextEditingController exposedStrandsController = new TextEditingController();
  TextEditingController burrCutOffController = new TextEditingController();
  TextEditingController terminalBendCloseddamageController =
      new TextEditingController();
  TextEditingController insulationCurlingController =
      new TextEditingController();
  TextEditingController nickMarkStrandcutController =
      new TextEditingController();
  TextEditingController seamOpenController = new TextEditingController();
  TextEditingController missCrimpController = new TextEditingController();
  TextEditingController frontBelMouthController = new TextEditingController();
  TextEditingController backBellMouthController = new TextEditingController();
  TextEditingController extructionOnBurrController =
      new TextEditingController();
  TextEditingController brushLengthController = new TextEditingController();
  TextEditingController cabledamageController = new TextEditingController();
  TextEditingController terminalTwistController = new TextEditingController();

  FocusNode scanFocus = new FocusNode();

  String _output = '';

  TextEditingController maincontroller = new TextEditingController();

  TextEditingController _binController = new TextEditingController();

  String binId;

  TextEditingController passedQtyController = new TextEditingController();
  TextEditingController bundleQtyController = new TextEditingController();

  TextEditingController rejectedQtyController = new TextEditingController();

  TextEditingController userScanController = new TextEditingController();
  Status status = Status.dash;

  int selectedindex = 0;
  ApiService apiService;
  @override
  void initState() {
    apiService = new ApiService();
    super.initState();
  }

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
          'Visual Inspection',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0,
        automaticallyImplyLeading: status == Status.dash ? true : false,
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
      body: Container(
        child: main(status),
      ),
    );
  }

  Widget main(Status status) {
    switch (status) {
      case Status.dash:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [scanUserAndBundle(), table()],
        );
        break;
      case Status.rejCase:
        return vitable(selectedindex);
        break;
      case Status.binScan:
        return binScan(selectedindex);
        break;
      default:
        return Container();
    }
  }

  Widget scanUserAndBundle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: Colors.transparent,
          height: 400,
          width: 300,
          child: Column(
            children: [userScan(), bundleScan(), button()],
          )),
    );
  }

  Widget button() {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.22,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          primary: Colors.green, // background
          onPrimary: Colors.white,
        ),
        onPressed: () {
          if (userId.length > 0 && bundleId.length > 0) {
            setState(() {
              viIspectionBundleList.add(
                ViInspectedbudle(
                    bundleIdentification: bundleId,
                    employeeId: userId,
                    status: "Not Completed"),
                // PreparationScan(
                //   employeeId: userId,
                //   bundleId: bundleId,
                //   status: 'In Process',
                //   binId: null)
              );
              _bundleIdScanController.clear();
              bundleId = '';
            });
          } else {
            Fluttertoast.showToast(
                msg: "Invalid userId and Bundle Id",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        child: Text(
          'Next',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  handleKey(RawKeyEventDataAndroid key) {
    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  Widget userScan() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => handleKey(event.data),
                      child: TextField(
                          focusNode: _userScanFocus,
                          controller: _userScanController,
                          onTap: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          },
                          onSubmitted: (value) {},
                          onChanged: (value) {
                            setState(() {
                              userId = value;
                            });
                          },
                          decoration: new InputDecoration(
                              suffix: _userScanController.text.length > 1
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _userScanController.clear();
                                        });
                                      },
                                      child: Icon(Icons.clear,
                                          size: 18, color: Colors.red))
                                  : Container(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[400], width: 2.0),
                              ),
                              labelText: '  Scan User  ',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 5.0))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget bundleScan() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => handleKey(event.data),
                      child: TextField(
                          focusNode: _bundleIdScanFocus,
                          controller: _bundleIdScanController,
                          onTap: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          },
                          onSubmitted: (value) {},
                          onChanged: (value) {
                            setState(() {
                              bundleId = value;
                            });
                          },
                          decoration: new InputDecoration(
                              suffix: _bundleIdScanController.text.length > 1
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _bundleIdScanController.clear();
                                        });
                                      },
                                      child: Icon(Icons.clear,
                                          size: 18, color: Colors.red))
                                  : Container(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[400], width: 2.0),
                              ),
                              labelText: '  Scan Bundle Id  ',
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget table() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 600,
        width: 600,
        color: Colors.transparent,
        child: Column(
          children: [
            DataTable(
              columnSpacing: 40,
              columns: [
                DataColumn(
                  label: Text(
                    'Employee Id',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                DataColumn(
                    label: Text(
                  'Bundle Id',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 12),
                  ),
                )),
                DataColumn(
                  label: Text(
                    'BIN Id',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                DataColumn(
                    label: Text(
                  '',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 12),
                  ),
                ))
              ],
              rows: viIspectionBundleList
                  .map(
                    (e) => DataRow(cells: <DataCell>[
                      DataCell(Text(
                        "${e.employeeId}",
                        style: TextStyle(fontSize: 12),
                      )),
                      DataCell(Text(
                        "${e.bundleIdentification}",
                        style: TextStyle(fontSize: 12),
                      )),
                      DataCell(Text(
                        e.binId ?? '-',
                        style: TextStyle(fontSize: 12),
                      )),
                      DataCell(Text(
                        e.status ?? "",
                        style: TextStyle(fontSize: 12),
                      )),
                      DataCell(e.status == 'completed'
                          ? Text("-")
                          : ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedindex =
                                      viIspectionBundleList.indexOf(e);
                                  status = Status.rejCase;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                primary: Colors.green, // background
                                onPrimary: Colors.white,
                              ),
                              child: Text('Process'),
                            )),
                    ]),
                  )
                  .toList(),
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
        height: MediaQuery.of(context).size.height * 0.4,
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

  Widget vitable(int selectedindex) {
    return Center(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.circular(20.0),
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(
                            children: [
                              feild(
                                  heading: "User Id",
                                  value:
                                      "${viIspectionBundleList[selectedindex].employeeId}",
                                  width: 0.15),
                              feild(
                                  heading: "Bundle Id",
                                  value:
                                      "${viIspectionBundleList[selectedindex].bundleIdentification}",
                                  width: 0.15),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //     height: 32,
                      //     width: MediaQuery.of(context).size.width * 0.5,
                      //     child: Center(
                      //       child: Column(
                      //         children: [
                      //           Text(
                      //             'Bundle ID',
                      //             style: TextStyle(
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.w600,
                      //             ),
                      //           ),
                      //           Text(
                      //             "${scanBundleController.text}",
                      //             style: TextStyle(
                      //               color: Colors.green[900],
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.w700,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     )),
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
                                  textEditingController:
                                      insulationSlugController,
                                ),
                                quantitycell(
                                  name: "Window Gap",
                                  quantity: 10,
                                  textEditingController: windowgapController,
                                ),
                                quantitycell(
                                  name: "Exposed Strands",
                                  quantity: 10,
                                  textEditingController:
                                      exposedStrandsController,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                quantitycell(
                                  name: "Burr / Cut Off",
                                  quantity: 10,
                                  textEditingController: burrCutOffController,
                                ),
                                quantitycell(
                                  name: "Terminal Bend / Closed / Damage",
                                  quantity: 10,
                                  textEditingController:
                                      terminalBendCloseddamageController,
                                ),
                                quantitycell(
                                  name: "Insulation Curling / Half Curling",
                                  quantity: 10,
                                  textEditingController:
                                      insulationCurlingController,
                                ),
                                quantitycell(
                                  name: "Nick Mark / Strands Cut",
                                  quantity: 10,
                                  textEditingController:
                                      nickMarkStrandcutController,
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
                                  textEditingController:
                                      frontBelMouthController,
                                ),
                                quantitycell(
                                  name: "Back Bell Mouth",
                                  quantity: 10,
                                  textEditingController:
                                      backBellMouthController,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                quantitycell(
                                  name: "Extrusion on Burr",
                                  quantity: 10,
                                  textEditingController:
                                      extructionOnBurrController,
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
                                  textEditingController:
                                      terminalTwistController,
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
                            quantity("Bundle Qty", 10, bundleQtyController),
                            // quantity("Passed Qty", 10,passedQtyController),
                            quantity("Rejected Qty", 10, rejectedQtyController),
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
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Colors.green;
                                          return Colors
                                              .green; // Use the component's default.
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        status = Status.binScan;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('Save & Scan Next'),
                                    ),
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
            ),
          )),
    );
  }

  Widget quantity(
      String title, int quantity, TextEditingController textEditingController) {
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
                onTap: () {
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

  Widget binScan(int selectedindex) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Padding(
      padding: const EdgeInsets.all(108.0),
      child: Container(
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
                        setState(() {});
                      },
                      onChanged: (value) {
                        setState(() {
                          binId = value;
                        });
                      },
                      decoration: new InputDecoration(
                          suffix: _binController.text.length > 1
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 7.0),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _binController.clear();
                                        });
                                      },
                                      child: Icon(Icons.clear,
                                          size: 18, color: Colors.red)),
                                )
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
                  'Save & Scan Next',
                ),
                onPressed: () {
                  setState(() {
                    clear();

                    viIspectionBundleList[selectedindex].status = "completed";
                    viIspectionBundleList[selectedindex].binId =
                        "${_binController.text}";
                  });
                  apiService
                      .postVIinspectedBundle(
                          viInspectedbudle:
                              viIspectionBundleList[selectedindex])
                      .then((value) {
                    if (value) {
                      setState(() {
                        status = Status.dash;
                      });
                      scanBundleController.clear();
                      userScanController.clear();
                      _binController.clear();
                    } else {
                      Fluttertoast.showToast(
                          msg: "Unable to upload inspected data",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  });

                  Future.delayed(
                    const Duration(milliseconds: 50),
                    () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    },
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }

  void clear() {
    crimpInslController.clear();
    insulationSlugController.clear();
    windowgapController.clear();
    exposedStrandsController.clear();
    burrCutOffController.clear();
    terminalBendCloseddamageController.clear();
    insulationCurlingController.clear();
    nickMarkStrandcutController.clear();
    seamOpenController.clear();
    missCrimpController.clear();
    frontBelMouthController.clear();
    backBellMouthController.clear();
    extructionOnBurrController.clear();
    brushLengthController.clear();
    cabledamageController.clear();
    terminalTwistController.clear();
  }
}
