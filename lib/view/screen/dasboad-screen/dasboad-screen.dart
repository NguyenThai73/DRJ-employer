// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable, must_be_immutable, unused_element, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, sort_child_properties_last
import 'dart:html';
import 'dart:typed_data';
import 'package:atbmtptpmdd_employer/controllers/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/provider.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int countJobs = 0;
  int countCandidate = 0;
  @override
  void initState() {
    super.initState();
    var employer = Provider.of<Employer>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> processing() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Center(child: const CircularProgressIndicator());
        },
      );
    }

    return Consumer<Employer>(
      builder: (context, employer, child) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: EdgeInsets.all(15),
                  decoration:
                      BoxDecoration(color: Color(0xffDADADA).withOpacity(0.5)),
                  child: Text(
                    "Dashboard",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.9,
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Color(0xffDADADA)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 220, 220, 220)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        )
                      ]),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 130,
                                width: 400,
                                margin: EdgeInsets.only(
                                    top: 20, left: 20, right: 20, bottom: 20),
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Color(0xff4fb145),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff4fb145).withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: Offset(
                                            1, 3), // changes position of shadow
                                      )
                                    ]),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("$countJobs",
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                                SizedBox(height: 15),
                                          Text("Tổng số công việc đang tuyển",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white))
                                        ],
                                      ),
                                      Icon(Icons.receipt_long,color: Colors.white,size: 60,)
                                    ]),
                              ),
                              Container(
                                height: 130,
                                width: 400,
                                margin: EdgeInsets.only(
                                    top: 20, left: 20, right: 20, bottom: 20),
                                    padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Colors.lightBlue.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 3,
                                        offset: Offset(
                                            1, 3), // changes position of shadow
                                      )
                                    ]),
                                     child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("$countCandidate",
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)),
                                                SizedBox(height: 15),
                                          Text("Tổng số ứng viên",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white))
                                        ],
                                      ),
                                      Icon(Icons.group,color: Colors.white,size: 60,)
                                    ]),
                              )
                            ])
                      ])),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> processing() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
