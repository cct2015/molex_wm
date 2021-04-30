import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/model_api/schedular_model.dart';
import 'package:molex/screens/navigation.dart';
import 'package:molex/screens/operator/materialPick.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';
import 'package:toggle_switch/toggle_switch.dart';
// Process 1 Auto Cut and Crimp
class Homepage extends StatefulWidget {
  String userId;
  MachineDetails machine;
  Homepage({this.userId, this.machine});
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Schedule schedule;
  int type = 0;
  int scheduleType = 0;
  ApiService apiService;

  String dropdownName = "FG part";

  @override
  void initState() {
    apiService = new ApiService();
    apiService.getScheduelarData(
        machId: widget.machine.machineNumber, type: type == 0 ? "A" : "B");
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
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
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
          //typeselect
         
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3),
            child: Row(
              children: [
                Container(
                  height: 25,
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
                    minWidth: 70.0,
                    cornerRadius: 10.0,
                    activeBgColor: Colors.green,
                    activeFgColor: Colors.white,
                    initialLabelIndex: type,
                    inactiveBgColor: Colors.grey[200],
                    inactiveFgColor: Colors.black,
                    fontSize: 12,
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
              ],
            ),
          ),
           Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Container(
                  height: 25,
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
                    initialLabelIndex: scheduleType,
                    inactiveBgColor: Colors.grey[200],
                    inactiveFgColor: Colors.black,
                    labels: ['Auto Shdl', 'Others'],
                    fontSize: 12,
                    onToggle: (index) {
                      print('switched to: $index');
                      scheduleType = index;
                      setState(() {
                        scheduleType = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

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
            SchudleTable(
              schedule: schedule,
              userId: widget.userId,
              machine: widget.machine,
              type: type == 0 ? "A" : "B",
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
              height: 38,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        onTap: () {},
                        decoration: new InputDecoration(
                          hintText: "FG Part No.",
                          hintStyle: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          fillColor: Colors.white,
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 38,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        onTap: () {},
                        decoration: new InputDecoration(
                          hintText: "Order Id",
                          hintStyle: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          fillColor: Colors.white,
                        ),
                        //fillColor: Colors.green
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 38,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        onTap: () {},
                        decoration: new InputDecoration(
                          hintText: "Cable Part No.",
                          hintStyle: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
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
  MachineDetails machine;
  String type;
  SchudleTable({Key key, this.schedule, this.userId, this.type, this.machine})
      : super(key: key);

  @override
  _SchudleTableState createState() => _SchudleTableState();
}

class _SchudleTableState extends State<SchudleTable> {
  List<Schedule> schedualrList = [];

  List<DataRow> datarows = [];
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
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            tableHeading(),
            Container(

                // height: double.parse("${rowList.length*60}"),
                child: FutureBuilder(
              future: apiService.getScheduelarData(
                  machId: widget.machine.machineNumber, type: widget.type),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // return  buildDataRow(schedule:widget.schedule,c:2);
                  List<Schedule> schedulelist = snapshot.data;
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: schedulelist.length,
                      itemBuilder: (context, index) {
                        return buildDataRow(
                            schedule: schedulelist[index], c: index + 1);
                      });
                } else {
                  return Center(child: SingleChildScrollView());
                }
              },
            )
                //  ListView.builder(
                //     physics: NeverScrollableScrollPhysics(),
                //     shrinkWrap: true,
                //     itemCount: rowList.length,
                //     itemBuilder: (context, index) {
                //       return buildDataRow(schedule: rowList[index]);
                //     }),
                ),
          ],
        ),
      ),
    );
  }

  // no data
  // empty list

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
              cell("Cable Part No.", 0.1, true),
              cell("Process", 0.11, false),
              cell("Cut Length(mm)", 0.12, true),
              cell("Color", 0.07, false),
              cell("Scheduled Qty", 0.1, true),
              cell("Status", 0.1, true),
              cell("Action", 0.08, true),
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
            cell(schedule.orderId, 0.08),
            //Fg Part
            cell(schedule.finishedGoodsNumber, 0.08),

            //Schudule ID
            cell(schedule.scheduledId, 0.08),
            //Cable Part
            cell(schedule.cablePartNumber, 0.1),

            //Process
            cell(schedule.process, 0.11),
            // Cut length
            cell(schedule.length, 0.12),
            //Color
            cell(schedule.color, 0.07),
            //Scheduled Qty
            cell(schedule.scheduledQuantity, 0.1),

            //Status
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 30,
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  color: schedule.scheduledStatus == 'Completed'
                      ? Colors.green[50]
                      : schedule.scheduledStatus=="Partial"?Colors.red[100]:Colors.blue[100],
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
                            : schedule.scheduledStatus=="Partial"?Colors.yellow[900]:Colors.blue[900],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //Action
            Container(
              width: 84,
              height: 35,
              child: Center(
                child: schedule.scheduledStatus == "Completed"
                    ? Text("-")
                    : ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green;
                              return schedule.scheduledStatus == "Pending"
                                  ? Colors.red
                                  : Colors.green[
                                      500]; // Use the component's default.
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
                                      machine: widget.machine,
                                    )),
                          );
                        },
                        child: Container(
                            child: schedule.scheduledStatus == "Allocated"|| schedule.scheduledStatus == "Open"||schedule.scheduledStatus == ""||schedule.scheduledStatus == null
                                ? Text(
                                    "Accept",
                                    style: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                : schedule.scheduledStatus == "Partial"
                                    ? Text(
                                        'Continue',
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
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
