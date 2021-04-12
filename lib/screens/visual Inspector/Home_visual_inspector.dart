import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:molex/models/Schudule.dart';
import 'package:molex/models/vi_schedule.dart';
import 'package:molex/screens/navigation.dart';

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
  @override
  void initState() {
    super.initState();
    viScheduleList.add(ViSchedule(
      orderId: "846478041",
      fgPart: "367810109",
      scheduleId: "945810107",
      binId: "BIN8712122",
      totalBundles: "10",
      totalbundleQty: "500 Pcs",
    ));
    viScheduleList.add(ViSchedule(
      orderId: "846478042",
      fgPart: "367810110",
      scheduleId: "945810108",
      binId: "BIN8712122",
      totalBundles: "10",
      totalbundleQty: "500 Pcs",
    ));
    viScheduleList.add(ViSchedule(
      orderId: "846478043",
      fgPart: "367810111",
      scheduleId: "945810108",
      binId: "BIN8712122",
      totalBundles: "10",
      totalbundleQty: "500 Pcs",
    ));
    viScheduleList.add(ViSchedule(
      orderId: "846478043",
      fgPart: "367810112",
      scheduleId: "945810108",
      binId: "BIN8712122",
      totalBundles: "10",
      totalbundleQty: "500 Pcs",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: const Text('Vi Dashboard'),
       
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
                        widget.userId ?? "12210",
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
              child: GestureDetector(
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
                                Row(
                                  children: [
                                    Container(
                                      width: 250,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                100)),
                                                  ),
                                                  child: Center(
                                                      child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        child: Icon(
                                                          Icons.schedule,
                                                          size: 18,
                                                          color:
                                                              Colors.redAccent,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Shift A",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  )),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[100],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(100)),
                                                ),
                                                child: Center(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4.0),
                                                      child: Icon(
                                                        Icons.settings,
                                                        size: 18,
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      widget.machineId ?? "",
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                //Select
                                Container(
                                  child: Row(
                                    children: [
                                      dropdown(options: [
                                        "846478041",
                                        "846478041",
                                        "846478041",
                                      ], name: "Select Order Id"),
                                      SizedBox(width: 10),
                                      dropdown(options: [
                                        "846478041",
                                        "846478041",
                                        "846478041",
                                      ], name: "Select  FG Part"),
                                      SizedBox(width: 10),
                                      dropdown(options: [
                                        "846478041",
                                        "846478041",
                                        "846478041",
                                      ], name: "Select Schedule Id"),
                                      SizedBox(width: 10),
                                      dropdown(options: [
                                        "846478041",
                                        "846478041",
                                        "846478041",
                                      ], name: "Select Bin"),
                                    ],
                                  ),
                                ),
                                //Scan
                                Container(
                                  child: ElevatedButton(
                                       style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                side: BorderSide(
                                                    color:
                                                        Colors.transparent))),
                                        backgroundColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.pressed))
                                              return Colors.green[200];
                                            return Colors.green[
                                                500]; // Use the component's default.
                                          },
                                        ),
                                      ),
                                    child: Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              height: 28,
                                              width: 28,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/image/scan.png"))),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Scan',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    onPressed: (){},
                                  ),
                                ),
                                //Date
                                Container(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        DateFormat('MM-dd-yyyy')
                                            .format(DateTime.now()),
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      Text(
                                          DateFormat('hh:mm')
                                              .format(DateTime.now()),
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23,
                                          )),
                                    ],
                                  ),
                                ),
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
                      viScheduleList: viScheduleList,
                    )
                  ],
                ),
              );
            }));
  }

  Widget dropdown({List<String> options, String name}) {
    String _chosenValue;
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
        _chosenValue = value;
      },
    ));
  }
}

class ViScheduleTable extends StatefulWidget {
  List<ViSchedule> viScheduleList;
  ViScheduleTable({this.viScheduleList});
  @override
  _ViScheduleTableState createState() => _ViScheduleTableState();
}

class _ViScheduleTableState extends State<ViScheduleTable> {
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
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.viScheduleList.length,
                  itemBuilder: (context, index) {
                    return buildDataRow(
                        viSchedule: widget.viScheduleList[index]);
                  }),
            ),
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
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
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
              cell("Order Id", 0.08),
              cell("FG Part", 0.08),
              cell("Schedule ID", 0.08),
              cell("Bin Id", 0.1),
              cell("Total Bundles", 0.10),
              cell("Total Bundle Qty", 0.12),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDataRow({ViSchedule viSchedule, int c}) {
    Widget cell(String name, double width) {
      return Container(
        width: MediaQuery.of(context).size.width * width,
        height: 40,
        child: Center(
          child: Text(
            name,
          ),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      color: Colors.grey[100],
      child: Container(
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // orderId
            cell(viSchedule.orderId, 0.08),
            //Fg Part
            cell(viSchedule.fgPart, 0.08),

            //Schudule ID
            cell(viSchedule.scheduleId, 0.08),
            //Cable Part
            cell(viSchedule.binId, 0.1),

            //Process
            cell(viSchedule.totalBundles, 0.08),
            // Cut length
            cell(viSchedule.totalbundleQty, 0.12),
            //Action
          ],
        ),
      ),
    );
  }
}
