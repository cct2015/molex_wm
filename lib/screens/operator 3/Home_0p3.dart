import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/screens/navigation.dart';
import 'package:molex/screens/operator%203/materialPick3.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomePageOp3 extends StatefulWidget {
  String userId;
  String machineId;
  HomePageOp3({this.userId, this.machineId});
  @override
  _HomePageOp3State createState() => _HomePageOp3State();
}

class _HomePageOp3State extends State<HomePageOp3> {
  Schedule schedule;
  int type = 0;
  ApiService apiService;

  @override
  void initState() {
    apiService = new ApiService();
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
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
          'DashBoard Operator 3',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          //typeselect
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  //BoxShadow
                  BoxShadow(
                    color: Colors.grey[100],
                    offset: const Offset(0.0, 0.0),
                    blurRadius: 3.0,
                    spreadRadius: 2.0,
                  ), //BoxShadow
                ],
              ),
              child: ToggleSwitch(
                minWidth: 80.0,
                cornerRadius: 10.0,
                activeBgColor: Colors.green,
                activeFgColor: Colors.white,
                initialLabelIndex: type,
                inactiveBgColor: Colors.grey[200],
                inactiveFgColor: Colors.black,
                labels: ['Auto', 'Mannual'],
                onToggle: (index) {
                  print('switched to: $index');
                  type = index;

                  setState(() {
                    type = index;
                  });
                },
              ),
            ),
          ),
          //shift
          Container(
            padding: EdgeInsets.all(5),
            width: 100,
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
          //machine Id
          Container(
            padding: EdgeInsets.all(1),
            height: 40,
            // width: 130,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: Colors.redAccent,
              thickness: 2,
            ),
            search(),
            SchudleTable(userId: widget.userId, machineId: widget.machineId),
            FutureBuilder(
                future: apiService.getScheduelarData(widget.machineId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 100,
                      width: 200,
                      color: Colors.red,
                    );
                  } else {
                    return Container(
                      height: 100,
                      width: 200,
                      color: Colors.blue,
                    );
                  }
                })
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
          orderId: "846478041",
          finishedGoodsNumber: "367810109",
          scheduledId: "945810107",
          cablePartNumber: "824923001",
          process: "Wirecutting",
          length: "2060",
          color: "RED",
          scheduledQuantity: "500 Pcs",
          scheduledStatus: "Not Completed"),
    );
    rowList.add(
      Schedule(
          orderId: "846478042",
          finishedGoodsNumber: "367810110",
          scheduledId: "945810108",
          cablePartNumber: "824923002",
          process: "Wirecutting",
          length: "2060",
          color: "Green",
          scheduledQuantity: "500 Pcs",
          scheduledStatus: "Completed"),
    );
    rowList.add(
      Schedule(
          orderId: "846478043",
          fgpart: "367810111",
          scheudleId: "945810109",
          cablePart: "824923003",
          process: "Wirecutting",
          cutLength: "2060",
          color: "Black",
          scheduledQty: "500 Pcs",
          status: "Pending"),
    );
    rowList.add(
      Schedule(
          orderId: "846478043",
          fgpart: "367810111",
          scheudleId: "945810109",
          cablePart: "824923003",
          process: "Wirecutting",
          cutLength: "2060",
          color: "Black",
          scheduledQty: "500 Pcs",
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
              // height: double.parse("${rowList.length*60}"),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rowList.length,
                  itemBuilder: (context, index) {
                    return buildDataRow(schedule: rowList[index],c: index);
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
      color: c%2==0?Colors.grey[50]:Colors.white,
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
            cell(schedule.orderId, 0.1),
            //Fg Part
            cell(schedule.fgpart, 0.1),

            //Schudule ID
            cell(schedule.scheudleId, 0.1),
            //Cable Part
            cell(schedule.cablePart, 0.1),

            //Process
            cell(schedule.process, 0.07),
            // Cut length
            cell(schedule.cutLength, 0.07),
            //Color
            cell(schedule.color, 0.04),
            //Bin Id
            cell("BIN8712122", 0.09),
            // Total bundles
            cell("30", 0.05),
            //Total Bundle Qty
            cell("100", 0.07),

            //Status
            cell(schedule.status, 0.09),
            //Action
            Container(
              width:  MediaQuery.of(context).size.width * 0.10,
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
                                builder: (context) => MaterialPickOp3(
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
