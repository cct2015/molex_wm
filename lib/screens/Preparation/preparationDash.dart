import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/Machine_Id.dart';
import 'package:molex/model_api/Preparation/getpreparationSchedule.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/screens/Preparation/process/preparationProcess.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';

class PreprationDash extends StatefulWidget {
  String userId;
  String machineId;
  PreprationDash({this.userId, this.machineId});
  @override
  _PreprationDashState createState() => _PreprationDashState();
}

class _PreprationDashState extends State<PreprationDash> {
  int type = 0;
  ApiService apiService;

  @override
  void initState() {
    apiService = new ApiService();
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        backwardsCompatibility: false,
        leading: null,
        title: const Text(
          'Preparation DashBoard',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
         

          // machineID
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
                            style: TextStyle(fontSize: 13, color: Colors.black),
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
                            style: TextStyle(fontSize: 13, color: Colors.black),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Colors.redAccent,
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                      child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.transparent))),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.green[200];
                          return Colors
                              .green[500]; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Preparationprocess(
                                  userId: widget.userId,
                                  machineId: widget.machineId,
                                )),
                      );
                    },
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/image/scan.png"))),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Process',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )),
                )
              ],
            ),
            search(),
            SchudleTable(
              userId: widget.userId,
              machineId: widget.machineId,
            ),
          ],
        ),
      ),
    );
  }

  Widget search() {
    if (type == 1) {
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(width: 10),
            Container(
                width: 130,
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
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
                )),
            SizedBox(width: 10),
            Container(
                width: 120,
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  decoration: new InputDecoration(
                    labelText: "Order Id.",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                )),
            SizedBox(width: 10),
            Container(
                width: 150,
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    setState(() {});
                  },
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  decoration: new InputDecoration(
                    labelText: "Cable Part No.",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                )),
            SizedBox(width: 10),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Search'),
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

class SchudleTable extends StatefulWidget {
  Schedule schedule;
  String userId;
  String machineId;
  SchudleTable({Key key, this.schedule, this.machineId, this.userId})
      : super(key: key);

  @override
  _SchudleTableState createState() => _SchudleTableState();
}

class _SchudleTableState extends State<SchudleTable> {
  ApiService apiService;
  List<Schedule> rowList = [];

  List<DataRow> datarows = [];
  @override
  void initState() {
    apiService = ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            tableHeading(),
            Container(
                // height: double.parse("${rowList.length*60}"),
                child: FutureBuilder(
              future: apiService.getPreparationSchedule(
                  type: "A", machineNo: widget.machineId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<PreparationSchedule> preparationSchedulelist =
                      snapshot.data;
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: preparationSchedulelist.length,
                      itemBuilder: (context, index) {
                        return buildDataRow(
                            schedule: preparationSchedulelist[index], c: index);
                      });
                } else {
                  return Container();
                }
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget tableHeading() {
    Widget cell(String name, double width) {
      return Container(
        width: MediaQuery.of(context).size.width * width,
        height: 40,
        child: Center(
          child: Text(
            name,
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cell("Order Id", 0.1),
              cell("FG Part", 0.1),
              cell("Schedule ID", 0.1),
              cell("Cable Part No.", 0.1),
              cell("Process", 0.07),
              cell("Cut Length\n(mm)", 0.07),
              cell("Color", 0.04),
              cell("Bin Id", 0.09),
              cell("Total \nBundles", 0.05),
              cell("total \nBundle Qty", 0.07),
              cell("Status", 0.09),
              // cell("Action", 0.1),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDataRow({PreparationSchedule schedule, int c}) {
    Widget cell(String name, double width) {
      return Container(
        width: MediaQuery.of(context).size.width * width,
        height: 30,
        child: Center(
          child: Text(
            name,
            style: TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: c % 2 == 0 ? Colors.grey[50] : Colors.white,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
            color: schedule.scheduledStatus == "Completed"
                ? Colors.green
                : schedule.scheduledStatus == "Partial"
                    ? Colors.orange[100]
                    : Colors.blue[100],
            width: 5,
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // orderId
            cell(schedule.orderId, 0.1),
            //Fg Part
            cell(schedule.finishedGoodsNumber, 0.1),

            //Schudule ID
            cell(schedule.scheduledId, 0.1),
            //Cable Part
            cell(schedule.cablePartNumber, 0.1),

            //Process
            cell(schedule.process, 0.07),
            // Cut length
            cell(schedule.length, 0.07),
            //Color
            cell(schedule.color, 0.04),
            //Bin Id
            cell("${schedule.binIdentification}", 0.09),
            // Total bundles
            cell("${schedule.bundleQuantity}", 0.05),
            //Total Bundle Qty
            cell("${schedule.passedQuantity}", 0.07),

            //Status
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 30,
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  color: schedule.scheduledStatus == 'Completed'
                      ? Colors.green[50]
                      : schedule.scheduledStatus == "Partial"
                          ? Colors.red[100]
                          : Colors.blue[100],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text(
                    schedule.scheduledStatus,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: schedule.scheduledStatus == 'Completed'
                            ? Colors.green
                            : schedule.scheduledStatus == "Partial"
                                ? Colors.yellow[900]
                                : Colors.blue[900],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //Action
            // Container(
            //   width: 88,
            //   height: 35,
            //   child: Center(
            //     child: schedule.scheduledStatus == "Completed"
            //         ? Text("-")
            //         : ElevatedButton(
            //             style: ButtonStyle(
            //               backgroundColor:
            //                   MaterialStateProperty.resolveWith<Color>(
            //                 (Set<MaterialState> states) {
            //                   if (states.contains(MaterialState.pressed))
            //                     return Colors.green;
            //                   return schedule.scheduledStatus == "Pending"
            //                       ? Colors.red
            //                       : Colors.green[
            //                           500]; // Use the component's default.
            //                 },
            //               ),
            //             ),
            //             onPressed: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => Processpage3(
            //                           schedule: schedule,
            //                           userId: widget.userId,
            //                         )),
            //               );
            //               // Navigator.push(
            //               //   context,
            //               //   MaterialPageRoute(
            //               //       builder: (context) => MaterialPickOp3(
            //               //              schedule: schedule,
            //               //             userId: widget.userId,
            //               //             machineId: widget.machineId,
            //               //           )),
            //               // );
            //             },
            //             child: Container(
            //                 child: schedule.scheduledStatus == "Allocated" ||
            //                         schedule.scheduledStatus == "Open" ||
            //                         schedule.scheduledStatus == "" ||
            //                         schedule.scheduledStatus == null
            //                     ? Text(
            //                         "Accept",
            //                         style: GoogleFonts.openSans(
            //                           textStyle: TextStyle(
            //                               fontSize: 12,
            //                               fontWeight: FontWeight.w700),
            //                         ),
            //                       )
            //                     : schedule.scheduledStatus == "Partial"
            //                         ? Text(
            //                             'Continue',
            //                             style: GoogleFonts.openSans(
            //                               textStyle: TextStyle(
            //                                   fontSize: 12,
            //                                   fontWeight: FontWeight.w600),
            //                             ),
            //                           )
            //                         : Text('')),
            //           ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
