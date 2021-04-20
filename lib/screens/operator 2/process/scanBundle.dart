import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molex/models/bundle_scan.dart';
import 'package:molex/screens/operator/bin.dart';

class ScanBundle extends StatefulWidget {
  int length;
  String userId;
  String machineId;
  ScanBundle({this.length, this.machineId, this.userId});
  @override
  _ScanBundleState createState() => _ScanBundleState();
}

class _ScanBundleState extends State<ScanBundle> {
    FocusNode _scanfocus = new FocusNode();
    TextEditingController _scanIdController = new TextEditingController();
  bool next = false;
  bool showTable = false;
    List<BundleScan> bundleScan = [];
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 10),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
    return !next ? scanBundlePop() : rejectioncase();
  }

  Widget rejectioncase() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text('Crimping Rejection Cases',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ))
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                quantitycell("Terminal Damage", 10),
                                quantitycell("Window Gap	", 10),
                                quantitycell("Cut-off Burr", 10),
                                quantitycell("Terminal Copper Mark", 10),
                              ],
                            ),
                            Column(
                              children: [
                                quantitycell("Terminal Bend	", 10),
                                quantitycell("Crimp On Insulation	", 10),
                                quantitycell("Cut-off Bend	", 10),
                                quantitycell("Setup Rejections", 10),
                              ],
                            ),
                            Column(
                              children: [
                                quantitycell("Conductor Curling Up & Down", 10),
                                quantitycell("Tab Bend / Tap Open	", 10),
                                quantitycell("Exposure Strands		", 10),
                                quantitycell("Insulation Curling Up & Down", 10),
                              ],
                            ),
                            Column(
                              children: [
                                quantitycell("Terminal Twist", 10),
                                quantitycell("Improper Crimping", 10),
                                quantitycell("Insulation Damage	", 10),
                                quantitycell("Terminal Back Out", 10),
                              ],
                            ),
                            Column(
                              children: [
                                quantitycell("Bellmouth Less / More", 10),
                                quantitycell("Strands Cut", 10),
                                quantitycell("Terminal Changeover", 10),
                                quantitycell("Terminal Twist", 10),
                              ],
                            ),
                            Column(
                              children: [
                                quantitycell("CFM Error", 10),
                                quantitycell("Supplier Taken for Maintenance", 10),
                                quantitycell("Roller Changeover	", 10),
                                quantitycell("Conductor Burr	", 10),
                              ],
                            ),
                            Column(
                              children: [
                                quantitycell("Cut-Off Less / More	", 10),
                                quantitycell("Brush Length Less / More", 10),
                                quantitycell("Roller Changeover	", 10),
                                quantitycell("Strands Cut", 10),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        quantity("Bundle Qty", 10),
                        quantity("Passed Qty", 10),
                        quantity("Rejected Qty", 10),
                        Container(
                          height: 50,
                          child: Center(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                          side:
                                              BorderSide(color: Colors.transparent))),
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.pressed))
                                        return Colors.green[200];
                                      return Colors
                                          .green[500]; // Use the component's default.
                                    },
                                  ),
                                ),
                                child: Text("Save & Scan Next"),
                                onPressed: () {
                                  next = !next;
                                    setState(() {
                                                bundleScan.add(BundleScan(
                                                    bundleId: _scanIdController.text,
                                                    bundleProcessQty: "30",
                                                    bundleQty: "100"));
                                                _scanIdController.clear();
                                              });
                                  Future.delayed(
                                    const Duration(milliseconds: 10),
                                    () {
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                    },
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
   Widget scanedTable() {
    if (showTable) {
      return DataTable(
          columnSpacing: 10,
          columns: const <DataColumn>[
            DataColumn(
              label: Text('S No.'),
            ),
            DataColumn(
              label: Text('Bundle Id'),
            ),
            DataColumn(
              label: Text('Bundle Qty'),
            ),
            DataColumn(
              label: Text('Process Qty'),
            ),
            DataColumn(
              label: Text('Remove'),
            ),
          ],
          rows: bundleScan
              .map((e) => DataRow(cells: <DataCell>[
                    DataCell(Text("1")),
                    DataCell(Text(
                      e.bundleId,
                    )),
                    DataCell(Text(
                      e.bundleQty,
                    )),
                    DataCell(Text(
                      e.bundleProcessQty,
                    )),
                    DataCell(IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        bundleScan.remove(e);
                      },
                    )),
                  ]))
              .toList());
    } else {
      return Container();
    }
  }


  Widget scanBundlePop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 300,
            height: 100,
            child: Column(
              children: [
                Container(
                  height: 40,
                  width: 200,
                  child: RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (event) => handleKey(event.data),
                    child: TextField(
                      controller: _scanIdController,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(fontSize: 14),
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 3),
                        labelText: "Scan Bundle",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.redAccent),
                        ),
                        onPressed: () {
                          setState(() {
                            next = !next;
                          });
                        },
                        child: Text('Scan Bundle  ')),
                    SizedBox(width: 5),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.green),
                        ),
                        onPressed: () {
                          showTable =!showTable;
                        },
                        child: Text("${bundleScan.length}") ),
                  ],
                ),
              ],
            )),
            scanedTable(),
      ],
    );
  }

  Widget quantitycell(String title, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.25 * 0.6,
            //   child: Text(title,
            //       style: TextStyle(
            //         fontWeight: FontWeight.w400,
            //         fontSize: 10,
            //       )),
            // ),
            Container(
                height: 30,
                width: 150,
                child: TextField(
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  style: TextStyle(fontSize: 12),
                  keyboardType: TextInputType.textscan,
                  decoration: new InputDecoration(
                    labelText: title,
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

  Widget quantity(String title, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.25 * 0.4,
            //   child: Text(title,
            //       style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //         fontSize: 15,
            //       )),
            // ),
            Container(
              height: 35,
              width: 150,
              child: TextField(
                style: TextStyle(fontSize: 12),
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: title,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 15),
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

  handleKey(RawKeyEventDataAndroid key) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
