import 'package:ashok_leyland_project_3/screens/trainee_list.dart';
import 'package:flutter/material.dart';
import 'package:ashok_leyland_project_3/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'search_bar.dart';
import 'package:sizer/sizer.dart';

class SelectDepartmentScreen extends StatefulWidget {
  @override
  _SelectDepartmentScreenState createState() => _SelectDepartmentScreenState();
}

class _SelectDepartmentScreenState extends State<SelectDepartmentScreen> {
  Container departmentButton(
      String deptName, double heightVar, double widthVar) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              primary: Colors.amber, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TraineeList()));
            },
            child: Container(
              height: heightVar,
              width: widthVar,
              child: Icon(
                Icons.engineering,
              ),
              padding: EdgeInsets.symmetric(vertical: 55, horizontal: 5),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            deptName,
            style: Constants.regularDarkText,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.0.h),
                child: Center(
                  child: Text('Home',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                      )),
                ),
              ),
              Container(
                height: 10,

                // child: Demo(), //search bar
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.only(bottom: 25),
                child: Wrap(
                  spacing: 30,
                  runSpacing: 40,
                  alignment: WrapAlignment.start,
                  children: [
                    departmentButton('Add Trainee', 15.0.h, 15.0.h),
                    departmentButton('SDC Training', 15.0.h, 15.0.h),
                    departmentButton('SDC Query', 15.0.h, 15.0.h),
                    departmentButton(
                        'Department \n Allocation', 15.0.h, 15.0.h),
                    departmentButton('On the job \n Training', 15.0.h, 15.0.h),
                    departmentButton(
                        'On the job \n Training \n Query', 15.0.h, 15.0.h),
                  ],
                ),
              ),
            ],
          ),
        )),
      );
    });
  }
}
