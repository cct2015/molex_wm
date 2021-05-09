import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:molex/model_api/login_model.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/screens/Preparation/preparationDash.dart';
import 'package:molex/screens/Preparation/prepMachineScan.dart';
import 'package:molex/screens/operator%202/Home_0p2.dart';
import 'package:molex/screens/operator/Homepage.dart';
import 'package:molex/screens/visual%20Inspector/Home_visual_inspector.dart';
import 'package:molex/service/apiService.dart';

class MachineId extends StatefulWidget {
  Employee employee;
  MachineId({this.employee});
  @override
  _MachineIdState createState() => _MachineIdState();
}

class _MachineIdState extends State<MachineId> {
  TextEditingController _textController = new TextEditingController();
  FocusNode _textNode = new FocusNode();
  String machineId;
  ApiService apiService;

  @override
  void initState() {
    apiService = new ApiService();
    _textNode.requestFocus();
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    super.initState();
  }

  handleKey(RawKeyEventDataAndroid key) {
    String _keyCode;
    _keyCode = key.keyCode.toString(); //keyCode of key event(66 is return )
    print("why does this run twice $_keyCode");
    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _textNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Scan Machine",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.red[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                    child: Column(children: [
                      Lottie.asset('assets/lottie/scan-barcode.json',
                          width: 320, fit: BoxFit.cover),
                      GestureDetector(
                        onTap: () {
                          MachineDetails machineDetails1 =
                              new MachineDetails(machineNumber: machineId);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage(
                                      userId: widget.employee.empId,
                                      machine: machineDetails1,
                                    )),
                          );
                        },
                        child: Text(
                          'Scan Machine ${machineId ?? ""}',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.green;
                                return Colors
                                    .red; // Use the component's default.
                              },
                            ),
                          ),
                          onPressed: () {
                            if (machineId == "preparation") {
                              Fluttertoast.showToast(
                                  msg: "logged In",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PreprationDash(
                                          userId: widget.employee.empId,
                                          machineId: machineId,
                                        )),
                              );
                            } else {
                              apiService
                                  .getmachinedetails(machineId)
                                  .then((value) {
                                if (value != null) {
                                  MachineDetails machineDetails = value[0];
                                  Fluttertoast.showToast(
                                      msg: machineId,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);

                                  print("machineID:$machineId");
                                  switch (machineDetails.category) {
                                    case "Manual Crimping":
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePageOp2(
                                                  userId: widget.employee.empId,
                                                  machine: machineDetails,
                                                )),
                                      );
                                      break;
                                    case "Manual Cutting":
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage(
                                                  userId: widget.employee.empId,
                                                  machine: machineDetails,
                                                )),
                                      );
                                      break;
                                    case "Automatic Cut & Crimp":
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage(
                                                  userId: widget.employee.empId,
                                                  machine: machineDetails,
                                                )),
                                      );
                                      break;
                                    case "Semi Automatic Strip and Crimp machine":
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePageOp2(
                                                  userId: widget.employee.empId,
                                                  machine: machineDetails,
                                                )),
                                      );
                                      break;
                                    case "Automatic Cutting":
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage(
                                                  userId: widget.employee.empId,
                                                  machine: machineDetails,
                                                )),
                                      );
                                      break;
                                    default:
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Homepage(
                                                  userId: widget.employee.empId,
                                                  machine: machineDetails,
                                                )),
                                      );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Machine not Found",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  setState(() {
                                    machineId = null;
                                    _textController.clear();
                                  });
                                }
                              });
                            }
                          },
                          child: Text('Next'),
                        ),
                      ),
                      SizedBox(height: 10),
                      //INSPECTION
                      Container(
                        height: 40,
                        width: 200,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.green;
                                  return Colors
                                      .red; // Use the component's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: "logged In",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeVisualInspector(
                                          userId: widget.employee.empId,
                                        )),
                              );
                            },
                            child: Text('Login as Inspection')),
                      ),
                      //pREPARATION
                      SizedBox(height: 10),
                      Container(
                        child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (event) {
                              if (event.isKeyPressed(LogicalKeyboardKey.tab)) {}

                              handleKey(event.data);
                            },
                            child: Container(
                              height: 00,
                              width: 0,
                              child: TextField(
                                textInputAction: TextInputAction.done,
                                onSubmitted: (value) {},
                                onTap: () {
                                  SystemChannels.textInput
                                      .invokeMethod('TextInput.hide');
                                },
                                controller: _textController,
                                autofocus: true,
                                onChanged: (value) {
                                  setState(() {
                                    machineId = value;
                                  });
                                },
                              ),
                            )),
                      ),
                    ]),
                  )),
            ],
          ),
        ),
        Positioned(
            top: 50,
            right: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      widget.employee.employeeName ?? '',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.employee.empId ?? '',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 15),
                Material(
                  elevation: 5,
                  shadowColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                )
              ],
            ))
      ],
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
