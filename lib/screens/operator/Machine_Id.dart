import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lottie/lottie.dart';
import 'package:molex/screens/operator/Homepage.dart';

class MachineId extends StatefulWidget {
  String userId;
  MachineId({this.userId});
  @override
  _MachineIdState createState() => _MachineIdState();
}

class _MachineIdState extends State<MachineId> {
  TextEditingController _textController = new TextEditingController();
  FocusNode _textNode = new FocusNode();
  String machineId;

  @override
  void initState() {
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
                          width: 350, fit: BoxFit.cover),
                      Text(
                        'Scan Machine ',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      Container(
                        child: RawKeyboardListener(
                            focusNode: FocusNode(),
                            onKey: (event) => handleKey(event.data),
                            child: Container(
                              height: 00,
                              width: 0,
                              child: TextField(
                                onSubmitted: (value) {
                                  print("machineID:$value");
                                  Future.delayed(Duration.zero, () async {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Homepage(
                                                userId: widget.userId,
                                                machineId: value,
                                              )),
                                    );
                                  });
                                },
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
                Text(
                  widget.userId ?? '',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 26,
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
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
