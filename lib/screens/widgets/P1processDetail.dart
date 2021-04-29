//Fot terminal the three boxes below the order detail in work in progress page
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/model_api/cableDetails_model.dart';
import 'package:molex/model_api/cableTerminalA_model.dart';
import 'package:molex/model_api/cableTerminalB_model.dart';
import 'package:molex/service/apiService.dart';

class P1ProcessDetail extends StatefulWidget {
  String fgpartNo;
  String cablePartNo;
  P1ProcessDetail({this.cablePartNo, this.fgpartNo});
  @override
  _P1ProcessDetailState createState() => _P1ProcessDetailState();
}

class _P1ProcessDetailState extends State<P1ProcessDetail> {
  ApiService apiService;
  @override
  void initState() {
    apiService = new ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [fromProcess(), cable(), toProcess()],
      ),
    );
  }

  Widget feild({String heading, String value, double width}) {
    width = MediaQuery.of(context).size.width * width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
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
                    fontSize: 9,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.normal,
                  )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0),
              child: Row(
                children: [
                  Text(
                    value ?? '',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
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

  // For the first box which contain process
  Widget fromProcess() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: FutureBuilder(
          future: apiService.getCableTerminalA(cablepartno: widget.fgpartNo),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              CableTerminalA cableTerminalA = snapshot.data;
              return Material(
                elevation: 10,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 04.0, vertical: 3),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'From Process',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            feild(heading: "Process", value: "SC", width: 0.05),
                            feild(
                                heading: "Strip Length",
                                value: "${cableTerminalA.stripLength}",
                                width: 0.08),
                            feild(
                                heading: "Terminal Part#",
                                value: "${cableTerminalA.terminalPart}",
                                width: 0.1),
                            feild(
                                heading: "Crimp Height",
                                value: "${cableTerminalA.specCrimpLength}",
                                width: 0.08),
                            feild(
                                heading: "Pull Force",
                                value: "${cableTerminalA.pullforce}",
                                width: 0.06),
                          ],
                        ),
                        Row(
                          children: [
                            feild(
                                heading: "Comment",
                                value: "${cableTerminalA.comment}",
                                width: 0.35),
                          ],
                        ),

                        // Text(
                        //     'Process(Strip Length)(Terminal Part#)Spec-(Crimp Height)(Pull Force)(Cmt)'),
                        // Text(
                        //     '(${cableTerminalA.processType})(${cableTerminalA.stripLength})(${cableTerminalA.terminalPart})(${cableTerminalA.specCrimpLength})(${cableTerminalA.pullforce})(${cableTerminalA.comment})')
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  //Cable Detail
  Widget cable() {
    return FutureBuilder(
        future: apiService.getCableDetails(
            fgpartNo: widget.fgpartNo, cablepartno: widget.cablePartNo),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CableDetails cableDetails = snapshot.data;
            return Material(
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 3),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.26,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Cable',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          feild(heading: "Process", value: "SC", width: 0.06),
                          feild(
                              heading: "Cable Part No",
                              value: "${cableDetails.cablePartNumber}",
                              width: 0.09),
                          feild(
                              heading: "Cut Length",
                              value: "${cableDetails.cutLengthSpec}",
                              width: 0.09),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          feild(
                              heading: "From Strip Length",
                              value: "${cableDetails.stripLengthFrom}",
                              width: 0.12),
                          feild(
                              heading: "To Strip Length",
                              value: "${cableDetails.stripLengthTo}",
                              width: 0.12),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  // To process Box
  Widget toProcess() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: FutureBuilder(
          future: apiService.getCableTerminalB(cablepartno: widget.fgpartNo),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              CableTerminalB cableTerminalB = snapshot.data;
              return Material(
                elevation: 10,
                color: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'To Process',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            feild(heading: "Process", value: "SC", width: 0.05),
                            feild(
                                heading: "Strip Length",
                                value: "${cableTerminalB.stripLength}",
                                width: 0.07),
                            feild(
                                heading: "Terminal Part#",
                                value: "${cableTerminalB.terminalPart}",
                                width: 0.08),
                            feild(
                                heading: "Crimp Height",
                                value: "${cableTerminalB.specCrimpLength}",
                                width: 0.08),
                          ],
                        ),
                        Row(
                          children: [
                            feild(
                                heading: "Pull Force",
                                value: "${cableTerminalB.pullforce}",
                                width: 0.06),
                            feild(
                                heading: "Comment",
                                value: "${cableTerminalB.comment}",
                                width: 0.25),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
