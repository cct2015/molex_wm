import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:molex/model_api/machinedetails_model.dart';
import 'package:molex/model_api/transferLocation_model.dart';
import 'package:molex/screens/operator/location.dart';
import 'package:molex/screens/operator/process/partiallyComplete.dart';

import '../../operator/bin.dart';

class PartialCompletionP2 extends StatefulWidget {
  String userId;
  MachineDetails machine;
  PartialCompletionP2({this.machine, this.userId});
  @override
  _PartialCompletionP2State createState() => _PartialCompletionP2State();
}

class _PartialCompletionP2State extends State<PartialCompletionP2> {
  TextEditingController firstPatrolController = new TextEditingController();
  TextEditingController spareChangeoverController = new TextEditingController();
  TextEditingController crimpHeightSettingController =
      new TextEditingController();
  TextEditingController resettingCFMProgramController =
      new TextEditingController();
  TextEditingController newProgramSettingCVMCFMController =
      new TextEditingController();
  TextEditingController airPressureLowController = new TextEditingController();
  TextEditingController machineTakenforRemovingCVMController =
      new TextEditingController();
  TextEditingController noMaterialController = new TextEditingController();
  TextEditingController applicatorChangeoverController =
      new TextEditingController();
  TextEditingController sinkHeightAdjustmentController =
      new TextEditingController();
  TextEditingController feedingAdjustmentController =
      new TextEditingController();
  TextEditingController applicatorPositionSettingController =
      new TextEditingController();
  TextEditingController validationController = new TextEditingController();
  TextEditingController cFACrimpingFaultController =
      new TextEditingController();
  TextEditingController cableEntangleController = new TextEditingController();
  TextEditingController jobTicketIssueController = new TextEditingController();
  TextEditingController lengthChangeoverController =
      new TextEditingController();
  TextEditingController terminalBendController = new TextEditingController();
  TextEditingController cutOffBurrIssueController = new TextEditingController();
  TextEditingController cVMErrorCorrectionController =
      new TextEditingController();
  TextEditingController cableFeedingFrontUnitProblemController =
      new TextEditingController();
  TextEditingController driftLimitReachedController =
      new TextEditingController();
  TextEditingController machineSlowController = new TextEditingController();
  TextEditingController noPlanforMachineController =
      new TextEditingController();
  TextEditingController terminalChangeoverController =
      new TextEditingController();
  TextEditingController terminalTwistController = new TextEditingController();
  TextEditingController extrusionBurrIssueController =
      new TextEditingController();
  TextEditingController cFMErrorController = new TextEditingController();
  TextEditingController supplierTakenforMaintenanceController =
      new TextEditingController();
  TextEditingController rollerChangeoverController =
      new TextEditingController();
  TextEditingController gripenUnitProblemController =
      new TextEditingController();
  TextEditingController technicianNotAvailableController =
      new TextEditingController();
  TextEditingController coilChangeoverController = new TextEditingController();
  TextEditingController bellmouthAdjustmentController =
      new TextEditingController();
  TextEditingController cameraSettingController = new TextEditingController();
  TextEditingController cVMErrorController = new TextEditingController();
  TextEditingController lengthVariationsController =
      new TextEditingController();
  TextEditingController powerFailureController = new TextEditingController();
  TextEditingController machineCleaningController = new TextEditingController();
  TextEditingController noOperatorController = new TextEditingController();
  TextEditingController lastPieceController = new TextEditingController();
  TextEditingController curlingAdjustmentController =
      new TextEditingController();
  TextEditingController wireFeedingAdjustmentController =
      new TextEditingController();
  TextEditingController cVMProgramReloadingController =
      new TextEditingController();
  TextEditingController sensorNotWorkingController =
      new TextEditingController();
  TextEditingController preventiveMaintenanceController =
      new TextEditingController();
  TextEditingController meetingController = new TextEditingController();
  TextEditingController systemFaultController = new TextEditingController();
  TextEditingController maincontroller = new TextEditingController();
  String _output = '';
  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Row(
      children: [
        partialCompletion(),
        keypad(maincontroller),
      ],
    );
  }

  Widget keypad(TextEditingController controller) {
    buttonPressed(String buttonText) {
      if (buttonText == 'X') {
        _output = '';
      } else {
        _output = _output + buttonText;
      }

      print(_output);
      setState(() {
        controller.text = _output;
        // output = int.parse(_output).toStringAsFixed(2);
      });
    }

    Widget buildbutton(String buttonText) {
      return new Expanded(
          child: Container(
        decoration: new BoxDecoration(),
        width: 27,
        height: 50,
        child: new ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(color: Colors.grey[50]))),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.grey[100];

                return Colors.white; // Use the component's default.
              },
            ),
          ),
          child: buttonText == "X"
              ? Container(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    icon: Icon(
                      Icons.backspace,
                      color: Colors.red[400],
                    ),
                    onPressed: () => {buttonPressed(buttonText)},
                  ))
              : new Text(
                  buttonText,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
          onPressed: () => {buttonPressed(buttonText)},
        ),
      ));
    }

    return Material(
      elevation: 2,
      shadowColor: Colors.grey[200],
      child: Container(
        width: MediaQuery.of(context).size.width * 0.24,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.red.withOpacity(0.1),
          //     spreadRadius: 2,
          //     blurRadius: 2,
          //     offset: Offset(0, 0), // changes position of shadow
          //   ),
          // ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                buildbutton("7"),
                buildbutton('8'),
                buildbutton('9'),
              ],
            ),
            Row(
              children: [
                buildbutton('4'),
                buildbutton('5'),
                buildbutton('6'),
              ],
            ),
            Row(
              children: [
                buildbutton('1'),
                buildbutton('2'),
                buildbutton('3'),
              ],
            ),
            Row(
              children: [
                buildbutton('00'),
                buildbutton('0'),
                buildbutton('X'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget partialCompletion() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Partial Completion Reason',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                            ))
                      ]),
                ),
                SizedBox(width:10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      showReasons();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            'reason',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.blue, fontSize: 14)),
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          quantitycell(
                            name: "First Piece & Patrol",
                            quantity: 10,
                            textEditingController: firstPatrolController,
                          ),
                          quantitycell(
                            name: "Spare Changeover",
                            quantity: 10,
                            textEditingController: spareChangeoverController,
                          ),
                          quantitycell(
                            name: "Crimp Height Setting",
                            quantity: 10,
                            textEditingController: crimpHeightSettingController,
                          ),
                          quantitycell(
                            name: "Resetting CFM Program",
                            quantity: 10,
                            textEditingController:
                                resettingCFMProgramController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "New Program Setting CVM/CFM	",
                            quantity: 10,
                            textEditingController:
                                newProgramSettingCVMCFMController,
                          ),
                          quantitycell(
                            name: "Air Pressure Low",
                            quantity: 10,
                            textEditingController: airPressureLowController,
                          ),
                          quantitycell(
                            name: "Machine Taken for Removing CVM	",
                            quantity: 10,
                            textEditingController: machineCleaningController,
                          ),
                          quantitycell(
                            name: "No Material",
                            quantity: 10,
                            textEditingController: noMaterialController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Applicator Changeover	",
                            quantity: 10,
                            textEditingController:
                                applicatorChangeoverController,
                          ),
                          quantitycell(
                            name: "Sink Height Adjustment",
                            quantity: 10,
                            textEditingController:
                                sinkHeightAdjustmentController,
                          ),
                          quantitycell(
                            name: "Feeding Adjustment	",
                            quantity: 10,
                            textEditingController: feedingAdjustmentController,
                          ),
                          quantitycell(
                            name: "Applicator Position Setting		",
                            quantity: 10,
                            textEditingController:
                                applicatorPositionSettingController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Validation",
                            quantity: 10,
                            textEditingController: validationController,
                          ),
                          quantitycell(
                            name: "CFA Crimping Fault",
                            quantity: 10,
                            textEditingController: cFACrimpingFaultController,
                          ),
                          quantitycell(
                            name: "Cable Entangle",
                            quantity: 10,
                            textEditingController: cableEntangleController,
                          ),
                          quantitycell(
                            name: "Job Ticket Issue	",
                            quantity: 10,
                            textEditingController: jobTicketIssueController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Length Changeover",
                            quantity: 10,
                            textEditingController: lengthChangeoverController,
                          ),
                          quantitycell(
                            name: "Terminal Bend",
                            quantity: 10,
                            textEditingController: terminalBendController,
                          ),
                          quantitycell(
                            name: "Cut Off Burr Issue",
                            quantity: 10,
                            textEditingController: cutOffBurrIssueController,
                          ),
                          quantitycell(
                            name: "CVM Error Correction",
                            quantity: 10,
                            textEditingController: cVMErrorController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Cable Feeding Front Unit Problem",
                            quantity: 10,
                            textEditingController:
                                cableFeedingFrontUnitProblemController,
                          ),
                          quantitycell(
                            name: "Drift Limit Reached	",
                            quantity: 10,
                            textEditingController: driftLimitReachedController,
                          ),
                          quantitycell(
                            name: "Machine Slow	",
                            quantity: 10,
                            textEditingController: machineSlowController,
                          ),
                          quantitycell(
                            name: "No Plan for Machine	",
                            quantity: 10,
                            textEditingController: noPlanforMachineController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Terminal Changeover",
                            quantity: 10,
                            textEditingController: terminalChangeoverController,
                          ),
                          quantitycell(
                            name: "Terminal Twist",
                            quantity: 10,
                            textEditingController: terminalTwistController,
                          ),
                          quantitycell(
                            name: "Extrusion Burr Issue",
                            quantity: 10,
                            textEditingController: extrusionBurrIssueController,
                          ),
                          quantitycell(
                            name: "CFM Error",
                            quantity: 10,
                            textEditingController: cFMErrorController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Supplier Taken for Maintenance	",
                            quantity: 10,
                            textEditingController:
                                supplierTakenforMaintenanceController,
                          ),
                          quantitycell(
                            name: "Roller Changeover",
                            quantity: 10,
                            textEditingController: rollerChangeoverController,
                          ),
                          quantitycell(
                            name: "Gripen Unit Problem",
                            quantity: 10,
                            textEditingController: gripenUnitProblemController,
                          ),
                          quantitycell(
                            name: "Technician Not Available	",
                            quantity: 10,
                            textEditingController:
                                technicianNotAvailableController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Coil Changeover	",
                            quantity: 10,
                            textEditingController: coilChangeoverController,
                          ),
                          quantitycell(
                            name: "Bellmouth Adjustment",
                            quantity: 10,
                            textEditingController:
                                bellmouthAdjustmentController,
                          ),
                          quantitycell(
                            name: "Camera Setting	",
                            quantity: 10,
                            textEditingController: cameraSettingController,
                          ),
                          quantitycell(
                            name: "CVM Error",
                            quantity: 10,
                            textEditingController: cVMErrorController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Length Variations	",
                            quantity: 10,
                            textEditingController: lengthVariationsController,
                          ),
                          quantitycell(
                            name: "Power Failure",
                            quantity: 10,
                            textEditingController: powerFailureController,
                          ),
                          quantitycell(
                            name: "Machine Cleaning",
                            quantity: 10,
                            textEditingController: machineCleaningController,
                          ),
                          quantitycell(
                            name: "No Operator",
                            quantity: 10,
                            textEditingController: noOperatorController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Last Piece	",
                            quantity: 10,
                            textEditingController: lastPieceController,
                          ),
                          quantitycell(
                            name: "Curling Adjustment",
                            quantity: 10,
                            textEditingController: curlingAdjustmentController,
                          ),
                          quantitycell(
                            name: "Wire Feeding Adjustment",
                            quantity: 10,
                            textEditingController:
                                wireFeedingAdjustmentController,
                          ),
                          quantitycell(
                            name: "CVM Program Reloading",
                            quantity: 10,
                            textEditingController: cVMErrorController,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          quantitycell(
                            name: "Sensor Not Working",
                            quantity: 10,
                            textEditingController: sensorNotWorkingController,
                          ),
                          quantitycell(
                            name: "Preventive Maintenance	",
                            quantity: 10,
                            textEditingController:
                                preventiveMaintenanceController,
                          ),
                          quantitycell(
                            name: "Meeting	",
                            quantity: 10,
                            textEditingController: meetingController,
                          ),
                          quantitycell(
                            name: "System Fault	",
                            quantity: 10,
                            textEditingController: systemFaultController,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 95.0),
                  child: Container(
                    child: Center(
                      child: Container(
                        height: 40,
                        width: 250,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          color: Colors.transparent))),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.green[200];
                                  return Colors.green[
                                      500]; // Use the component's default.
                                },
                              ),
                            ),
                            child: Text("Accept and Continue Process"),
                            onPressed: () {}),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    child: Center(
                      child: Container(
                        height: 45,
                        width: 250,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          color: Colors.transparent))),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Colors.green[200];
                                  return Colors.green[
                                      500]; // Use the component's default.
                                },
                              ),
                            ),
                            child: Text("Save & End Process"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Location(
                                          userId: widget.userId,
                                          machine: widget.machine,
                                        )),
                              );
                            }),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget quantitycell(
      {String name,
      int quantity,
      TextEditingController textEditingController,
      FocusNode focusNode}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 3.0),
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.22,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                height: 30,
                width: 140,
                child: TextField(
                  showCursor: false,
                  controller: textEditingController,
                  focusNode: focusNode,
                  onTap: () {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    setState(() {
                      _output = '';
                      maincontroller = textEditingController;
                    });
                  },
                  style: TextStyle(fontSize: 12),
                  decoration: new InputDecoration(
                    labelText: name,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> showReasons() async {
    Future.delayed(
      const Duration(milliseconds: 50),
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
    );
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Center(child: ReasonSelection());
      },
    );
  }
}
