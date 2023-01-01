// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, sort_child_properties_last, must_be_immutable, use_build_context_synchronously
import 'dart:convert';

import 'package:atbmtptpmdd_employer/controllers/api.dart';
import 'package:flutter/material.dart';

import '../../common/toast.dart';

class DeleteJob extends StatefulWidget {
  int id;
  String name;
  DeleteJob({Key? key, required this.id, required this.name}) : super(key: key);
  @override
  State<DeleteJob> createState() => _DeleteJobState();
}

class _DeleteJobState extends State<DeleteJob> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Xác nhận xoá công việc',
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(
              Icons.close,
            ),
          ),
        ],
      ),
      content: Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        width: 400,
        height: 50,
        child: Column(
          children: [
            SizedBox(width: 400, child: Text("Xác nhận xoá: ${widget.name}")),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            var respense123 =
                await httpDelete("/api/job/delete/${widget.id}", context);
            print("respense123:$respense123");
            var response =
                await httpGet("/api/recruitment/job/:${widget.id}", context);
            var body = jsonDecode(response['body']);
            for (var element in body) {
              await httpDelete(
                  "/api/recruitment/delete/${element['id']}", context);
            }
            showToast(
              context: context,
              msg: "Xoá thành công",
              color: Color.fromARGB(255, 128, 249, 16),
              icon: const Icon(Icons.done),
            );
            Navigator.pop(context);
          },
          child: Text(
            'Xác nhận',
            style: TextStyle(),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            elevation: 3,
            minimumSize: Size(100, 40),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Hủy'),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
            elevation: 3,
            minimumSize: Size(100, 40),
          ),
        ),
      ],
    );
  }
}
