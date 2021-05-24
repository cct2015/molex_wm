import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/screens/navigation.dart';
import 'package:molex/screens/widgets/CrimpPatrolHeader.dart';
import 'package:molex/screens/widgets/CrimpPatrolTable.dart';
import 'package:molex/screens/widgets/time.dart';
import 'package:molex/service/apiService.dart';
class CrimpingPatrolDash extends StatefulWidget {
    String userId;
  String machineId;
  CrimpingPatrolDash({this.machineId,this.userId});
  @override
  _CrimpingPatrolDashState createState() => _CrimpingPatrolDashState();
}

class _CrimpingPatrolDashState extends State<CrimpingPatrolDash> {
    ApiService apiService;
    @override
  void initState() {
    apiService = new ApiService();
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
       
      
        title: const Text(
          'Crimping Patrol',
          style: TextStyle(color: Colors.red),
        ),
        elevation: 0,
        actions: [
      
         

        
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
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    fontSize: 13, color: Colors.black)),
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
                            style: GoogleFonts.openSans(
                              textStyle:
                                  TextStyle(fontSize: 13, color: Colors.black),
                            ),
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => NavPage(
              //             userId: widget.userId,
              //             machine: widget.machine,
              //           )),
              // );
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
      body: Container(
        child: SingleChildScrollView(
                  child: Column(
            children: [
              CrimpPatrolHeader(),
              CrimpPatrolTable()
            ],
          ),
        ),
      ),
    );
  }

}