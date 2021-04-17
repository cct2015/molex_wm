import 'package:flutter/material.dart';

class GenerateLabel extends StatefulWidget {
  @override
  _GenerateLabelState createState() => _GenerateLabelState();
}

class _GenerateLabelState extends State<GenerateLabel> {
  TextEditingController bundleQty = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        generateLabel(),
        keypad(),
      ],
    );
  }

  Widget keypad() {
    buttonPressed(String buttonText) {
      // if (buttonText == 'clear') {
      //   _output = '';
      // } else {
      //   _output = _output + buttonText;
      // }

      // print(_output);
      // setState(() {
      //   _qtyController.text = _output;
      //   output = int.parse(_output).toStringAsFixed(2);
      // });
    }

    Widget buildbutton(String buttonText) {
      return new Expanded(
          child: new OutlineButton(
        padding: EdgeInsets.all(12.0),
        child: new Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        onPressed: () => {buttonPressed(buttonText)},
        textColor: Colors.black,
      ));
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      height: 193,
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
              buildbutton('clear'),
            ],
          ),
        ],
      ),
    );
  }

  Widget generateLabel() {
    return Container(
      width: MediaQuery.of(context).size.width*0.75,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 50,
            child: TextField(
              textAlign: TextAlign.center,
              controller: bundleQty,
              keyboardType: TextInputType.number,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(fontSize: 12),
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 3),
                labelText: "Bundle Qty (SPQ)",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: new BorderSide(),
                ),
                //fillColor: Colors.green
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           width: MediaQuery.of(context).size.width * 0.25,
//                           height: 480,
//                           child: Column(
//                             children: [
//                               //keypad and button
//                               Row(
//                                 children: [
//                                   Container(
//                                     height: 193,
//                                     child: Center(child: keypad()),
//                                   ),
//                                 ],
//                               ),
//                               //buttons column
//                               Padding(
//                                 padding: const EdgeInsets.all(1.0),
//                                 child: Container(
//                                   height: 100,
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       //100% complete
//                                       Container(
//                                         height: 40,
//                                         width: 250,
//                                         child: ElevatedButton(
//                                           style: ButtonStyle(
//                                             shape: MaterialStateProperty.all<
//                                                     RoundedRectangleBorder>(
//                                                 RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20.0),
//                                                     side: BorderSide(
//                                                         color: Colors
//                                                             .transparent))),
//                                             backgroundColor:
//                                                 MaterialStateProperty
//                                                     .resolveWith<Color>(
//                                               (Set<MaterialState> states) {
//                                                 if (states.contains(
//                                                     MaterialState.pressed))
//                                                   return Colors.green[200];
//                                                 return Colors.green[
//                                                     500]; // Use the component's default.
//                                               },
//                                             ),
//                                           ),
//                                           onPressed: () {
//                                             setState(() {
//                                               rightside = 'complete';
//                                             });
//                                             // showModalBottomSheet(
//                                             //     isScrollControlled: true,
//                                             //     context: context,
//                                             //     builder: (BuildContext context) {
//                                             //       return productionReport();
//                                             //     });
//                                           },
//                                           child: Text(
//                                             "100% complete",
//                                             style: TextStyle(
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.normal,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       //Partially complete button
//                                       Row(
//                                         children: [
//                                           Container(
//                                             height: 40,
//                                             width: 125,
//                                             child: ElevatedButton(
//                                               style: ButtonStyle(
//                                                 shape: MaterialStateProperty.all<
//                                                         RoundedRectangleBorder>(
//                                                     RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(20.0),
//                                                         side: BorderSide(
//                                                             color: Colors
//                                                                 .transparent))),
//                                                 backgroundColor:
//                                                     MaterialStateProperty
//                                                         .resolveWith<Color>(
//                                                   (Set<MaterialState> states) {
//                                                     if (states.contains(
//                                                         MaterialState.pressed))
//                                                       return Colors.green[200];
//                                                     return Colors.red[
//                                                         500]; // Use the component's default.
//                                                   },
//                                                 ),
//                                               ),
//                                               onPressed: () {
//                                                 setState(() {
//                                                   rightside = "partial";
//                                                 });
//                                                 // showModalBottomSheet(
//                                                 //     isScrollControlled: true,
//                                                 //     context: context,
//                                                 //     builder: (BuildContext context) {
//                                                 //       return partialCompletion();
//                                                 //     });
//                                               },
//                                               child: Text(
//                                                 "Partially  complete",
//                                                 style: TextStyle(
//                                                   fontSize: 10,
//                                                   fontWeight: FontWeight.normal,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 40,
//                                             width: 110,
//                                             child: ElevatedButton(
//                                                 style: ButtonStyle(
//                                                   shape: MaterialStateProperty.all<
//                                                           RoundedRectangleBorder>(
//                                                       RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       20.0),
//                                                           side: BorderSide(
//                                                               color: Colors
//                                                                   .transparent))),
//                                                   backgroundColor:
//                                                       MaterialStateProperty
//                                                           .resolveWith<Color>(
//                                                     (Set<MaterialState>
//                                                         states) {
//                                                       if (states.contains(
//                                                           MaterialState
//                                                               .pressed))
//                                                         return Colors
//                                                             .green[200];
//                                                       return Colors.blue[
//                                                           500]; // Use the component's default.
//                                                     },
//                                                   ),
//                                                 ),
//                                                 child: Text(
//                                                   'Reload Material',
//                                                   style: TextStyle(
//                                                     fontSize: 10,
//                                                     fontWeight:
//                                                         FontWeight.normal,
//                                                   ),
//                                                 ),
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 }),
//                                           ),
//                                         ],
//                                       ),
//                                       //Relaod Material
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
// Container(
//     width: MediaQuery.of(context).size.width * 0.18,
//     child: Row(
//       children: [
//         Column(
//           children: [
//             //text input
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(0.0),
//                   child: Container(
//                     width:
//                         MediaQuery.of(context).size.width *
//                             0.18,
//                     height: 40,
//                     child: Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: TextField(
//                         textAlign: TextAlign.center,
//                         controller: _qtyController,
//                         keyboardType: TextInputType.number,
//                         textAlignVertical:
//                             TextAlignVertical.center,
//                         style: TextStyle(fontSize: 12),
//                         decoration: new InputDecoration(
//                           contentPadding:
//                               EdgeInsets.symmetric(
//                                   horizontal: 3),
//                           labelText: "Bundle Qty (SPQ)",
//                           fillColor: Colors.white,
//                           border: new OutlineInputBorder(
//                             borderRadius:
//                                 new BorderRadius.circular(
//                                     5.0),
//                             borderSide: new BorderSide(),
//                           ),
//                           //fillColor: Colors.green
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // bundle and generate label button
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     child: Row(
//                       children: [
//                         //Generate Label
//                         Container(
//                           height: 40,
//                           width: MediaQuery.of(context)
//                                   .size
//                                   .width *
//                               0.12,
//                           padding:
//                               const EdgeInsets.all(0.0),
//                           child: Container(
//                             color: Colors.transparent,
//                             child: ElevatedButton(
//                                 style: ButtonStyle(
//                                   shape: MaterialStateProperty.all<
//                                           RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius
//                                                   .circular(
//                                                       20.0),
//                                           side: BorderSide(
//                                               color: Colors
//                                                   .transparent))),
//                                   backgroundColor:
//                                       MaterialStateProperty
//                                           .resolveWith<
//                                               Color>(
//                                     (Set<MaterialState>
//                                         states) {
//                                       if (states.contains(
//                                           MaterialState
//                                               .pressed))
//                                         return Colors
//                                             .green[200];
//                                       return Colors.green[
//                                           500]; // Use the component's default.
//                                     },
//                                   ),
//                                 ),
//                                 // style: ButtonStyle(
//                                 //   elevation: ,
//                                 //   backgroundColor: MaterialStateProperty
//                                 //       .resolveWith<Color>(
//                                 //     (Set<MaterialState> states) {
//                                 //       if (states
//                                 //           .contains(MaterialState.pressed))
//                                 //         return Colors.green[200];
//                                 //       return Colors.green[
//                                 //           500]; // Use the component's default.
//                                 //     },
//                                 //   ),
//                                 // ),
//                                 child: Text(
//                                   'Generate Label',
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     fontWeight:
//                                         FontWeight.normal,
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     rightside = "label";
//                                   });
//                                   // showModalBottomSheet(
//                                   //     isScrollControlled:
//                                   //         true,
//                                   //     context: context,
//                                   //     builder: (BuildContext
//                                   //         context) {
//                                   //       return tab2();
//                                   //     });
//                                 }),
//                           ),
//                         ),
//                         SizedBox(width: 0),
//                         //bundel button
//                         Padding(
//                           padding:
//                               const EdgeInsets.all(5.0),
//                           child: Container(
//                             height: 40,
//                             width: MediaQuery.of(context)
//                                     .size
//                                     .width *
//                                 0.04,
//                             child: ElevatedButton(
//                                 style: ButtonStyle(
//                                   shape: MaterialStateProperty
//                                       .all<
//                                           RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius
//                                               .circular(
//                                                   20.0),
//                                       side: BorderSide(
//                                           color: Colors
//                                               .transparent),
//                                     ),
//                                   ),
//                                   backgroundColor:
//                                       MaterialStateProperty
//                                           .resolveWith<
//                                               Color>(
//                                     (Set<MaterialState>
//                                         states) {
//                                       if (states.contains(
//                                           MaterialState
//                                               .pressed))
//                                         return Colors
//                                             .green[200];
//                                       return Colors.red[
//                                           500]; // Use the component's default.
//                                     },
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     rightside = "bundle";
//                                   });
//                                 },
//                                 child: Text(
//                                   bundlePrint.length
//                                       .toString(),
//                                   style: TextStyle(
//                                       fontSize: 11),
//                                 )),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     )),
