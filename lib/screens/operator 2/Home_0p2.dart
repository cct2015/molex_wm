import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/model_api/operator2/getCrimpingSchedule.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/screens/navigation.dart';
import 'package:molex/screens/operator%202/materialPick2.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';
import 'package:toggle_switch/toggle_switch.dart';

class HomePageOp2 extends StatefulWidget {
  final String userId;
  final MachineDetails machine;
  HomePageOp2({this.userId, this.machine});
  @override
  _HomePageOp2State createState() => _HomePageOp2State();
}

class _HomePageOp2State extends State<HomePageOp2> {
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
          'DashBoard Operator 2',
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
          //shift
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 7),
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
            // width: 130,
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
                            widget.machine.machineNumber ?? "",
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
                          machine: widget.machine,
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent[400],
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
            SchudleTable(userId: widget.userId, machine: widget.machine),
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
  final Schedule schedule;
  final String userId;
  final MachineDetails machine;
  SchudleTable({Key key, this.schedule, this.userId, this.machine})
      : super(key: key);

  @override
  _SchudleTableState createState() => _SchudleTableState();
}

class _SchudleTableState extends State<SchudleTable> {
  List<DataRow> datarows = [];
  ApiService apiService;
  List<CrimpingSchedule> crimpingSchedule;
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
                // height: double.parse("${rowList.length*60}"),
                child: FutureBuilder(
              future: apiService.getCrimpingSchedule(scheduleType: "A",machineNo: widget.machine.machineNumber),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return buildDataRow(
                            schedule: snapshot.data[index], c: index);
                      });
                }else{
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

  Widget buildDataRow({CrimpingSchedule schedule, int c}) {
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
          // border: Border(
          //     left: BorderSide(
          //   color: schedule.scheduledStatus == "Completed"
          //       ? Colors.green
          //       : schedule.scheduledStatus == "Pending"
          //           ?  Colors.orange[100]
          //           : Colors.blue[100],
          //   width: 5,
          // )),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // orderId
            cell('${schedule.purchaseOrder}', 0.1),
            //Fg Part
            cell('${schedule.finishedGoods}', 0.1),
            //Schudule ID
            cell('${schedule.scheduleId}', 0.1),
            //Cable Part
            cell('${schedule.cablePartNo}', 0.1),
            //Process
            cell('${schedule.process}', 0.07),
            // Cut length
            cell('${schedule.length}', 0.07),
            //Color
            cell('${schedule.wireColour}', 0.04),
            //Bin Id
            cell("${schedule.binIdentification}", 0.09),
            // Total bundles
            cell("${schedule.bundleIdentificationCount}", 0.05),
            //Total Bundle Qty
            cell("${schedule.bundleQuantityTotal}", 0.07),

            //Status
            // cell("${schedule.scheduledStatus}", 0.09),
            //Action
            Container(
              width: MediaQuery.of(context).size.width * 0.10,
              child: Center(
                child: false
                // schedule.scheduledStatus == "Completed"
                    ? Text("-")
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green;
                              return Colors.green;
                              //  schedule.scheduledStatus == "Pending"
                              //     ? Colors.red
                              //     : Colors
                              //         .green; // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MaterialPickOp2(
                                      schedule: schedule,
                                      userId: widget.userId,
                                      machine: widget.machine,
                                    )),
                          );
                        },
                        child: Container(
                          child: Text('Accept'),
                          //  child:
                          //   schedule.scheduledStatus == "Allocated"|| schedule.scheduledStatus == "Open"||schedule.scheduledStatus == ""||schedule.scheduledStatus == null
                          //       ? Text("Accept")
                          //       : schedule.scheduledStatus == "Pending"
                          //           ? Text('Continue')
                          //           : Text(''),
                                    ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
