import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molex/models/location_bin.dart';
import 'package:molex/screens/operator/Homepage.dart';

class Location extends StatefulWidget {
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
    _locationFocus.requestFocus();
    Future.delayed(
      const Duration(milliseconds: 100),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    super.initState();
  }

  void checkLocation(String l) {
    setState(() {
      if (l?.length == 10) {
        hasLocation = true;
        _binFocus.requestFocus();
        Future.delayed(
          const Duration(milliseconds: 50),
          () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
        );
      }
    });
  }

  void checkBin(String bi) {
    setState(() {
      if (binId?.length == 10) {
        listLocation.add(LocationBin(locationId: locationId, binId: binId));
        _binController.clear();
        binId = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkLocation(locationId);
    checkBin(binId);
    return Scaffold(
        key: _scaffoldKey1,
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: const Text('Location'),
          actions: [
            Container(
              height: 40,
              width: 150,
              child: Column(
                children: [
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "User Id",
                        style: TextStyle(color: Colors.grey[100]),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "12210",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
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
          child: Row(children: [
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 170,
                  width: 405,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 250,
                                height: 80,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: RawKeyboardListener(
                                    focusNode: FocusNode(),
                                    onKey: (event) => handleKey(event.data),
                                    child: TextFormField(
                                        focusNode: _locationFocus,
                                        autofocus: true,
                                        controller: _locationController,
                                        onTap: () {
                                          SystemChannels.textInput
                                              .invokeMethod('TextInput.hide');
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            locationId = value;
                                          });
                                        },
                                        decoration: new InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.redAccent,
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[400],
                                                  width: 2.0),
                                            ),
                                            hintText: 'Scan Bin',
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 5.0))),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red, // background
                                onPrimary: Colors.white,
                              ),
                              child: Text(
                                'Scan Location',
                              ),
                              onPressed: () {
                            
                              },
                            )),
                          ],
                        ),
                      ]),
                ),
              ),
              bin(),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.green),
                  ),
                  onPressed: () {
                       _showConfirmationDialog();
                  },
                  child: Text('Confirm Transfer'))
            ]),
            Container(child: SingleChildScrollView(child: dataTable())),
          ]),
        ));
  }

  Widget location() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: 405,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 250,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RawKeyboardListener(
                          focusNode: FocusNode(),
                          onKey: (event) => handleKey(event.data),
                          child: TextField(
                              focusNode: _locationFocus,
                              autofocus: true,
                              controller: _locationController,
                              onTap: () {
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                              },
                              onChanged: (value) {
                                setState(() {
                                  locationId = value;
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
                                  hintText: 'Scan Bin',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 5.0))),
                        ),
                      ),
                    ),
                  ),
                  Container(
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
    );
  }

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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 170,
        width: 405,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 250,
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
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
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 5.0))),
                        ),
                      ),
                    ),
                  ),
                  Container(
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
        return AlertDialog(
          title: Text('Confirm Transfer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Confirm Location Transfer')
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
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );
                },
                child: Text('Confirm Transfer')),
          ],
        );
      },
    );
  }
}
