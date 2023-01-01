// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable, must_be_immutable, unused_element, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, sort_child_properties_last
import 'dart:html';
import 'dart:typed_data';

import 'package:atbmtptpmdd_employer/controllers/api.dart';
import 'package:atbmtptpmdd_employer/model/employer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/provider.dart';
import '../../common/input-text.dart';
import '../../common/toast.dart';

class EmployerScreen extends StatefulWidget {
  EmployerScreen({Key? key}) : super(key: key);

  @override
  _EmployerScreenState createState() => _EmployerScreenState();
}

class _EmployerScreenState extends State<EmployerScreen> {
  EmployerLogin employerLogin = EmployerLogin();
  String logo = "";
  String avatar = "";
  @override
  void initState() {
    super.initState();
    var employer = Provider.of<Employer>(context, listen: false);
    employerLogin = employer.emloyer;
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
                    "Thiết lập cá nhân",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              SizedBox(height: 40),
                              Row(children: [
                                TextFieldValidated(
                                  type: "None",
                                  height: 40,
                                  label: 'Tên công ty:',
                                  controller: TextEditingController(
                                      text: employerLogin.name),
                                  onChanged: (value) {
                                    employerLogin.name = value;
                                  },
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                TextFieldValidated(
                                  type: "None",
                                  height: 40,
                                  label: 'Địa chỉ:',
                                  controller: TextEditingController(
                                      text: employerLogin.addRess),
                                  onChanged: (value) {
                                    employerLogin.addRess = value;
                                  },
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                TextFieldValidated(
                                  type: "None",
                                  height: 40,
                                  label: 'SĐT:',
                                  controller: TextEditingController(
                                      text: employerLogin.sdt),
                                  onChanged: (value) {
                                    employerLogin.sdt = value;
                                  },
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                TextFieldValidated(
                                  type: "None",
                                  height: 40,
                                  label: 'Email:',
                                  controller: TextEditingController(
                                      text: employerLogin.email),
                                  onChanged: (value) {
                                    employerLogin.email = value;
                                  },
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                TextFieldValidated(
                                  type: "None",
                                  height: 40,
                                  label: 'Website:',
                                  controller: TextEditingController(
                                      text: employerLogin.career),
                                  onChanged: (value) {
                                    employerLogin.career = value;
                                  },
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                TextFieldValidated(
                                  type: "None",
                                  height: 40,
                                  label: 'Quy mô:',
                                  controller: TextEditingController(
                                      text: employerLogin.scale),
                                  onChanged: (value) {
                                    employerLogin.scale = value;
                                  },
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Row(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: [
                                          Text(
                                            "Giới thiệu:",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      onChanged: (value) {
                                        employerLogin.introduce = value;
                                      },
                                      controller: TextEditingController(
                                          text: employerLogin.introduce),
                                      minLines: 10,
                                      maxLines: 15,
                                      // controller: widget.controller ?? null,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 7, 10, 0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                          SizedBox(width: 100),
                          Expanded(
                              child: Column(
                            children: [
                              Text("Ảnh nền:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                margin: EdgeInsets.only(top: 15, bottom: 15),
                                child: Image.network(
                                  "${(avatar == "") ? employerLogin.avatar : avatar}",
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                  width: 100,
                                  height: 30,
                                  margin: EdgeInsets.only(bottom: 50),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 26, 142, 185),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                      onPressed: () async {
                                        processing();
                                        FilePickerResult? result =
                                            await FilePicker.platform
                                                .pickFiles();

                                        if (result != null) {
                                          Uint8List fileBytes =
                                              result.files.first.bytes!;
                                          String fileName =
                                              result.files.first.name;
                                          // String path = result.files.first.path ?? "";
                                          await FirebaseStorage.instance
                                              .ref('image/avatar/$fileName')
                                              .putData(fileBytes);
                                          setState(() {
                                            avatar =
                                                "https://firebasestorage.googleapis.com/v0/b/store-image-a4f19.appspot.com/o/image%2Favatar%2F$fileName?alt=media";
                                          });
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Text("Thay ảnh",
                                          style:
                                              TextStyle(color: Colors.white)))),
                              Text("Logo:",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                              Container(
                                // width: MediaQuery.of(context).size.width * 0.1,
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                margin: EdgeInsets.only(top: 15, bottom: 15),
                                child: Image.network(
                                  "${(logo == "") ? employerLogin.logo : logo}",
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                  width: 100,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 26, 142, 185),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                      onPressed: () async {
                                        processing();
                                        FilePickerResult? result =
                                            await FilePicker.platform
                                                .pickFiles();

                                        if (result != null) {
                                          Uint8List fileBytes =
                                              result.files.first.bytes!;
                                          String fileName =
                                              result.files.first.name;
                                          // String path = result.files.first.path ?? "";
                                          await FirebaseStorage.instance
                                              .ref('image/avatar/$fileName')
                                              .putData(fileBytes);
                                          setState(() {
                                            logo =
                                                "https://firebasestorage.googleapis.com/v0/b/store-image-a4f19.appspot.com/o/image%2Favatar%2F$fileName?alt=media";
                                          });
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Text("Thay ảnh",
                                          style:
                                              TextStyle(color: Colors.white))))
                            ],
                          )),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              height: 30,
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 5, 95, 150),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                  onPressed: () async {
                                    processing();
                                    var requestBody = {
                                      "name": employerLogin.name,
                                      "avatar": employerLogin.avatar,
                                      "logo": employerLogin.logo,
                                      "addRess": employerLogin.addRess,
                                      "sdt": employerLogin.sdt,
                                      "email": employerLogin.email,
                                      "career": employerLogin.career,
                                      "scale": employerLogin.scale,
                                      "introduce": employerLogin.introduce,
                                      "status": employerLogin.status
                                    };
                                    var response123 = await httpPut(
                                        "/api/employer/put/${employer.emloyer.id}",
                                        requestBody,
                                        context);
                                    // print("response123:$requestBody");
                                    employer.changeUser(employerLogin);
                                    showToast(
                                      context: context,
                                      msg: "Cập nhật thành công",
                                      color: Color.fromARGB(255, 128, 249, 16),
                                      icon: const Icon(Icons.done),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cập nhật",
                                      style: TextStyle(color: Colors.white)))),
                          Container(
                              width: 100,
                              height: 30,
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 249, 42, 42),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    processing();
                                    setState(() {
                                      employerLogin = employer.emloyer;
                                      logo = "";
                                      avatar = "";
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("Huỷ",
                                      style: TextStyle(color: Colors.white))))
                        ],
                      )
                    ],
                  )),
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
