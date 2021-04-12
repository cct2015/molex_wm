import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
// import 'package:lottie/lottie.dart';
import 'package:molex/screens/operator/Machine_Id.dart';

class LoginScan extends StatefulWidget {
  @override
  _LoginScanState createState() => _LoginScanState();
}

class _LoginScanState extends State<LoginScan> {
  TextEditingController _textController = new TextEditingController();
  FocusNode _textNode = new FocusNode();
  String userId;

  @override
  void initState() {
    _textNode.requestFocus();
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
    String _keyCode;
    _keyCode = key.keyCode.toString(); //keyCode of key event(66 is return )
    print("why does this run twice $_keyCode");
    print(_textController.text);
    setState(() {
      // userId = _textController.text;
      // _textController.clear();
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
    // if (userId != "") {
    //   Navigator.push(
    //     /',
    //     MaterialPageRoute(
    //         builder: (context) => MachineId(
    //               userId: userId,
    //             )),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (userId?.length==10) {
      Fluttertoast.showToast(
          msg: userId,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Future.delayed(Duration.zero, () async {
        print("userId:$userId");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MachineId(
                    userId: userId,
                  )),
        );
      });
    }
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
                        child: Column(
                          children: [
                            
                            Lottie.asset('assets/lottie/scan-barcode.json',
                                width: 350, fit: BoxFit.cover),
                            Text(
                              'Scan Id card to Login $userId ',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 0,
                                height: 0,
                                child: RawKeyboardListener(
                                  focusNode: FocusNode(),
                                  onKey: (event) => handleKey(event.data),
                                  child: TextField(
                                    onTap: (){
                                        SystemChannels.textInput.invokeMethod('TextInput.hide');

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
