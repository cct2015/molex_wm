import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/model_api/visualInspection/VI_scheduler_model.dart';

class ScheduleDetailWIP extends StatefulWidget {
  ViScheduler viSchedule;
  ScheduleDetailWIP({this.viSchedule});

  @override
  _ScheduleDetailWIPState createState() => _ScheduleDetailWIPState();
}

class _ScheduleDetailWIPState extends State<ScheduleDetailWIP> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
        clipBehavior: Clip.antiAlias, // Add This
        shadowColor: Colors.white70,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          height: 108,
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                scheduleDetail(),
                Divider(
                  height: 0,
                ),
                Container(
                  child: fGTable()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget feild({String heading, String value, double width}) {
    width = MediaQuery.of(context).size.width * width;
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        // color: Colors.red[100],
        width: width,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  heading,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.normal,
                  )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                children: [
                  Text(
                    value ?? '',
                    style: GoogleFonts.poppins(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget scheduleDetail() {
    return Container(
      height: 50,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          color: Colors.red[50],
          ),
          
          width: 30,
          height:30,
          child: Center(child: Image.asset('assets/image/order.png')),
        ),
        feild(                                   
            heading: "Order Id", value: widget.viSchedule.orderId, width: 0.1),
        feild(heading: "FG Part", value: widget.viSchedule.fgNo, width: 0.1),
        feild(
            heading: "Schedule ID",
            value: widget.viSchedule.scheduleId,
            width: 0.1),
        feild(
            heading: "Cable Part No.",
            value: widget.viSchedule.scheduleId,
            width: 0.1), //TODO cable Part Number not in API
        feild(
            heading: "Process",
            value: widget.viSchedule.scheduleType,
            width: 0.15),
        feild(heading: "Bin ID", value: widget.viSchedule.binId, width: 0.08),
        feild(
            heading: "Total Bundles",
            value: widget.viSchedule.totalBundles,
            width: 0.1),
        feild(heading: "Schedule", value: "10:00 - 11:00", width: 0.1)
      ],
    ));
  }

  Widget fGTable() {
    Widget boxes(
      String str1,
      String str2,
    ) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          // color: Colors.grey[200],
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              str1,
              style: TextStyle(fontSize: 10),
            ),
            Text(str2,
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    color: Colors.black)),
          ]),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          // color: Colors.grey[200],
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            feild(
                heading: "FG Description",
                value: 'OW4441 WIRE ASSY AC110KW BASE FEATURES',
                width: 0.33),
            feild(
                heading: "FG Scheduled Date", value: '29/03/2021', width: 0.12),
            feild(heading: "Customer", value: 'APC COOLING', width: 0.15),
            feild(heading:
             "Drg Rev", value: 'D', width: 0.05),
            feild(heading: "Cable Serial No", value: ' 1', width: 0.09),
            feild(heading: 'Tolerance ', value: '± 5 / ± 5', width: 0.1),
          ])),
    );
  }
}
