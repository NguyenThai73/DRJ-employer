// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../controllers/api.dart';
import '../../../model/jobs.dart';
import '../../common/input-text.dart';
import 'comfim-pv.dart';

class ViewJobs extends StatefulWidget {
  Jobs job;
  String provinceName;
  ViewJobs({Key? key, required this.job, required this.provinceName})
      : super(key: key);
  @override
  State<ViewJobs> createState() => _ViewJobsState();
}

class _ViewJobsState extends State<ViewJobs> {
  TextEditingController name = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController addRess = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController englishLevel = TextEditingController();
  TextEditingController exp = TextEditingController();
  TextEditingController otherRequirements = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = widget.job.name;
    qty.text = widget.job.qty ?? "";
    salary.text = widget.job.salary ?? "";
    addRess.text = widget.job.addRess ?? "";
    age.text = widget.job.age ?? "";
    englishLevel.text = widget.job.englishLevel ?? "";
    exp.text = widget.job.exp ?? "";
    otherRequirements.text = widget.job.otherRequirements ?? "";
  }

  @override
  void dispose() {
    name.dispose();
    qty.dispose();
    salary.dispose();
    addRess.dispose();
    age.dispose();
    englishLevel.dispose();
    exp.dispose();
    otherRequirements.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          child: Row(
            children: [
              Text(
                '${widget.job.name}',
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.close,
          ),
        ),
      ]),
      content: Container(
        padding: EdgeInsets.only(right: 10, left: 10),
        width: 1200,
        height: 780,
        child: Column(
          children: [
            Row(children: [
              TextFieldValidated(
                type: "None",
                enabled: false,
                height: 40,
                label: 'Ngành nghề:',
                controller:
                    TextEditingController(text: widget.job.careers.name),
              ),
              SizedBox(width: 100),
              TextFieldValidated(
                type: "None",
                height: 40,
                enabled: false,
                label: 'Khu vực:',
                controller: TextEditingController(text: widget.provinceName),
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Ngày hết hạn:',
                enabled: false,
                controller: TextEditingController(
                    text: DateFormat('dd-MM-yyyy')
                        .format(DateTime.parse(widget.job.expirationDate!))),
              ),
              SizedBox(width: 100),
              TextFieldValidated(
                type: "None",
                height: 40,
                enabled: false,
                label: 'Địa điểm:',
                controller: addRess,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Số lượng:',
                enabled: false,
                controller: qty,
              ),
              SizedBox(width: 100),
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Mức lương:',
                enabled: false,
                controller: salary,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                enabled: false,
                label: 'Độ tuổi:',
                controller: age,
              ),
              SizedBox(width: 100),
              TextFieldValidated(
                type: "None",
                height: 40,
                enabled: false,
                label: 'Trình độ TA:',
                controller: englishLevel,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Y/C kinh nghiệm:',
                enabled: false,
                controller: exp,
              ),
              SizedBox(width: 100),
              TextFieldValidated(
                  type: "None",
                  height: 40,
                  label: 'Y/C khác:',
                  enabled: false,
                  controller: otherRequirements),
            ]),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(10)),
              height: 400,
              child: SingleChildScrollView(
                  child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Danh sách ứng viên',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Icon(Icons.more_horiz, color: Color(0xff9aa5ce), size: 14),
                  ],
                ),
                Divider(thickness: 1, color: Color(0xff9aa5ce)),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DataTable(
                              showCheckboxColumn: false,
                              columnSpacing: 5,
                              columns: [
                                DataColumn(
                                    label: Text('STT',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))),
                                DataColumn(
                                    label: Text('Họ tên',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))),
                                DataColumn(
                                    label: Text('Email',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))),
                                DataColumn(
                                    label: Text('SĐT',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))),
                                DataColumn(
                                    label: Text('CV',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))),
                                DataColumn(
                                    label: Text('Trạng thái',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))),
                                DataColumn(
                                    label: Text('Ghi chú',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700))),
                              ],
                              rows: <DataRow>[
                                for (var i = 0;
                                    i < widget.job.listRecruitment.length;
                                    i++)
                                  DataRow(
                                    cells: [
                                      DataCell(Text("${i + 1}")),
                                      DataCell(TextButton(
                                        onPressed: () {},
                                        child: Text(
                                            "${widget.job.listRecruitment[i].user!.fullname!}"),
                                      )),
                                      DataCell(Text(
                                          "${widget.job.listRecruitment[i].user!.email!}")),
                                      DataCell(Text(
                                          "${widget.job.listRecruitment[i].user!.sdt!}")),
                                      DataCell(IconButton(
                                        icon: Icon(Icons.file_download),
                                        onPressed: () {
                                          downloadFile(widget.job
                                              .listRecruitment[i].user!.cv!);
                                        },
                                      )),
                                      DataCell(TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  ComfimPv(
                                                    recruitment: widget
                                                        .job.listRecruitment[i],
                                                    callBackRecruiment:
                                                        (value) {
                                                      setState(() {
                                                        widget.job
                                                                .listRecruitment[
                                                            i] = value;
                                                      });
                                                    },
                                                  ));
                                        },
                                        child: Text((widget
                                                    .job
                                                    .listRecruitment[i]
                                                    .status ==
                                                0)
                                            ? "Ứng tuyển"
                                            : (widget.job.listRecruitment[i]
                                                        .status ==
                                                    2)
                                                ? "Chờ phỏng vấn"
                                                : (widget.job.listRecruitment[i]
                                                            .status ==
                                                        3)
                                                    ? "Trúng tuyển"
                                                    : "Huỷ"),
                                      )),
                                      DataCell(
                                        Text((widget.job.listRecruitment[i]
                                                    .status ==
                                                0)
                                            ? ""
                                            : (widget.job.listRecruitment[i]
                                                        .status ==
                                                    2)
                                                ? "PV: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.job.listRecruitment[i].pv!.substring(0,10)))}"
                                                : (widget.job.listRecruitment[i]
                                                            .status ==
                                                        3)
                                                    ? "Pass: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.job.listRecruitment[i].applyDate.toString()))}"
                                                    : "Fail: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.job.listRecruitment[i].applyDate.toString()))}"),
                                      ),
                                    ],
                                  )
                              ]),
                        ),
                      ],
                    ),
                  ],
                )
              ])),
            )
          ],
        ),
      ),
    );
  }
}
