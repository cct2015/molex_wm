import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:molex/models/bundle_scan.dart';
import 'package:molex/screens/operator%202/process/scanBundle.dart';

class ScanBundleP3 extends StatefulWidget {
  @override
  _ScanBundleP3State createState() => _ScanBundleP3State();
}

class _ScanBundleP3State extends State<ScanBundleP3> {
  bool next = false;
  List<BundleScan> bundleScan = [];
  @override
  Widget build(BuildContext context) {
    return !next?scanbundlepop():scanbundleidpop();
  }

  Widget scanbundlepop() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(20.0),
        color: Colors.grey[100],
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.3 * 0.7,
              child: TextField(
                // controller: scanBundleController,
                // focusNode: scanFocus,
                autofocus: true,
                onTap: () {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                decoration: new InputDecoration(
                  hintText: "Scan Bundle",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(7.0),
                    borderSide: new BorderSide(),
                  ),
                  //fillColor: Colors.green
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.red[500];
                          return Colors
                              .red[900]; // Use the component's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        next = !next;
                      });
                    },
                    child: Text('Scan Bundle'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.grey[200];
                        return Colors.grey[100]; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {},
                  child: Text('999', style: TextStyle(color: Colors.black)),
                )),
              ),
            ],
          )
        ]),
      ),
    );
  }
  Widget scanbundleidpop(){
    return  Container(
            width: MediaQuery.of(context).size.width * 0.55,
           
           
          decoration: BoxDecoration(    borderRadius: new BorderRadius.circular(20.0),
           color: Colors.grey[100],),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Bundle Id - BUN123412129',style: TextStyle(fontSize:18, fontWeight:FontWeight.w600),),
                  ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                       quantity('Bundle Qty', 10),
                        quantity('Passed Qty', 10),
                         quantity('Rejected Qty', 10),]),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Container(
                         child: ElevatedButton(
                           style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.green[300];
                          return Colors
                              .green[800]; // Use the component's default.
                        },
                      ),
                    ),
                onPressed: () {
                  setState(() {
                    next=!next;
                  });
                },
                child: Text('Save and Scan next',
                style: TextStyle(color: Colors.white)),)
                       ),),
                   ],
                 )
              
            ),
          );
  }

     Widget quantity(String title, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            Container(
              height: 35,
              width: 120,
              child: TextField(
                style: TextStyle(fontSize: 12),
                keyboardType: TextInputType.number,
               decoration: new InputDecoration(
                      labelText: title,
                      fillColor: Colors.white,
                       labelStyle: TextStyle(fontSize: 15),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                 
                 

                  //fillColor: Colors.green
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}

