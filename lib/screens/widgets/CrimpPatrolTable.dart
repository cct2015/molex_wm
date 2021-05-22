import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CrimpPatrolTable extends StatefulWidget {
  @override
  _CrimpPatrolTableState createState() => _CrimpPatrolTableState();
}

class _CrimpPatrolTableState extends State<CrimpPatrolTable> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      child: Column(
        children: [
          header(),
         TableContent()
        ],
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text('Characteristics')),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                children: [
                  Text('FP'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('OK'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('NOT OK'),
                      ),
                    ],
                  )
                ],
              )),
          Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                children: [
                  Text('LP'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('OK'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('NOT OK'),
                      ),
                    ],
                  )
                ],
              )),
          Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                children: [
                  Text('P'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('OK'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('NOT OK'),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class TableContent extends StatefulWidget {
  @override
  _TableContentState createState() => _TableContentState();
}

class _TableContentState extends State<TableContent> {
  int crimpOnInsulationFP = 0;
  int crimpOnInsulationLP = 0;
  int crimpOnInsulationP = 0;
  TimeOfDay initialTime1 = TimeOfDay.now();
  TimeOfDay initialTime2 = TimeOfDay.now();
  TimeOfDay initialTime3 = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            TableItem(
              context: context,
              name: 'Crimp On Insulation',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Window Gap',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Exposed Strands',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'BURR On Cut Off',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'TAB Bent / Closed',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Terminal Cantiliver Bend',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Terminal Damage',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Terminal Damage',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Cutt Off Ofset',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Insulation Curling',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Conductor Curling',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'BEll Mouth At Insulation Area',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Bend Angle Up/Down',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Check For Stopper',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Set Air Pressure',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Wire Color',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'EXTRUSION BURR-FOR MINIATURE TERMINAL',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name:
                  'CHECK FOR CRIMP HT NUT, CRIMP SHUT HT NUT,& SHANK HOLDER NUT ARE TIGHTENED',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            TableItem(
              context: context,
              name: 'Check For Stopper',
              valueFP: crimpOnInsulationFP,
              valueLP: crimpOnInsulationLP,
              valueP: crimpOnInsulationP,
            ),
            timePicker('Time'),
            fieldsItem(
                name: "CONDUCTOR CRIMP HEIGHT (CCH)(MICROMETER)",
                fiels1: "",
                fiels2: "",
                fiels3: ""),
            fieldsItem(
                name: "INSULATION CRIMP HEIGHT (CH)(VERINIER)",
                fiels1: "",
                fiels2: "",
                fiels3: ""),
            fieldsItem(
                name: "CONDUCTOR CRIMP WIDTH - CCW ",
                fiels1: "",
                fiels2: "",
                fiels3: ""),
            fieldsItem(
                name:
                    "INSULATION CRIMP WIDTH -( CRIMP WIDTH - ICW (MAGNA, VENTRA & GM",
                fiels1: "",
                fiels2: "",
                fiels3: ""),
            fieldsItem(name: "CUT OFF                      \n                                      ", fiels1: "", fiels2: "", fiels3: ""),
            fieldsItem(
                name: "CROSS SECTION\n", fiels1: "", fiels2: "", fiels3: ""),
            fieldsItem(name: "PULL FORCE\n", fiels1: "", fiels2: "", fiels3: ""),
            SizedBox(height:50),
          ],
        ),
      ),
    );
  }

  Widget timePicker(String name) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text('$name')),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.more_time_outlined, size: 35),
                  onPressed: () async {
                    TimeOfDay pickedTime = initialTime1;

                    initialTime1 = await showTimePicker(
                      context: context,
                      initialTime: initialTime1,
                    );
                    FocusScope.of(context).unfocus();
                  },
                ),
                Text(
                  initialTime1.hour.toString() +
                      ":" +
                      initialTime1.minute.toString(),
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.more_time_outlined, size: 35),
                  onPressed: () async {
                    TimeOfDay pickedTime = initialTime2;

                    initialTime2 = await showTimePicker(
                      context: context,
                      initialTime: initialTime2,
                    );
                    FocusScope.of(context).unfocus();
                  },
                ),
                Text(
                  initialTime2.hour.toString() +
                      ":" +
                      initialTime2.minute.toString(),
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.more_time_outlined, size: 35),
                  onPressed: () async {
                    TimeOfDay pickedTime = initialTime1;

                    initialTime3 = await showTimePicker(
                      context: context,
                      initialTime: initialTime3,
                    );
                    Future.delayed(
                      const Duration(milliseconds: 10),
                      () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      },
                    );
                    FocusScope.of(context).unfocus();
                  },
                ),
                Text(
                  initialTime3.hour.toString() +
                      ":" +
                      initialTime3.minute.toString(),
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldsItem( 
      {String name, String fiels1, String fiels2, String fiels3}) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text('$name')),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                                hintText: '$fiels1',
                                hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
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
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                                hintText: '$fiels2',
                                hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
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
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                                hintText: '$fiels3',
                                hintStyle: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
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
        ],
      ),
    );
  }
}

class TableItem extends StatefulWidget {
  TableItem({
    Key key,
    @required this.context,
    this.name,
    this.valueFP,
    this.valueLP,
    this.valueP,
  }) : super(key: key);

  final BuildContext context;
  String name;
  int valueFP;
  int valueLP;
  int valueP;

  @override
  _TableItemState createState() => _TableItemState();
}

class _TableItemState extends State<TableItem> {
  onChangedFP(int chg) {
    setState(() {
      widget.valueFP = chg;
    });
  }

  onChangedLP(int chg) {
    setState(() {
      widget.valueLP = chg;
    });
  }

  onChangedP(int chg) {
    setState(() {
      widget.valueP = chg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text('${widget.name}')),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: widget.valueFP,
                  onChanged: (a) {
                    print('value $a');
                    onChangedFP(a);
                  },
                ),
                Radio(
                  value: 2,
                  groupValue: widget.valueFP,
                  onChanged: (a) {
                    onChangedFP(a);
                    print('value $a');
                  },
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: widget.valueLP,
                  onChanged: (a) {
                    onChangedLP(a);
                  },
                ),
                Radio(
                  value: 2,
                  groupValue: widget.valueLP,
                  onChanged: (a) {
                    onChangedLP(a);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 1,
                  groupValue: widget.valueP,
                  onChanged: (a) {
                    onChangedP(a);
                  },
                ),
                Radio(
                  value: 2,
                  groupValue: widget.valueP,
                  onChanged: (a) {
                    onChangedP(a);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
