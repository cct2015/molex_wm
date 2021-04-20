import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:molex/models/location_bin.dart';
import 'package:molex/screens/operator/Homepage.dart';

class Location extends StatefulWidget {
  String userId;
  String machineId;
  Location({this.userId, this.machineId});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();
  TextEditingController _locationController = new TextEditingController();
  TextEditingController _binController = new TextEditingController();
  FocusNode _binFocus = new FocusNode();
  FocusNode _locationFocus = new FocusNode();
  List<LocationBin> listLocation = [];

  String locationId;
  String binId;
  bool hasLocation = false;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _locationFocus.requestFocus();
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    super.initState();
  }

  void checkLocation(String l) {}

  void checkBin(String bi) {}

  @override
  Widget build(BuildContext context) {
    checkLocation(locationId);
    checkBin(binId);
    return Scaffold(
        key: _scaffoldKey1,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.red,
          ),
          title: const Text(
            'Location Transfer',
            style: TextStyle(color: Colors.red),
          ),
          elevation: 0,
          actions: [
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(
                                Icons.schedule,
                                size: 18,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              "Shift A",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black),
                            ),
                          ],
                        )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(1),
              height: 40,
             
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(
                                Icons.person,
                                size: 18,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              widget.userId,
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black),
                            ),
                          ],
                        )),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Icon(
                                Icons.settings,
                                size: 18,
                                color: Colors.redAccent,
                              ),
                            ),
                            Text(
                              widget.machineId ?? "",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black),
                            ),
                          ],
                        )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('MM-dd-yyyy').format(DateTime.now()),
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        DateFormat('hh:mm').format(DateTime.now()),
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent[100],
                        offset: const Offset(
                          2.0,
                          2.0,
                        ),
                        blurRadius: 3.0,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //Bo
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/image/profile.jpg',
                        ),
                        fit: BoxFit.fill)),
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: RawKeyboardListener(
                                              focusNode: FocusNode(),
                                              onKey: (event) =>
                                                  handleKey(event.data),
                                              child: TextField(
                                                  focusNode: _locationFocus,
                                                  autofocus: true,
                                                  controller:
                                                      _locationController,
                                                  onTap: () {
                                                    SystemChannels.textInput
                                                        .invokeMethod(
                                                            'TextInput.hide');
                                                  },
                                                  onSubmitted: (value) {
                                                    setState(() {
                                                      hasLocation = true;
                                                      _binFocus.requestFocus();
                                                      Future.delayed(
                                                        const Duration(
                                                            milliseconds: 50),
                                                        () {
                                                          SystemChannels
                                                              .textInput
                                                              .invokeMethod(
                                                                  'TextInput.hide');
                                                        },
                                                      );
                                                    });
                                                  },
                                                  onChanged: (value) {
                                                    setState(() {
                                                      locationId = value;
                                                    });
                                                  },
                                                  decoration:
                                                      new InputDecoration(
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .redAccent,
                                                                width: 2.0),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .grey[400],
                                                                width: 2.0),
                                                          ),
                                                          hintText:
                                                              'Scan Location',
                                                          contentPadding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      5.0))),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                          height: 40,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red, // background
                                              onPrimary: Colors.white,
                                            ),
                                            child: Text(
                                              'Scan Location',
                                            ),
                                            onPressed: () {},
                                          )),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                        bin(),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.green),
                                ),
                                onPressed: () {
                                  _showConfirmationDialog();
                                },
                                child: Text('Confirm Transfer')),
                          ),
                        )
                      ]),
                ),
                Container(child: SingleChildScrollView(child: dataTable())),
              ]),
        ));
  }

  // Widget location() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Container(
  //       height: 100,
  //       width: 405,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(30),
  //         color: Colors.white,
  //       ),
  //       child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Row(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(10.0),
  //                   child: Container(
  //                     width: 250,
  //                     height: 80,
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(15.0),
  //                       child: RawKeyboardListener(
  //                         focusNode: FocusNode(),
  //                         onKey: (event) => handleKey(event.data),
  //                         child: TextField(
  //                             focusNode: _locationFocus,
  //                             autofocus: true,
  //                             controller: _locationController,
  //                             onTap: () {
  //                               SystemChannels.textInput
  //                                   .invokeMethod('TextInput.hide');
  //                             },
  //                             onSubmitted: (value) {
  //                               setState(() {
  //                                 listLocation.add(LocationBin(
  //                                     locationId: locationId, binId: binId));
  //                                 _binController.clear();
  //                                 binId = null;
  //                               });
  //                             },
  //                             onChanged: (value) {
  //                               setState(() {
  //                                 binId = value;
  //                               });
  //                             },
  //                             decoration: new InputDecoration(
  //                                 focusedBorder: OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Colors.redAccent, width: 2.0),
  //                                 ),
  //                                 enabledBorder: OutlineInputBorder(
  //                                   borderSide: BorderSide(
  //                                       color: Colors.grey[400], width: 2.0),
  //                                 ),
  //                                 hintText: 'Scan Bin',
  //                                 contentPadding: const EdgeInsets.symmetric(
  //                                     horizontal: 5.0))),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                     child: ElevatedButton(
  //                   style: ElevatedButton.styleFrom(
  //                     primary: Colors.red, // background
  //                     onPrimary: Colors.white,
  //                   ),
  //                   child: Text(
  //                     'Scan Location',
  //                   ),
  //                   onPressed: () {},
  //                 )),
  //               ],
  //             ),
  //           ]),
  //     ),
  //   );
  // }

  handleKey(RawKeyEventDataAndroid key) {
    String _keyCode;
    _keyCode = key.keyCode.toString(); //keyCode of key event(66 is return )
    print("why does this run twice $_keyCode");

    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  Widget bin() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.23,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (event) => handleKey(event.data),
                      child: TextField(
                          focusNode: _binFocus,
                          controller: _binController,
                          onTap: () {
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          },
                          onSubmitted: (value){
                             setState(() {
                                  listLocation.add(LocationBin(
                                      locationId: locationId, binId: binId));
                                  _binController.clear();
                                  binId = null;
                                });
                          },
                          onChanged: (value) {
                            setState(() {
                              binId = value;
                            });
                          },
                          decoration: new InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[400], width: 2.0),
                              ),
                              hintText: 'Scan bin',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 5.0))),
                    ),
                  ),
                ),
              ),
              Container(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white,
                    ),
                    child: Text(
                      'Scan Bin',
                    ),
                    onPressed: () {},
                  )),
            ],
          ),
        ]),
      ),
    );
  }

  Widget locationdisplay(String loc) {
    return Container(
        height: 150,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Center(
          child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      color: Colors.white,
                      width: 250,
                      height: 40,
                      child: Center(
                          child: Text('Location ID',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                              ))),
                    )),
                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      color: Colors.white,
                      width: 250,
                      height: 50,
                      child: Center(
                          child: Text(loc,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                  color: Colors.green))),
                    ))
              ]),
        ));
  }

  Widget dataTable() {
    int a = 1;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          DataTable(
            columnSpacing: 30,
              columns: const <DataColumn>[
                DataColumn(
                  label: Text('No.'),
                ),
                DataColumn(
                  label: Text('Location Id'),
                ),
                DataColumn(
                  label: Text('Bin Id'),
                ),
                DataColumn(
                  label: Text('Remove'),
                ),
              ],
              rows: listLocation
                  .map(
                    (e) => DataRow(cells: <DataCell>[
                      DataCell(Text("${a++}")),
                      DataCell(Text(e.locationId)),
                      DataCell(Text(e.binId)),
                      DataCell(
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              listLocation.remove(e);
                            });
                          },
                        ),
                      ),
                    ]),
                  )
                  .toList())
        ],
      ),
    );
  }

  Future<void> _showConfirmationDialog() async {
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    return showDialog<void>(
      context: _scaffoldKey1.currentContext,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            title: Center(child: Text('Confirm Transfer')),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(child: Text('Confirm Location Transfer'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.redAccent),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Future.delayed(
                      const Duration(milliseconds: 50),
                      () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      },
                    );
                  },
                  child: Text('Cancel Transfer')),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.green),
                  ),
                  onPressed: () {
                    Future.delayed(
                      const Duration(milliseconds: 50),
                      () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      },
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Homepage(
                                userId: widget.userId,
                                machineId: widget.machineId,
                              )),
                    );
                  },
                  child: Text('Confirm Transfer')),
            ],
          ),
        );
      },
    );
  }
}
