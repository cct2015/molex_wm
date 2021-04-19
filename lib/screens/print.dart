import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PrintTest extends StatefulWidget {
  @override
  _PrintTestState createState() => _PrintTestState();
}

class _PrintTestState extends State<PrintTest> {
  String ipaddress;
  String bundleQty;
  String qr;
  String routenumber1;
  String fgpartNumber;
  String cutlength;
  String cablepart;
  String wireGauge;
  String terminalfrom;
  String terminalto;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Column(
                children: [
                  // IP address
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          ipaddress = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "IP address ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  // QR Code
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          qr = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "QR Code ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          bundleQty = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "Bundle Qty",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                  //Route No.
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          routenumber1 = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "Route No.",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                  //fg number
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          fgpartNumber = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "FG Part No.",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                  // cut length
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          cutlength = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "Cut length",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                  // cable part
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          cablepart = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "Cable Part",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),

                  //wiregauge
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          wireGauge = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "Wire gauge",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          terminalfrom = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "Terminal P/N \"From\"",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 40,
                    width: 200,
                    child: TextField(
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          terminalto = value;
                        });
                      },
                      decoration: new InputDecoration(
                        labelText: "TERMINAL P/N \"TO\"",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _print(
            ipaddress: ipaddress,
            qr: qr,
            bq: bundleQty,
            routenumber1: routenumber1,
            fgPartNumber: fgpartNumber,
            cutlength: cutlength,
            cablepart: cablepart,
            wireGauge: wireGauge,
            terminalfrom: terminalfrom,
            terminalto: terminalto,
          );
        },
        child: Icon(Icons.print),
      ),
    );
  }
}
