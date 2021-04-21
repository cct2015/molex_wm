import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/model_api/visualInspection/VI_scheduler_model.dart';

import 'package:molex/models/vi_schedule.dart';
import 'package:molex/screens/navigation.dart';
import 'package:molex/screens/visual%20Inspector/VIscan.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';

class HomeVisualInspector extends StatefulWidget {
  String userId;
  String machineId;
  HomeVisualInspector({this.userId, this.machineId});
  @override
  _HomeVisualInspectorState createState() => _HomeVisualInspectorState();
}

class _HomeVisualInspectorState extends State<HomeVisualInspector> {
  Schedule schedule;
  List<ViSchedule> viScheduleList = [];
  String _chosenValue;
  ApiService apiService;
  @override
  void initState() {
    apiService = new ApiService();
    schedule = Schedule(
        orderId: "100",
        finishedGoodsNumber: "300",
        scheduledId: "300",
        cablePartNumber: "200",
        process: "Wirecutting",
        length: "100",
        color: "Red",
        scheduledQuantity: "50",
        scheduledStatus: "Not Completed");
    viScheduleList.add(ViSchedule(
      binId: "1234567",
      totalBundles: "100",
      fgPart: "123456789",
      orderId: "0123456789",
      scheduleId: "123456789",
      totalbundleQty: "100",
    ));
    viScheduleList.add(ViSchedule(
      binId: "1234567",
      totalBundles: "100",
      fgPart: "123456789",
      orderId: "0123456789",
      scheduleId: "123456789",
      totalbundleQty: "100",
    ));
    viScheduleList.add(ViSchedule(
      binId: "1234567",
      totalBundles: "100",
      fgPart: "123456789",
      orderId: "0123456789",
      scheduleId: "123456789",
      totalbundleQty: "100",
    ));
    viScheduleList.add(ViSchedule(
      binId: "1234567",
      totalBundles: "100",
      fgPart: "123456789",
      orderId: "0123456789",
      scheduleId: "123456789",
      totalbundleQty: "100",
    ));
    viScheduleList.add(ViSchedule(
      binId: "1234567",
      totalBundles: "100",
      fgPart: "123456789",
      orderId: "0123456789",
      scheduleId: "123456789",
      totalbundleQty: "100",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.red,
          ),
          backwardsCompatibility: false,
          leading: null,
          title: const Text(
            'Visual Inspector Dashboard',
            style: TextStyle(color: Colors.red),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
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
                    ],
                  )
                ],
              ),
            ),
            TimeDisplay(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NavPage(
                            schedule: schedule,
                            userId: widget.userId,
                            machineId: widget.machineId,
                          )),
                );
              },
              child: Padding(
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
              ),
            )
          ],
        ),
        body: StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 2000)),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 7),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Select
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 38,
                                        width: 180,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          color: Colors.grey[100],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.search,
                                                size: 20,
                                                color: Colors.red[400],
                                              ),
                                              SizedBox(width: 5),
                                              Container(
                                                width: 130,
                                                height: 30,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: TextField(
                                                  onChanged: (value) {
                                                    setState(() {});
                                                  },
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                  onTap: () {},
                                                  decoration:
                                                      new InputDecoration(
                                                    hintText: _chosenValue,
                                                    hintStyle:
                                                        GoogleFonts.openSans(
                                                      textStyle: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    disabledBorder:
                                                        InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15,
                                                            bottom: 11,
                                                            top: 11,
                                                            right: 15),
                                                    fillColor: Colors.white,
                                                  ),
                                                  //fillColor: Colors.green
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      dropdown(options: [
                                        "Order ID",
                                        "FG No.",
                                        "Schedule Id",
                                      ], name: "Order Id"),
                                    ],
                                  ),
                                ),
                                //Scan
                                //Date
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.redAccent,
                      thickness: 2,
                    ),
                    ViScheduleTable(
                        viScheduleList: viScheduleList, schedule: schedule)
                  ],
                ),
              );
            }));
  }

  Widget dropdown({List<String> options, String name}) {
    return Container(
        child: DropdownButton<String>(
      focusColor: Colors.white,
      value: _chosenValue,
      style: TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items: options.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: Text(
        name,
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        setState(() {
          _chosenValue = value;
        });
      },
    ));
  }
}

class ViScheduleTable extends StatefulWidget {
  List<ViSchedule> viScheduleList;
  Schedule schedule;
  ViScheduleTable({this.viScheduleList, this.schedule});
  @override
  _ViScheduleTableState createState() => _ViScheduleTableState();
}

class _ViScheduleTableState extends State<ViScheduleTable> {
   ApiService apiService;
   @override
  void initState() {
        apiService = new ApiService();
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
              height: double.maxFinite,
              // height: double.parse("${rowList.length*60}"),
              child: FutureBuilder(
                    future: apiService.getviSchedule(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        List<ViScheduler> vischedule = snapshot.data;
                  return     ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: vischedule.length,
                    itemBuilder: (context, index) {
                      return buildDataRow(
                          viSchedule: vischedule[index], c: index + 1);
                    });
                      }else{
                        return Container();
                      }
                    }
              
            ),
            )
          ],
        ),
      ),
    );
  }

  Widget tableHeading() {
    Widget cell(String name, double width, bool sort) {
      return Container(
        width: MediaQuery.of(context).size.width * width,
        height: 25,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              (() {
                if (sort) {
                  return Container(
                    height: 22,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Container(
                            color: Colors.transparent,
                            height: 8,
                            child: Icon(
                              Icons.arrow_drop_up_sharp,
                              size: 16,
                            )),
                        Container(
                            color: Colors.transparent,
                            height: 8,
                            child: Icon(
                              Icons.arrow_drop_down_sharp,
                              size: 16,
                            )),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              }())
            ],
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cell("Order Id", 0.08, true),
              cell("FG Part", 0.08, true),
              cell("Schedule ID", 0.08, false),
              cell("Bin ID", 0.1, true),
              cell("Total Bundles", 0.11, false),
              cell("Total BundleQty", 0.12, true),
              cell("Action", 0.08, true),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDataRow({ViScheduler viSchedule, int c}) {
    Widget cell(String name, double width) {
      return Container(
        width: MediaQuery.of(context).size.width * width,
        height: 30,
        child: Center(
          child: Text(
            name,
            style: GoogleFonts.openSans(
              textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: c % 2 == 0 ? Colors.white : Colors.grey[100],
      child: Container(
        decoration: BoxDecoration(
            // border: Border(
            //     left: BorderSide(
            //   color: schedule.scheduledStatus == "Completed"
            //       ? Colors.green
            //       : schedule.scheduledStatus == "Pending"
            //           ? Colors.red
            //           : Colors.green[100],
            //   width: 5,
            // )),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // orderId
            cell(viSchedule.orderId, 0.08),
            //Fg Part
            cell(viSchedule.fgNo, 0.08),

            //Schudule ID
            cell(viSchedule.scheduleId, 0.08),
            //Cable Part
            cell(viSchedule.binId, 0.1),

            //Process
            cell(viSchedule.totalBundles, 0.11),
            // Cut length
            cell(viSchedule.totalBundles, 0.12),
            //Color
            Container(
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
                      return Colors.green[500]; // Use the component's default.
                    },
                  ),
                ),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/image/scan.png"))),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Scan',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Viscan(
                              userId: '45642313',
                              machineId: '45642313',
                              schedule: widget.schedule,
                            )),
                  );
                },
              ),
            ),

        
          ],
        ),
      ),
    );
  }
}
