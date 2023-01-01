// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable, must_be_immutable, unused_element, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, sort_child_properties_last
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:atbmtptpmdd_employer/controllers/api.dart';
import 'package:atbmtptpmdd_employer/model/employer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../common/input-text.dart';
import '../../common/toast.dart';
import '../login/login.dart';

class SignScreen extends StatefulWidget {
  SignScreen({Key? key}) : super(key: key);

  @override
  _SignScreenState createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  EmployerLogin employerLogin = EmployerLogin();
  String logo = "";
  String avatar = "";
  String password = "";
  String password1 = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  height: MediaQuery.of(context).size.height,
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
                                  label: 'Tên đăng nhập:',
                                  controller: TextEditingController(
                                      text: employerLogin.userName),
                                  onChanged: (value) {
                                    employerLogin.userName = value;
                                  },
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                TextFieldValidated(
                                  type: "None",
                                  height: 40,
                                  label: 'Mật khẩu:',
                                  isPassword: true,
                                  controller:
                                      TextEditingController(text: password),
                                  onChanged: (value) {
                                    password = value;
                                  },
                                ),
                              ]),
                              SizedBox(height: 10),
                              Row(children: [
                                TextFieldValidated(
                                  type: "None",
                                  height: 40,
                                  isPassword: true,
                                  label: 'Xác nhận mật khẩu:',
                                  controller:
                                      TextEditingController(text: password1),
                                  onChanged: (value) {
                                    password1 = value;
                                  },
                                ),
                              ]),
                              SizedBox(height: 10),
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
                                  "${(avatar == "") ? "https://firebasestorage.googleapis.com/v0/b/store-image-831fc.appspot.com/o/image%2Fbackground-image-companny.jpeg?alt=media" : avatar}",
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
                                  "${(logo == "") ? "https://firebasestorage.googleapis.com/v0/b/store-image-831fc.appspot.com/o/image%2Fnoavater.jpeg?alt=media" : logo}",
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
                      // SizedBox(height: 20),
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
                                    if (employerLogin.userName != "" &&
                                        employerLogin.userName != null &&
                                        employerLogin.name != "" &&
                                        employerLogin.name != null &&
                                        employerLogin.sdt != "" &&
                                        employerLogin.sdt != null &&
                                        employerLogin.email != "" &&
                                        employerLogin.email != null &&
                                        employerLogin.career != "" &&
                                        employerLogin.career != null &&
                                        employerLogin.scale != "" &&
                                        employerLogin.scale != null &&
                                        employerLogin.addRess != "" &&
                                        employerLogin.addRess != null &&
                                        employerLogin.scale != "" &&
                                        employerLogin.scale != null &&
                                        password != "" &&
                                        password1 != "") {
                                      if (password == password1) {
                                        var requestBody = {
                                          "userName": employerLogin.userName,
                                          "password": password,
                                          "name": employerLogin.name,
                                          "avatar": (avatar != "")
                                              ? avatar
                                              : "https://firebasestorage.googleapis.com/v0/b/store-image-831fc.appspot.com/o/image%2Fbackground-image-companny.jpeg?alt=media",
                                          "logo": (logo != "")
                                              ? logo
                                              : "https://firebasestorage.googleapis.com/v0/b/store-image-831fc.appspot.com/o/image%2Fnoavater.jpeg?alt=media",
                                          "addRess": employerLogin.addRess,
                                          "sdt": employerLogin.sdt,
                                          "email": employerLogin.email,
                                          "career": employerLogin.career,
                                          "scale": employerLogin.scale,
                                          "introduce": employerLogin.introduce,
                                          "status": 1
                                        };
                                        var response = await httpPostRegister(
                                            requestBody, context);
                                        print("requestBody:$response");

                                        var body = jsonDecode(response['body']);
                                        if (body['success'] == true) {
                                          Navigator.push<void>(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  LoginScreen(
                                                      email: employerLogin
                                                          .userName),
                                            ),
                                          );
                                          showToast(
                                            context: context,
                                            msg: "Đăng ký tài khoản thành công",
                                            color: Color.fromARGB(
                                                255, 128, 249, 16),
                                            icon: const Icon(Icons.done),
                                          );
                                        } else {
                                          showToast(
                                            context: context,
                                            msg: "${body['message']}",
                                            color: Color.fromARGB(
                                                255, 255, 100, 34),
                                            icon: const Icon(Icons.warning),
                                          );
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        showToast(
                                          context: context,
                                          msg: "Mật khẩu không khớp",
                                          color:
                                              Color.fromARGB(255, 255, 100, 34),
                                          icon: const Icon(Icons.warning),
                                        );
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      showToast(
                                        context: context,
                                        msg: "Cần nhập đầy đủ thông tin",
                                        color:
                                            Color.fromARGB(255, 255, 100, 34),
                                        icon: const Icon(Icons.warning),
                                      );
                                      Navigator.pop(context);
                                    }
                                    // var response123 = await httpPut(
                                    //     "/api/employer/put/${employer.emloyer.id}",
                                    //     requestBody,
                                    //     context);
                                    // // print("response123:$requestBody");
                                    // employer.changeUser(employerLogin);

                                    // Navigator.pop(context);
                                  },
                                  child: Text("Đăng ký",
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
                                    Navigator.pop(context);
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
