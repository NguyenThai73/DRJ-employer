// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:convert';
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

class AddJobs extends StatefulWidget {
  int idEmployer;
  Jobs? job;
  AddJobs({Key? key, this.job, required this.idEmployer}) : super(key: key);
  @override
  State<AddJobs> createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
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
    var response1 = await httpGet("/api/career/get", context);
    var body1 = jsonDecode(response1['body']);
    for (var element in body1) {
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

  @override
  void initState() {
    super.initState();
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
                'Thêm công việc',
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
        height: 661,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 30),
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
              margin: EdgeInsets.only(bottom: 30),
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
                "status": 1
              };
              await httpPost("/api/job/post", requestBody, context);
              showToast(
                context: context,
                msg: "Thêm mới thành công",
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
