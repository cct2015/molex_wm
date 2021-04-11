import 'package:flutter/material.dart';

class USerID extends StatefulWidget {
  @override
  _USerIDState createState() => _USerIDState();
}

class _USerIDState extends State<USerID> {
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
        body: Center(child: scan()
        ));
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
                            hintText: 'Scan ID',
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
                        'Scan User ID',
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

 
}
