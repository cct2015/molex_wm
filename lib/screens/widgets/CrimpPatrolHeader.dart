import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CrimpPatrolHeader extends StatefulWidget {
  @override
  _CrimpPatrolHeaderState createState() => _CrimpPatrolHeaderState();
}

class _CrimpPatrolHeaderState extends State<CrimpPatrolHeader> {
  TextEditingController _scanPatrolIdController = new TextEditingController();

  TextEditingController _qaApprovalController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        new TextEditingController().clear();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: [
                    feild(heading: "FG number", value: "12346789", width: 0.18),
                    feild(
                        heading: "Order Number",
                        value: "12346789",
                        width: 0.18),
                    feild(
                        heading: "Operator Id", value: "12346789", width: 0.18),
                    feild(heading: "AWG", value: "12346789", width: 0.18),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                            value: 1,
                            groupValue: 1,
                            onChanged: (a) {
                              print('value $a');
                            },
                          ),
                          Text('SC'),
                          Radio(
                            value: 2,
                            groupValue: 1,
                            onChanged: (a) {
                              print('value $a');
                            },
                          ),
                          Text('DC')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: [
                    feild(
                        heading: "Terminal No", value: "12346789", width: 0.18),
                    feild(
                        heading: "Material Tracking No",
                        value: "12346789",
                        width: 0.18),
                    feild(
                        heading: "Material Tracking",
                        value: "12346789",
                        width: 0.18),
                    feild(
                        heading: "Retention From Spec",
                        value: "12346789",
                        width: 0.18),
                    feild(
                        heading: "Applicator No",
                        value: "12346789",
                        width: 0.18),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: [
                    feild(
                        heading: "Cut Off Spec",
                        value: "12346789",
                        width: 0.18),
                    feild(
                        heading: "Crimp Height Spec",
                        value: "12346789",
                        width: 0.18),
                    scanpartolId(),
                    qaApprovalId()
                  ],
                ),
              ),
            )
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
                    fontSize: 12,
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
                  Container(
                      width: 160,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.grey[100],
                      ),
                      child: Center(
                        child: TextField(
                          decoration: new InputDecoration(
                            hintText: heading,
                            hintStyle: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 5),
                            fillColor: Colors.white,
                          ),
                        ),
                      ))
                  // Text(
                  //   value ?? '',
                  //   style: GoogleFonts.poppins(
                  //     textStyle:
                  //         TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  handleKey(RawKeyEventDataAndroid key) {
    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  Widget scanpartolId() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            width: 220,
            height: 45,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => handleKey(event.data),
                child: TextField(
                    controller: _scanPatrolIdController,
                    onSubmitted: (value) {
                      Future.delayed(
                        const Duration(milliseconds: 50),
                        () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                      );
                    },
                    onTap: () {
                      _scanPatrolIdController.clear();
                      setState(() {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      });
                    },
                    onChanged: (value) {},
                    decoration: new InputDecoration(
                        suffix: _scanPatrolIdController.text.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _scanPatrolIdController.clear();
                                  });
                                },
                                child: Icon(Icons.clear,
                                    size: 18, color: Colors.red))
                            : Container(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[400], width: 2.0),
                        ),
                        labelText: 'Scan Patrol Id',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5.0))),
              ),
            ),
          ),
          //Scan Bin Button
        ],
      ),
    );
  }

  Widget qaApprovalId() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            width: 220,
            height: 45,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: (event) => handleKey(event.data),
                child: TextField(
                    controller: _qaApprovalController,
                    onSubmitted: (value) {
                      Future.delayed(
                        const Duration(milliseconds: 50),
                        () {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                        },
                      );
                    },
                    onTap: () {
                      _qaApprovalController.clear();
                      setState(() {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      });
                    },
                    onChanged: (value) {},
                    decoration: new InputDecoration(
                        suffix: _qaApprovalController.text.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _scanPatrolIdController.clear();
                                  });
                                },
                                child: Icon(Icons.clear,
                                    size: 18, color: Colors.red))
                            : Container(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[400], width: 2.0),
                        ),
                        labelText: 'QA Approval ID',
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 5.0))),
              ),
            ),
          ),
          //Scan Bin Button
        ],
      ),
    );
  }
}
