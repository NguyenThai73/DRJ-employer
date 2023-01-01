// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable, must_be_immutable, unused_element, unnecessary_string_interpolations, prefer_const_constructors_in_immutables, sort_child_properties_last
import 'dart:convert';
import 'package:atbmtptpmdd_employer/controllers/api.dart';
import 'package:atbmtptpmdd_employer/view/screen/jobs/view-jobs.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../controllers/provider.dart';
import '../../../model/careers.dart';
import '../../../model/employer.dart';
import '../../../model/jobs.dart';
import '../../../model/recruitment.dart';
import '../../../model/user.dart';
import '../../common/style.dart';
import 'add-jobs.dart';
import 'delete-jobs.dart';
import 'update-jobs.dart';

class JobsScreen extends StatefulWidget {
  JobsScreen({Key? key}) : super(key: key);

  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  List<Jobs> listJobs = [];
  Map<int, String> listProvinces = {};
  getProvinces() async {
    listProvinces = {};
    var response2 =
        await httpGetNo("https://provinces.open-api.vn/api/?depth=1", context);
    if (response2.containsKey("body")) {
      List<dynamic> body = response2['body'];
      for (var element in body) {
        listProvinces[element['code']] = element['name'];
      }
    }
    return listProvinces;
  }

  Future<List<Careers>> getNganhNghe() async {
    List<Careers> listCareer = [Careers(id: 0, name: "Tất cả", parentId: 0)];
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

  Careers selecteCareers = Careers(id: 0, name: 'Tất cả');
  Future<List<Jobs>> getListJobsSearch() async {
    List<Jobs> listJobsSearch = [];

    var id = LocalStorage().getId();
    var response = await httpGet("/api/job/employerId/$id", context);
    var body = jsonDecode(response['body']);
    // print("response123:$body");
    for (var element in body) {
      Jobs item = Jobs(
          id: element['id'],
          employer: EmployerLogin(),
          careers: Careers(),
          name: element['name'] ?? "",
          listRecruitment: []);
      setState(() {
        if (element['status'] == 1) {
          listJobsSearch.insert(0, item);
        } else {
          listJobsSearch.add(item);
        }
      });
    }
    listJobsSearch.insert(
        0,
        Jobs(
          id: 0,
          name: 'Tất cả',
          careers: Careers(),
          employer: EmployerLogin(),
          listRecruitment: [],
        ));
    return listJobsSearch;
  }

  Jobs seletedJobs = Jobs(
    id: 0,
    name: 'Tất cả',
    careers: Careers(),
    employer: EmployerLogin(),
    listRecruitment: [],
  );
  Map<int, String> statusTT = {
    2: "Tất cả",
    1: "Đang tuyển",
    0: "Đã tuyển xong"
  };
  int seletedTT = 2;
  getJobs() async {
    listJobs = [];
    var id = LocalStorage().getId();
    var response = await httpGet("/api/job/employerId/$id", context);
    var body = jsonDecode(response['body']);
    // print("response123:$body");
    for (var element in body) {
      Jobs item = Jobs(
          id: element['id'],
          employer: EmployerLogin(),
          careers: Careers(
              id: element['careerName']['id'],
              name: element['careerName']['name']),
          qty: element['qty'] ?? "",
          name: element['name'] ?? "",
          salary: element['salary'] ?? "",
          age: element['age'] ?? "",
          englishLevel: element['englishLevel'] ?? "",
          expirationDate: element['expirationDate'] ?? "",
          otherRequirements: element['otherRequirements'] ?? "",
          addRess: element['addRess'] ?? "",
          provinceCode: element['provinceCode'],
          status: element['status'],
          exp: element['exp'] ?? "",
          listRecruitment: []);
      var responseuser =
          await httpGet("/api/recruitment/job/${item.id}", context);
      var bodyuser = jsonDecode(responseuser['body']);
      for (var elementuser in bodyuser) {
        Recruitment itemRecruitment = Recruitment(
          id: elementuser['id'],
          status: elementuser['status'],
          apply: elementuser['apply'],
          applyNote: elementuser['applyNote'],
          applyDate: elementuser['applyDate'],
          pv: elementuser['des'],
          user: User(
            id: elementuser['user']['id'],
            email: elementuser['user']['email'],
            fullname: elementuser['user']['fullname'],
            birthday: (elementuser['user']['birthday'] != null &&
                    elementuser['user']['birthday'] != "")
                ? DateFormat('dd-MM-yyyy').format(
                    DateTime.parse(elementuser['user']['birthday']).toLocal())
                : null,
            sdt: elementuser['user']['sdt'],
            gender: elementuser['user']['gender'],
            idCardNo: elementuser['user']['idCardNo'],
            addRess: elementuser['user']['addRess'],
            cv: elementuser['user']['cv'],
            avatar: elementuser['user']['avatar'],
            career: elementuser['user']['career'],
            status: elementuser['user']['status'],
            height: elementuser['user']['height'],
          ),
        );
        item.listRecruitment.add(itemRecruitment);
      }
      setState(() {
        if (seletedJobs.id == 0) {
          if (selecteCareers.id == 0) {
            if (seletedTT == 2) {
              if (element['status'] == 1) {
                listJobs.insert(0, item);
              } else {
                listJobs.add(item);
              }
            } else {
              if (element['status'] == seletedTT) listJobs.add(item);
            }
          } else {
            if (seletedTT == 2) {
              if (element['status'] == 1 &&
                  item.careers.id == selecteCareers.id) {
                listJobs.insert(0, item);
              } else {
                if (item.careers.id == selecteCareers.id) listJobs.add(item);
              }
            } else {
              if (element['status'] == seletedTT &&
                  item.careers.id == selecteCareers.id) listJobs.add(item);
            }
          }
        } else {
          if (selecteCareers.id == 0) {
            if (seletedTT == 2) {
              if (element['id'] == seletedJobs.id) listJobs.add(item);
            } else {
              if (element['id'] == seletedJobs.id &&
                  element['status'] == seletedTT) listJobs.add(item);
            }
          } else {
            if (seletedTT == 2) {
              if (element['id'] == seletedJobs.id &&
                  item.careers.id == selecteCareers.id) listJobs.add(item);
            } else {
              if (element['id'] == seletedJobs.id &&
                  item.careers.id == selecteCareers.id &&
                  element['status'] == seletedTT) listJobs.add(item);
            }
          }
        }
      });
    }
  }

  bool statusData = false;
  void callApi() async {
    setState(() {
      statusData = false;
    });
    await getProvinces();
    await getJobs();
    setState(() {
      statusData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    callApi();
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
      builder: (context, user, child) => Container(
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
                    "Quản lý việc làm",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xffDADADA)),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 220, 220, 220).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Nhập thông tin',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Icon(Icons.more_horiz,
                            color: Color(0xff9aa5ce), size: 14),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Divider(thickness: 1, color: Color(0xff9aa5ce)),
                    ),
                    Row(children: [
                      SizedBox(width: 50),
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text('Tên:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.width *
                                        0.20,
                                    height: 40,
                                    child: DropdownSearch<Jobs>(
                                      maxHeight: 350,
                                      mode: Mode.MENU,
                                      showSearchBox: true,
                                      onFind: (String? filter) =>
                                          getListJobsSearch(),
                                      itemAsString: (Jobs? u) => u!.name,
                                      dropdownSearchDecoration: styleDropDown,
                                      selectedItem: seletedJobs,
                                      onChanged: (value) {
                                        setState(() {
                                          seletedJobs = value!;
                                        });
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 200),
                      Expanded(child: Container(), flex: 4)
                    ]),
                    Row(
                      children: [
                        SizedBox(width: 50),
                        Expanded(
                          flex: 3,
                          child: Container(
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
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      height: 40,
                                      child: DropdownSearch<Careers>(
                                        maxHeight: 350,
                                        mode: Mode.MENU,
                                        showSearchBox: true,
                                        onFind: (String? filter) =>
                                            getNganhNghe(),
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
                        ),
                        SizedBox(width: 200),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: Row(
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
                                    width: MediaQuery.of(context).size.width *
                                        0.11,
                                    height: 40,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                        dropdownMaxHeight: 250,
                                        items: statusTT.entries
                                            .map((item) =>
                                                DropdownMenuItem<int>(
                                                    value: item.key,
                                                    child: Text(item.value)))
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
                                                color: const Color.fromRGBO(
                                                    216, 218, 229, 1))),
                                        buttonDecoration: BoxDecoration(
                                            border: Border.all(
                                                width: 0.5,
                                                style: BorderStyle.solid)),
                                        buttonElevation: 0,
                                        buttonPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        itemPadding: const EdgeInsets.only(
                                            left: 14, right: 14),
                                        dropdownElevation: 5,
                                        focusColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(child: Container())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 150,
                          height: 40,
                          margin: EdgeInsets.only(right: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue),
                          child: TextButton(
                              onPressed: () {
                                callApi();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Tìm kiếm",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              )),
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          margin: EdgeInsets.only(right: 30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue),
                          child: TextButton(
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) => AddJobs(
                                          idEmployer: user.emloyer.id!,
                                        ));
                                callApi();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Icon(
                                    Icons.add,
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Thêm mới",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xffDADADA)),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromARGB(255, 220, 220, 220).withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          'Kết quả tìm kiếm: (${listJobs.length})',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Icon(Icons.more_horiz,
                            color: Color(0xff9aa5ce), size: 14),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 15),
                      child: Divider(thickness: 1, color: Color(0xff9aa5ce)),
                    ),
                    (statusData)
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: DataTable(
                                        showCheckboxColumn: false,
                                        columnSpacing: 5,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        columns: [
                                          DataColumn(
                                              label: Text('STT',
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          DataColumn(
                                              label: Text('Tiêu đề',
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          DataColumn(
                                              label: Text('Ngành nghề',
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          DataColumn(
                                              label: Text('Số lượng tuyển',
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          DataColumn(
                                              label: Text('Số lượng ứng viên',
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          DataColumn(
                                              label: Text('Trạng thái',
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                          DataColumn(
                                              label: Text('Hành động',
                                                  style: TextStyle(
                                                      color: Color(0xff333333),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w700))),
                                        ],
                                        rows: <DataRow>[
                                          for (var i = 0;
                                              i < listJobs.length;
                                              i++)
                                            DataRow(
                                              cells: [
                                                DataCell(Text("${i + 1}")),
                                                DataCell(Text(
                                                    "${listJobs[i].name}")),
                                                DataCell(Text(
                                                    "${listJobs[i].careers.name}")),
                                                DataCell(
                                                    Text("${listJobs[i].qty}")),
                                                DataCell(Text(
                                                    "${listJobs[i].listRecruitment.length}")),
                                                DataCell(Text(
                                                    "${(listJobs[i].status == 1) ? "Đang tuyển" : "Đã tuyển xong"}")),
                                                DataCell(Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                          context) =>
                                                                      ViewJobs(
                                                                        job: listJobs[
                                                                            i],
                                                                        provinceName:
                                                                            listProvinces[listJobs[i].provinceCode]!,
                                                                      ));
                                                        },
                                                        child: Icon(
                                                            Icons.visibility)),
                                                    SizedBox(width: 10),
                                                    InkWell(
                                                        onTap: () async {
                                                          await showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  UpdateJobs(
                                                                    job:
                                                                        listJobs[
                                                                            i],
                                                                    idEmployer: user
                                                                        .emloyer
                                                                        .id!,
                                                                    provinceName:
                                                                        listProvinces[
                                                                            listJobs[i].provinceCode]!,
                                                                  ));
                                                          callApi();
                                                        },
                                                        child: Icon(
                                                            Icons.edit_calendar,
                                                            color:
                                                                Colors.blue)),
                                                    SizedBox(width: 10),
                                                    InkWell(
                                                        onTap: () async {
                                                          await showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                          context) =>
                                                                      DeleteJob(
                                                                        id: listJobs[i]
                                                                            .id!,
                                                                            name: listJobs[i]
                                                                            .name
                                                                      ));
                                                          callApi();
                                                        },
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        )),
                                                  ],
                                                )),
                                              ],
                                            )
                                        ]),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator())
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
