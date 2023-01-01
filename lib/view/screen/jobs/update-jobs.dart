// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../../controllers/api.dart';
import '../../../model/careers.dart';
import '../../../model/jobs.dart';
import '../../../model/province.dart';
import '../../common/input-text.dart';
import '../../common/select-date.dart';
import '../../common/style.dart';
import '../../common/toast.dart';

class UpdateJobs extends StatefulWidget {
  int idEmployer;
  Jobs job;
  String provinceName;
  UpdateJobs(
      {Key? key,
      required this.job,
      required this.idEmployer,
      required this.provinceName})
      : super(key: key);
  @override
  State<UpdateJobs> createState() => _UpdateJobsState();
}

class _UpdateJobsState extends State<UpdateJobs> {
  Future<List<Province>> getProvinces() async {
    List<Province> listProvinces = [Province(code: 0, name: "Chọn")];
    var response2 =
        await httpGetNo("https://provinces.open-api.vn/api/?depth=1", context);
    if (response2.containsKey("body")) {
      List<dynamic> body = response2['body'];
      for (var element in body) {
        listProvinces
            .add(Province(code: element['code'], name: element['name']));
      }
    }
    return listProvinces;
  }

  Province selecteProvince = Province(code: 0, name: 'Chọn');
  Future<List<Careers>> getNganhNghe() async {
    List<Careers> listCareer = [Careers(id: 0, name: "Chọn", parentId: 0)];
    var response = await httpGet("/api/career/get", context);
    var body = jsonDecode(response['body']);
    for (var element in body) {
      Careers item = Careers(
        id: element['id'],
        name: element['name'],
        parentId: element['parentId'],
      );
      listCareer.add(item);
    }
    return listCareer;
  }

  Careers selecteCareers = Careers(id: 0, name: 'Chọn');
  String? expirationDate;

  TextEditingController name = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController addRess = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController englishLevel = TextEditingController();
  TextEditingController exp = TextEditingController();
  TextEditingController otherRequirements = TextEditingController();
  Map<int, String> statusTT = {
    1: "Đang tuyển",
    0: "Đã tuyển xong"
  };
  int seletedTT = 1;
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
    selecteCareers = widget.job.careers;
    expirationDate = widget.job.expirationDate;
    seletedTT = widget.job.status!;
    selecteProvince =
        Province(code: widget.job.provinceCode!, name: widget.provinceName);
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
                'Cập nhật công việc',
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
        width: 550,
        height: 710,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text('Ngành nghề:',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ),
                  Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: 40,
                        child: DropdownSearch<Careers>(
                          maxHeight: 350,
                          mode: Mode.MENU,
                          showSearchBox: true,
                          onFind: (String? filter) => getNganhNghe(),
                          itemAsString: (Careers? u) => u!.name!,
                          dropdownSearchDecoration: styleDropDown,
                          selectedItem: selecteCareers,
                          onChanged: (value) {
                            setState(() {
                              selecteCareers = value!;
                            });
                          },
                        ),
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text('Khu vực:',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                  ),
                  Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: 40,
                        child: DropdownSearch<Province>(
                          maxHeight: 350,
                          mode: Mode.MENU,
                          showSearchBox: true,
                          onFind: (String? filter) => getProvinces(),
                          itemAsString: (Province? u) => u!.name,
                          dropdownSearchDecoration: styleDropDown,
                          selectedItem: selecteProvince,
                          onChanged: (value) {
                            setState(() {
                              selecteProvince = value!;
                            });
                          },
                        ),
                      )),
                ],
              ),
            ),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Tiêu đề:',
                controller: name,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Địa điểm:',
                controller: addRess,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Số lượng:',
                controller: qty,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Mức lương:',
                controller: salary,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Độ tuổi:',
                controller: age,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Trình độ TA:',
                controller: englishLevel,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                type: "None",
                height: 40,
                label: 'Y/C kinh nghiệm:',
                controller: exp,
              ),
            ]),
            Row(children: [
              TextFieldValidated(
                  type: "None",
                  height: 40,
                  label: 'Y/C khác:',
                  controller: otherRequirements),
            ]),
            Row(children: [
              DatePickerBox(
                label: Text(
                  "Ngày hết hạn:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                realTime: expirationDate,
                callbackValue: (value) {
                  setState(() {
                    expirationDate = value;
                  });
                },
              ),
            ]),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('Trạng thái:',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.white,
                    // width: MediaQuery.of(context).size.width * 0.11,
                    height: 40,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        dropdownMaxHeight: 250,
                        items: statusTT.entries
                            .map((item) => DropdownMenuItem<int>(
                                value: item.key, child: Text(item.value)))
                            .toList(),
                        value: seletedTT,
                        onChanged: (value) {
                          setState(() {
                            seletedTT = value as int;
                          });
                        },
                        buttonHeight: 40,
                        itemHeight: 40,
                        dropdownDecoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(216, 218, 229, 1))),
                        buttonDecoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, style: BorderStyle.solid)),
                        buttonElevation: 0,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownElevation: 5,
                        focusColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (selecteCareers.id != 0 &&
                selecteProvince.code != 0 &&
                name.text != "" &&
                qty.text != "" &&
                salary.text != "" &&
                addRess.text != "" &&
                expirationDate != null) {
              var requestBody = {
                "career_id": selecteCareers.id,
                "employer_id": widget.idEmployer,
                "name": name.text,
                "qty": qty.text,
                "salary": salary.text,
                "addRess": addRess.text,
                "age": age.text,
                "englishLevel": englishLevel.text,
                "exp": exp.text,
                "expirationDate": expirationDate,
                "otherRequirements": otherRequirements.text,
                "provinceCode": selecteProvince.code,
                "status": seletedTT
              };
            await httpPut(
                  "/api/job/put/${widget.job.id}", requestBody, context);
              showToast(
                context: context,
                msg: "cập nhật thành công",
                color: Color.fromARGB(255, 128, 249, 16),
                icon: const Icon(Icons.done),
              );
              Navigator.pop(context);
            } else {
              showToast(
                context: context,
                msg: "Cần điền đủ thông tin",
                color: Color.fromARGB(255, 255, 213, 149),
                icon: const Icon(Icons.warning),
              );
            }
          },
          child: Text(
            'Lưu',
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
