import 'package:ashok_leyland_project_3/screens/done_add_screen.dart';
import 'package:ashok_leyland_project_3/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:ashok_leyland_project_3/constants.dart';

import 'home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentAllocation extends StatefulWidget {
  @override
  _DepartmentAllocationState createState() => _DepartmentAllocationState();
}

class _DepartmentAllocationState extends State<DepartmentAllocation> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  crudMethod _traineeRef = new crudMethod();

  String _traineeName, _employeeId, _traineeQualifications, _traineeAge;
  DateTime _joiningDate;
  DateTime currentDate = new DateTime.now();
  bool _isDisable = false;
  bool showToggleBtn = false, showTextField = false;
  List<String> departmentItems = [
    'Department',
    'Chassis & Frame Assembly',
    'GB Assembly',
    'HT',
    'GB Machining',
    'H - Engine Assembly',
    'Engine - Machining',
    'A - Engine Assembly',
    'A - Engine Machining',
    'Axle Assembly',
    'Axle Machining'
  ];
  String departmentDropDownValue;
  crudMethod crudOperations = new crudMethod();
  void initState() {
    var departmentDropDownValue = departmentItems[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isNumeric(String s) {
      if (s == null) {
        return false;
      }
      return double.parse(s, (e) => null) != null;
    }

    String _formattedate = new DateFormat.yMMMd().format(currentDate);

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.yellow[00],
          body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(3.w, 3.h, 2.w, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 0.h, bottom: 2.h),
                      height: 5.0.h,
                      width: 6.0.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(5),
                          primary: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  Text(
                    "Department \n Allocation",
                    style: Constants.boldHeading,
                  ),

                  //EMPLOYEE ID
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (input) {
                        _employeeId = input;
                        setState(() async {
                          DocumentSnapshot snapshot =
                              await _traineeRef.trainee.doc(_employeeId).get();
                          Map<String, dynamic> documentData = snapshot.data();
                          print(documentData["name"] ?? "Null");
                          _nameController.text = documentData["name"] ?? "Null";
                        });
                      },
                      decoration: InputDecoration(labelText: 'Employee Id'),
                      validator: (value) {
                        if (value.isEmpty ||
                            !RegExp(r'^[a-z A-Z 0-9]').hasMatch(value)) {
                          return "Employee ID should contain only text and numbers";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _nameController,
                      onChanged: (input) {
                        _traineeName = input;
                        setState(() {
                          if (input.isEmpty)
                            _isDisable = true;
                          else
                            _isDisable = false;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Name'),
                      enabled: false,
                      enableInteractiveSelection: true,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      iconSize: 5.h,
                      focusColor: Colors.red,
                      value: departmentDropDownValue,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      iconEnabledColor: Colors.black,
                      items: departmentItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                // color: Colors.black,
                                ),
                          ),
                        );
                      }).toList(),
                      hint: Text(departmentItems[0]),
                      onChanged: (String value) {
                        setState(() {
                          departmentDropDownValue = value;
                          if (value != "department") {
                            showToggleBtn = true;
                          } else
                            showToggleBtn = false;
                          showTextField = false;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 2,

                          padding: EdgeInsets.symmetric(
                              vertical: 1.5.h, horizontal: 11.6.h),
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          final isValid = _formKey.currentState.validate();
                          // crudOperations.storeData({});
                          if (isValid) {
                            _traineeRef.trainee.doc(_employeeId).update({
                              "department": departmentDropDownValue,
                            });
                            
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoneMark(
                                          screen: false,
                                        )));
                          }
                        },
                        child: Text('Submit')),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
