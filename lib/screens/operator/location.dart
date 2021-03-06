import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/model_api/Transfer/binToLocation_model.dart';
import 'package:molex/model_api/Transfer/getBinDetail.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/screens/Preparation/preparationDash.dart';
import 'package:molex/screens/operator%202/Home_0p2.dart';
import 'package:molex/screens/operator/Homepage.dart';
import 'package:molex/screens/visual%20Inspector/Home_visual_inspector.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';

class Location extends StatefulWidget {
  String userId;
  MachineDetails machine;
  String type;
  Location({this.userId, this.machine, this.type});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();
  TextEditingController _locationController = new TextEditingController();
  TextEditingController _binController = new TextEditingController();
  FocusNode _binFocus = new FocusNode();
  FocusNode _locationFocus = new FocusNode();
  List<TransferBinToLocation> transferList = [];

  String locationId;
  String binId;
  bool hasLocation = false;
  ApiService apiService = new ApiService();
  @override
  void initState() {
    apiService = new ApiService();
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

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
        key: _scaffoldKey1,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.red,
          ),
          title: Text(
            'Location Transfer',
            style:
                GoogleFonts.openSans(textStyle: TextStyle(color: Colors.red)),
          ),
          elevation: 0,
          actions: [
            //machineID
            Container(
              padding: EdgeInsets.all(1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
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
                              widget.machine.machineNumber ?? "",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      fontSize: 13, color: Colors.black)),
                            ),
                          ],
                        )),
                      ),
                    ],
                  )
                ],
              ),
            ),

            TimeDisplay(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
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
                        location(),
                        bin(),
                        confirmTransfer(),
                        completeTransfer(),
                      ]),
                ),
                Container(child: SingleChildScrollView(child: dataTable())),
              ]),
        ));
  }

  handleKey(RawKeyEventDataAndroid key) {
    setState(() {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  Widget location() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
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
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
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
                            onSubmitted: (value) {},
                            onChanged: (value) {
                              setState(() {
                                locationId = value;
                              });
                            },
                            decoration: new InputDecoration(
                                suffix: _locationController.text.length > 1
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _locationController.clear();
                                          });
                                        },
                                        child: Icon(Icons.clear,
                                            size: 18, color: Colors.red))
                                    : Container(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.redAccent, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[400], width: 2.0),
                                ),
                                labelText: 'Scan Location',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 5.0))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }

  Widget confirmTransfer() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.23,
        child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.green),
            ),
            onPressed: () {
              ApiService apiService = new ApiService();
              apiService.getBundlesinBin(binId).then((value) {
                if (value != null) {
                  for (BundleDetail bundle in value) {
                    setState(() {
                      transferList.add(TransferBinToLocation(
                          userId: widget.userId,
                          binIdentification: binId,
                          bundleId: bundle.bundleIdentification,
                          locationId: locationId));
                    });
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: "Invalid Bin Id",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              });

              // setState(() {
              //   _binController.clear();
              //   binId = null;
              // });
            },
            child: Text('Transfer')),
      ),
    );
  }

  Widget completeTransfer() {
    return transferList.length > 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.23,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.green),
                  ),
                  onPressed: () {
                    _showConfirmationDialog();
                  },
                  child: Text('Complete Transfer')),
            ),
          )
        : Container();
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
                            setState(() {
                              _binController.clear();
                              binId = null;
                            });
                          },
                          onSubmitted: (value) {},
                          onChanged: (value) {
                            setState(() {
                              binId = value;
                            });
                          },
                          decoration: new InputDecoration(
                              suffix: _binController.text.length > 1
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _binController.clear();
                                        });
                                      },
                                      child: Icon(Icons.clear,
                                          size: 18, color: Colors.red))
                                  : Container(
                                      height: 1,
                                      width: 1,
                                    ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[400], width: 2.0),
                              ),
                              labelText: 'Scan bin',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 5.0))),
                    ),
                  ),
                ),
              ),
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
              columnSpacing: 40,
              columns: <DataColumn>[
                DataColumn(
                  label: Text('No.',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(fontWeight: FontWeight.w600))),
                ),
                DataColumn(
                  label: Text('Location Id',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(fontWeight: FontWeight.w600))),
                ),
                DataColumn(
                  label: Text('Bin Id',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(fontWeight: FontWeight.w600))),
                ),
                DataColumn(
                  label: Text('Bundles',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(fontWeight: FontWeight.w600))),
                ),
                DataColumn(
                  label: Text('Remove',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(fontWeight: FontWeight.w600))),
                ),
              ],
              rows: transferList
                  .map(
                    (e) => DataRow(cells: <DataCell>[
                      DataCell(Text("${a++}",
                          style: GoogleFonts.openSans(textStyle: TextStyle()))),
                      DataCell(Text(e.locationId ?? '',
                          style: GoogleFonts.openSans(textStyle: TextStyle()))),
                      DataCell(Text(e.binIdentification ?? '',
                          style: GoogleFonts.openSans(textStyle: TextStyle()))),
                      DataCell(Text(e.bundleId ?? '',
                          style: GoogleFonts.openSans(textStyle: TextStyle()))),
                      DataCell(
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              transferList.remove(e);
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

  void addBundles(
      String locationId, String binId, List<BundleDetail> bundleList) {}

  Widget showBundles(String binId) {
    return Expanded(
      child: FutureBuilder(
        future: apiService.getBundlesinBin(binId),
        builder: (context, snapshot) {
          List<BundleDetail> bundleList = snapshot.data ?? [];
          if (snapshot.hasData) {
            return Container(
              height: 300,
              width: 150,
              color: Colors.red,
            );
            // return ListView.builder(
            //     itemCount: bundleList.length,
            //     itemBuilder: (context, index) {
            //       return Text("adsadfs");
            //     });
          } else {
            return Container(
              child: Text("Bundles"),
            );
          }
        },
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
            title: Center(child: Text('Confirm Transfer of BIN\'s')),
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
                  child: Text('Cancel')),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.green),
                  ),
                  onPressed: () {
                    ApiService apiService = new ApiService();

                    Future.delayed(
                      const Duration(milliseconds: 50),
                      () {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      },
                    );
                    apiService
                        .postTransferBinToLocation(transferList)
                        .then((value) {
                      if (value != null) {
                        if (widget.type == "preparation") {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PreprationDash(
                                      userId: widget.userId,
                                      machineId: 'preparation',
                                    )),
                          );
                        }
                        if (widget.type == 'process') {
                          apiService
                              .getmachinedetails(widget.machine.machineNumber)
                              .then((value) {
                            // Navigator.pop(context);
                            MachineDetails machineDetails = value[0];
                            Fluttertoast.showToast(
                                msg: widget.machine.machineNumber,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            print("machineID:${widget.machine.machineNumber}");
                            switch (machineDetails.category) {
                              case "Manual Crimping":
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageOp2(
                                            userId: widget.userId,
                                            machine: machineDetails,
                                          )),
                                );
                                break;
                              case "Manual Cutting":
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage(
                                            userId: widget.userId,
                                            machine: machineDetails,
                                          )),
                                );
                                break;
                              case "Automatic Cut & Crimp":
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage(
                                            userId: widget.userId,
                                            machine: machineDetails,
                                          )),
                                );
                                break;
                              case "Semi Automatic Strip and Crimp machine":
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageOp2(
                                            userId: widget.userId,
                                            machine: machineDetails,
                                          )),
                                );
                                break;
                              case "Automatic Cutting":
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Homepage(
                                            userId: widget.userId,
                                            machine: machineDetails,
                                          )),
                                );
                                break;
                              default:
                                Fluttertoast.showToast(
                                    msg: "Machine not Found",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                            }
                          });
                        }
                        if (widget.type == 'visualInspection') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeVisualInspector(
                                      userId: widget.userId,
                                    )),
                          );
                        }
                      } else {
                        Fluttertoast.showToast(
                          msg: "Transfer Failed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                    });
                  },
                  child: Text('Confirm')),
            ],
          ),
        );
      },
    );
  }
}
