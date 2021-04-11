import 'package:flutter/material.dart';

class Bundle extends StatefulWidget {
  @override
  _BundleState createState() => _BundleState();
}

class _BundleState extends State<Bundle> {
  String status= "scan";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: const Text('Material'),
          backwardsCompatibility: true,
         
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
                        "12210",
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
        body: Center(child: status=="scan"?scan():crimpingRejectionCases()));
  }

  Widget scan() {
    return Container(
        height: 200,
        width: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.grey[100]),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 200,
                    child: TextField(
                    
                      
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                               borderRadius: const BorderRadius.all(
                                 const Radius.circular(17.0),),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                             borderRadius: const BorderRadius.all(
                                 const Radius.circular(17.0),),
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                            ),
                            hintText: 'Scan bin',
                            contentPadding:
                                const EdgeInsets.all(12.0))),
                  ),
                ),
               
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                        'Scan Bundle',
                      ),
                      onPressed: () {
                        setState(() {
                          status = "Rejection";
                        });
                      },
                    ),
                  ],
                ),
              
        ));
  }

  Widget crimpingRejectionCases() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('WireCutting & Crimping Rejection Cases',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        quantitycell("Terminal Damage	", 10),
                        quantitycell("Crimp On Insulation	", 10),
                        quantitycell("Nick Mark / Strands Cut", 10),
                        quantitycell("End Wire", 10),
                        quantitycell("Insulation Curling Up & Down", 10),
                        quantitycell("Cut-Off Less / More", 10),
                        quantitycell("Exposure Strands", 10),
                      ],
                    ),
                    Column(
                      children: [
                        quantitycell("Terminal Bend	", 10),
                        quantitycell("Bellmouth Less / More", 10),
                        quantitycell("Brush Length Less / More", 10),
                        quantitycell("End Terminal	", 10),
                        quantitycell("Conductor Burr", 10),
                        quantitycell("Cut-off Burr", 10),
                        quantitycell("Strands Cut", 10),
                      ],
                    ),
                    Column(
                      children: [
                        quantitycell("Terminal Twist", 10),
                        quantitycell("Cut-off Burr", 10),
                        quantitycell("Cable Damage", 10),
                        quantitycell("Setup Rejection", 10),
                        quantitycell("Improper Crimping", 10),
                        quantitycell("Cut-off Bend", 10),
                        quantitycell("Terminal Copper Mark	", 10),
                      ],
                    ),
                    Column(
                      children: [
                        quantitycell("Crimp On Insulation", 10),
                        quantitycell("Exposure Strands", 10),
                        quantitycell("Half Curling", 10),
                        quantitycell("Conductor Curling Up & Down", 10),
                        quantitycell("Tab Bend / Tap Open", 10),
                        quantitycell("Insulation Damage", 10),
                        quantitycell("Terminal Back Out", 10),
                      ],
                    ),
                    
                    
                  ],
                ),
               
                   
              ),
            ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 8.0),
               child: Row( 
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                      end('Bundle Qty',10),
                       end('Passed Qty',10),
                        end('Rejected Qty',10),
                 ]
                  ),
             ),
                     
            Container(
              height: 100,
              child: Center(
                child: Container(
                  height: 45,
                  width: 250,
                  child: ElevatedButton(
                      child: Text("Save & Scan Next"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green, // background
                        onPrimary: Colors.white,
                      ),
                      onPressed: () {
                       setState(() {
                         status='scan';
                       });
                        
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget quantitycell(String title, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.23 * 0.6,
              child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  )),
            ),
            Container(
              height: 30,
              width: 90,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "Qty",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget end(String title,int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3 * 0.3,
              child: Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  )),),
            
            Container(
              height: 30,
              width: 110,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: "Qty",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
