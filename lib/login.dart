import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:molex/model_api/login_model.dart';
// import 'package:lottie/lottie.dart';
import 'package:molex/Machine_Id.dart';
import 'package:molex/screens/Preparation/Home_0p3.dart';
import 'package:molex/screens/Preparation/prepMachineScan.dart';
import 'package:molex/screens/visual%20Inspector/Home_visual_inspector.dart';
import 'package:molex/service/apiService.dart';

class LoginScan extends StatefulWidget {
  @override
  _LoginScanState createState() => _LoginScanState();
}

class _LoginScanState extends State<LoginScan> {
  TextEditingController _textController = new TextEditingController();
  FocusNode _textNode = new FocusNode();
  String userId;
  ApiService apiService;
  Employee employee;

  @override
  void initState() {
    apiService = new ApiService();
    employee = new Employee();
    _textNode.requestFocus();
    SystemChrome.setEnabledSystemUIOverlays([]);
     SystemChannels.textInput.invokeMethod('TextInput.hide');
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _textNode.dispose();
    super.dispose();
  }

  handleKey(RawKeyEventDataAndroid key) {
    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Stack(children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.red[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 5.0,
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Lottie.asset('assets/lottie/scan-barcode.json',
                                width: 280, fit: BoxFit.cover),
                            Text(
                              'Scan Id card to Login ${userId ?? ''} ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 40,
                              width: 200,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed))
                                          return Colors.green;
                                        return Colors
                                            .red; // Use the component's default.
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    print('pressed');
                                    apiService.empIdlogin(userId).then((value) {
                                      if (value != null) {
                                        Fluttertoast.showToast(
                                            msg: "logged In",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        print("userId:$userId");
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MachineId(
                                                    employee: value,
                                                  )),
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "login Failed",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        setState(() {
                                          userId = null;
                                          _textController.clear();
                                        });
                                      }
                                    });
                                  },
                                  child: Text('Login')),
                            ),
                               SizedBox(height:10),
                            //  Container(
                            //   height: 40,
                            //   width: 200,
                            //   child: ElevatedButton(
                            //       style: ButtonStyle(
                            //         backgroundColor: MaterialStateProperty
                            //             .resolveWith<Color>(
                            //           (Set<MaterialState> states) {
                            //             if (states
                            //                 .contains(MaterialState.pressed))
                            //               return Colors.green;
                            //             return Colors
                            //                 .red; // Use the component's default.
                            //           },
                            //         ),
                            //       ),
                            //       onPressed: () {
                            //         print('pressed');
                            //         apiService.empIdlogin(userId).then((value) {
                            //           if (value != null) {
                            //             Fluttertoast.showToast(
                            //                 msg: "logged In",
                            //                 toastLength: Toast.LENGTH_SHORT,
                            //                 gravity: ToastGravity.BOTTOM,
                            //                 timeInSecForIosWeb: 1,
                            //                 backgroundColor: Colors.red,
                            //                 textColor: Colors.white,
                            //                 fontSize: 16.0);
                            //             print("userId:$userId");
                            //             Navigator.pushReplacement(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) => PrepMachine(
                            //                         employee: value,
                            //                       )),
                            //             );
                            //           } else {
                            //             Fluttertoast.showToast(
                            //                 msg: "login Failed",
                            //                 toastLength: Toast.LENGTH_SHORT,
                            //                 gravity: ToastGravity.BOTTOM,
                            //                 timeInSecForIosWeb: 1,
                            //                 backgroundColor: Colors.red,
                            //                 textColor: Colors.white,
                            //                 fontSize: 16.0);
                            //             setState(() {
                            //               userId = null;
                            //               _textController.clear();
                            //             });
                            //           }
                            //         });
                            //       },
                            //       child: Text('Login as Preparation')),
                            // ),
                            // SizedBox(height:10),
                            //  Container(
                            //   height: 40,
                            //   width: 200,
                            //   child: ElevatedButton(
                            //       style: ButtonStyle(
                            //         backgroundColor: MaterialStateProperty
                            //             .resolveWith<Color>(
                            //           (Set<MaterialState> states) {
                            //             if (states
                            //                 .contains(MaterialState.pressed))
                            //               return Colors.green;
                            //             return Colors
                            //                 .red; // Use the component's default.
                            //           },
                            //         ),
                            //       ),
                            //       onPressed: () {
                            //         print('pressed');
                            //         apiService.empIdlogin(userId).then((value) {
                            //           if (value != null) {
                            //             Fluttertoast.showToast(
                            //                 msg: "logged In",
                            //                 toastLength: Toast.LENGTH_SHORT,
                            //                 gravity: ToastGravity.BOTTOM,
                            //                 timeInSecForIosWeb: 1,
                            //                 backgroundColor: Colors.red,
                            //                 textColor: Colors.white,
                            //                 fontSize: 16.0);
                            //             print("userId:$userId");
                            //             Navigator.pushReplacement(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) => HomeVisualInspector(
                            //                         userId: value.empId,
                            //                       )),
                            //             );
                            //           } else {
                            //             Fluttertoast.showToast(
                            //                 msg: "login Failed",
                            //                 toastLength: Toast.LENGTH_SHORT,
                            //                 gravity: ToastGravity.BOTTOM,
                            //                 timeInSecForIosWeb: 1,
                            //                 backgroundColor: Colors.red,
                            //                 textColor: Colors.white,
                            //                 fontSize: 16.0);
                            //             setState(() {
                            //               userId = null;
                            //               _textController.clear();
                            //             });
                            //           }
                            //         });
                            //       },
                            //       child: Text('Login as Inspection')),
                            // ),
                            Container(
                                alignment: Alignment.center,
                                width: 0,
                                height: 0,
                                child: RawKeyboardListener(
                                  focusNode: FocusNode(),
                                  onKey: (event) async {
                                    if (event
                                        .isKeyPressed(LogicalKeyboardKey.tab)) {
                                      Fluttertoast.showToast(
                                          msg: "Got tab at the end",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      setState(() {
                                        userId = null;
                                      });
                                    }
                                    handleKey(event.data);
                                  },
                                  child: TextField(
                                    textInputAction: TextInputAction.search,
                                    onSubmitted: (value) async {},
                                    onTap: () {
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                    },
                                    controller: _textController,
                                    autofocus: true,
                                    // focusNode: _textNode,
                                    onChanged: (value) {
                                      setState(() {
                                        userId = value;
                                      });
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }

  Future<String> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    return barcodeScanRes;
  }
}
