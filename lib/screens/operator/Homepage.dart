import 'package:flutter/material.dart';
import 'package:molex/models/Schudule.dart';
import 'package:intl/intl.dart';
import 'package:molex/screens/navigation.dart';
import 'package:molex/screens/operator/materialPick.dart';

class Homepage extends StatefulWidget {
  String userId;
  String machineId;
  Homepage({this.userId, this.machineId});
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Schedule schedule;
  @override
  void initState() {
    super.initState();
    schedule = Schedule(
        orderId: "100",
        fgpart: "300",
        scheudleId: "300",
        cablePart: "200",
        process: "Wirecutting",
        cutLength: "100",
        color: "Red",
        scheduledQty: "50",
        status: "Not Completed");
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
            'DashBoard',
            style: TextStyle(color: Colors.red),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
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
            Container(
              padding: EdgeInsets.all(2),
              height: 40,
              width: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SizedBox(height: 5),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         Text(
                  //           "User Id",
                  //           style: TextStyle(color: Colors.grey[100]),
                  //         )
                  //       ],
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.end,
                  //       children: [
                  //         Text(
                  //           widget.userId ?? "12210",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 12),
                  //         )
                  //       ],
                  //     )
                  //   ],
                  // ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 25,
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 25,
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
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        )),
                      ),
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

        //  AppBar(
        //   backgroundColor: Colors.red[400],
        //   title: const Text('Dashboard'),
        //   backwardsCompatibility: false,
        //   leading: Container(
        //     width: 0,
        //   ),
        //   actions: [
        //     Container(
        //       height: 40,
        //       width: 150,
        //       child: Column(
        //         children: [
        //           SizedBox(height: 5),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               Text(
        //                 "User Id",
        //                 style: TextStyle(color: Colors.grey[100]),
        //               )
        //             ],
        //           ),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.end,
        //             children: [
        //               Text(
        //                 widget.userId ?? "12210",
        //                 style: TextStyle(
        //                     fontWeight: FontWeight.bold, fontSize: 22),
        //               )
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(10.0),
        //       child: GestureDetector(
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => NavPage(
        //               schedule: schedule,
        //               userId: widget.userId,
        //               machineId: widget.machineId,
        //             )),
        //           );
        //         },
        //         child: Container(
        //           height: 40,
        //           width: 40,
        //           decoration: BoxDecoration(
        //               color: Colors.white,
        //               borderRadius: BorderRadius.all(Radius.circular(100)),
        //               image: DecorationImage(
        //                   image: AssetImage(
        //                     'assets/image/profile.jpg',
        //                   ),
        //                   fit: BoxFit.fill)),
        //         ),
        //       ),
        //     )
        //   ],
        // ),

        body: StreamBuilder(
            stream: Stream.periodic(const Duration(milliseconds: 2000)),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(),
                    //   child: Container(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 10.0, vertical: 7),
                    //     height: 60,
                    //     decoration: BoxDecoration(
                    //       color: Colors.white,
                    //     ),
                    //     child: Column(
                    //       children: [
                    //         SizedBox(height: 5),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 Container(
                    //                   width: 250,
                    //                   child: Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceAround,
                    //                     children: [
                    //                       Row(
                    //                         children: [
                    //                           Padding(
                    //                             padding:
                    //                                 const EdgeInsets.symmetric(
                    //                                     horizontal: 4.0),
                    //                             child: Container(
                    //                               padding: EdgeInsets.symmetric(
                    //                                   horizontal: 10),
                    //                               height: 40,
                    //                               decoration: BoxDecoration(
                    //                                 color: Colors.grey[100],
                    //                                 borderRadius:
                    //                                     BorderRadius.all(
                    //                                         Radius.circular(
                    //                                             100)),
                    //                               ),
                    //                               child: Center(
                    //                                   child: Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment.start,
                    //                                 children: [
                    //                                   Padding(
                    //                                     padding:
                    //                                         const EdgeInsets
                    //                                                 .symmetric(
                    //                                             horizontal:
                    //                                                 4.0),
                    //                                     child: Icon(
                    //                                       Icons.schedule,
                    //                                       size: 18,
                    //                                       color:
                    //                                           Colors.redAccent,
                    //                                     ),
                    //                                   ),
                    //                                   Text(
                    //                                     "Shift A",
                    //                                     style: TextStyle(
                    //                                         fontSize: 15),
                    //                                   ),
                    //                                 ],
                    //                               )),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       SizedBox(height: 6),
                    //                       Row(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                         children: [
                    //                           Container(
                    //                             padding: EdgeInsets.symmetric(
                    //                                 horizontal: 10),
                    //                             height: 40,
                    //                             decoration: BoxDecoration(
                    //                               color: Colors.grey[100],
                    //                               borderRadius:
                    //                                   BorderRadius.all(
                    //                                       Radius.circular(100)),
                    //                             ),
                    //                             child: Center(
                    //                                 child: Row(
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment
                    //                                       .spaceEvenly,
                    //                               children: [
                    //                                 Padding(
                    //                                   padding: const EdgeInsets
                    //                                           .symmetric(
                    //                                       horizontal: 4.0),
                    //                                   child: Icon(
                    //                                     Icons.settings,
                    //                                     size: 18,
                    //                                     color: Colors.redAccent,
                    //                                   ),
                    //                                 ),
                    //                                 Text(
                    //                                   widget.machineId ?? "",
                    //                                   style: TextStyle(
                    //                                       fontSize: 16),
                    //                                 ),
                    //                               ],
                    //                             )),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Container(
                    //               width: 200,
                    //               child: Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceEvenly,
                    //                 children: [
                    //                   Text(
                    //                     DateFormat('MM-dd-yyyy')
                    //                         .format(DateTime.now()),
                    //                     style: TextStyle(
                    //                         fontSize: 20, color: Colors.grey),
                    //                   ),
                    //                   Text(
                    //                       DateFormat('hh:mm')
                    //                           .format(DateTime.now()),
                    //                       style: TextStyle(
                    //                         color: Colors.blue,
                    //                         fontWeight: FontWeight.bold,
                    //                         fontSize: 25,
                    //                       )),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                   
                    Divider(
                      color: Colors.redAccent,
                      thickness: 2,
                    ),
                    SchudleTable(
                        userId: widget.userId, machineId: widget.machineId),
                  ],
                ),
              );
            }));
  }
}

class SchudleTable extends StatefulWidget {
  Schedule schedule;
  String userId;
  String machineId;
  SchudleTable({Key key, this.schedule, this.userId, this.machineId})
      : super(key: key);

  @override
  _SchudleTableState createState() => _SchudleTableState();
}

class _SchudleTableState extends State<SchudleTable> {
  List<Schedule> rowList = [];

  List<DataRow> datarows = [];
  @override
  void initState() {
    rowList.add(
      Schedule(
          orderId: "100",
          fgpart: "300",
          scheudleId: "300",
          cablePart: "200",
          process: "Wirecutting",
          cutLength: "100",
          color: "Red",
          scheduledQty: "50",
          status: "Not Completed"),
    );
    rowList.add(
      Schedule(
          orderId: "100",
          fgpart: "300",
          scheudleId: "300",
          cablePart: "200",
          process: "Wirecutting",
          cutLength: "100",
          color: "Red",
          scheduledQty: "50",
          status: "Completed"),
    );
    rowList.add(
      Schedule(
          orderId: "100",
          fgpart: "300",
          scheudleId: "300",
          cablePart: "200",
          process: "Wirecutting",
          cutLength: "100",
          color: "Red",
          scheduledQty: "50",
          status: "Pending"),
    );
    rowList.add(
      Schedule(
          orderId: "100",
          fgpart: "300",
          scheudleId: "300",
          cablePart: "200",
          process: "Wirecutting",
          cutLength: "100",
          color: "Red",
          scheduledQty: "50",
          status: "Completed"),
    );

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
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rowList.length,
                  itemBuilder: (context, index) {
                    return buildDataRow(schedule: rowList[index]);
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
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
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
              cell("Cable Part No.", 0.1),
              cell("Process", 0.08),
              cell("Cut Length(mm)", 0.12),
              cell("Color", 0.07),
              cell("Scheduled Qty", 0.1),
              cell("Status", 0.1),
              cell("Action", 0.1),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDataRow({Schedule schedule, int c}) {
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
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
            color: schedule.status == "Completed"
                ? Colors.green
                : schedule.status == "Pending"
                    ? Colors.red
                    : Colors.green[100],
            width: 5,
          )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // orderId
            cell(schedule.orderId, 0.08),
            //Fg Part
            cell(schedule.fgpart, 0.08),

            //Schudule ID
            cell(schedule.scheudleId, 0.08),
            //Cable Part
            cell(schedule.cablePart, 0.1),

            //Process
            cell(schedule.process, 0.08),
            // Cut length
            cell(schedule.cutLength, 0.12),
            //Color
            cell(schedule.color, 0.07),
            //Scheduled Qty
            cell(schedule.scheduledQty, 0.1),

            //Status
            cell(schedule.status, 0.1),
            //Action
            Container(
              width: 100,
              child: Center(
                child: schedule.status == "Completed"
                    ? Text("-")
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green;
                              return schedule.status == "Pending"
                                  ? Colors.red
                                  : Colors
                                      .green; // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MaterialPick(
                                      schedule: schedule,
                                      userId: widget.userId,
                                      machineId: widget.machineId,
                                    )),
                          );
                        },
                        child: Container(
                            child: schedule.status == "Not Completed"
                                ? Text("Accept")
                                : schedule.status == "Pending"
                                    ? Text('Continue')
                                    : Text('')),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
