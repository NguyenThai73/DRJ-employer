// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, sort_child_properties_last, must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../controllers/api.dart';
import '../../../model/recruitment.dart';
import '../../common/input-text.dart';
import '../../common/select-date.dart';
import '../../common/toast.dart';

class ComfimPv extends StatefulWidget {
  Recruitment recruitment;
  Function? callBackRecruiment;
  ComfimPv({Key? key, required this.recruitment, this.callBackRecruiment})
      : super(key: key);
  @override
  State<ComfimPv> createState() => _ComfimPvState();
}

class _ComfimPvState extends State<ComfimPv> {
  Map<int, String> appRove = {
    0: "Ứng tuyển",
    2: "Chờ phỏng vấn",
    3: "Trúng tuyển",
    4: "Huỷ"
  };
  int seleterappRove = 0;
  String? pvDate;
  TextEditingController pvNote = TextEditingController();
  @override
  void initState() {
    super.initState();
    seleterappRove = widget.recruitment.status!;
    if (widget.recruitment.pv != null) {
      pvDate = widget.recruitment.pv!.substring(0, 10);
      pvNote.text = widget.recruitment.pv!.substring(10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Trạng thái',
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
        width: 500,
        height: 211,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(flex: 3, child: Text("Trạng thái")),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.11,
                    height: 40,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        dropdownMaxHeight: 250,
                        items: appRove.entries
                            .map((item) => DropdownMenuItem<int>(
                                value: item.key, child: Text(item.value)))
                            .toList(),
                        value: seleterappRove,
                        onChanged: (value) {
                          setState(() {
                            seleterappRove = value as int;
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
            SizedBox(height: 30),
            (seleterappRove == 2)
                ? Column(
                    children: [
                      Row(children: [
                        DatePickerBox(
                          flexLabel: 3,
                          label: Text(
                            "Ngày phỏng vấn:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          realTime: pvDate,
                          callbackValue: (value) {
                            setState(() {
                              pvDate = value;
                            });
                          },
                        ),
                      ]),
                      SizedBox(height: 30),
                      Row(children: [
                        TextFieldValidated(
                            flexLable: 3,
                            type: "None",
                            height: 40,
                            label: 'Ghi chú:',
                            controller: pvNote),
                      ]),
                    ],
                  )
                : Row(),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            var requestBody = {};
            Recruitment item = widget.recruitment;
            if (seleterappRove == 0) {
              requestBody = {
                "status": 0,
                "apply": 0,
                "applyNote": null,
                "applyDate": null,
                "des": null
              };
              item.status = 0;
              item.apply = 0;
              item.applyNote = null;
              item.applyDate = null;
              item.pv = null;
            } else if (seleterappRove == 2) {
              requestBody = {
                "status": 2,
                "apply": 0,
                "applyNote": null,
                "applyDate": null,
                "des": pvDate ?? "" + pvNote.text,
              };
              item.status = 2;
              item.apply = 0;
              item.applyNote = null;
              item.applyDate = null;
              item.pv = pvDate ?? "" + pvNote.text;
            } else if (seleterappRove == 3) {
              requestBody = {
                "status": 3,
                "apply": 1,
                "applyNote": null,
                "applyDate": DateTime.now().toLocal().toString(),
                "des": null,
              };
              item.status = 3;
              item.apply = 0;
              item.applyNote = null;
              item.applyDate = DateTime.now().toLocal().toString();
              item.pv = null;
            } else if (seleterappRove == 4) {
              requestBody = {
                "status": 3,
                "apply": 0,
                "applyNote": null,
                "applyDate": DateTime.now().toLocal().toString(),
                "des": null,
              };
              item.status = 4;
              item.apply = 0;
              item.applyNote = null;
              item.applyDate = DateTime.now().toLocal().toString();
              item.pv = null;
            }
            var responsePut = await httpPut(
                "/api/recruitment/put/${widget.recruitment.id}",
                requestBody,
                context);

            widget.callBackRecruiment!(item);
            showToast(
              context: context,
              msg: "Cập nhật thành công",
              color: Color.fromARGB(255, 128, 249, 16),
              icon: const Icon(Icons.done),
            );
            Navigator.pop(context);
            // if (selecteCareers.id != 0 &&
            //     selecteProvince.code != 0 &&
            //     name.text != "" &&
            //     qty.text != "" &&
            //     salary.text != "" &&
            //     addRess.text != "" &&
            //     expirationDate != null) {
            //   var requestBody = {
            //     "career_id": selecteCareers.id,
            //     "employer_id": widget.idEmployer,
            //     "name": name.text,
            //     "qty": qty.text,
            //     "salary": salary.text,
            //     "addRess": addRess.text,
            //     "age": age.text,
            //     "englishLevel": englishLevel.text,
            //     "exp": exp.text,
            //     "expirationDate": expirationDate,
            //     "otherRequirements": otherRequirements.text,
            //     "provinceCode": selecteProvince.code,
            //     "status": 1
            //   };

            //   ≈
            // } else {
            //   showToast(
            //     context: context,
            //     msg: "Cần điền đủ thông tin",
            //     color: Color.fromARGB(255, 255, 213, 149),
            //     icon: const Icon(Icons.warning),
            //   );
            // }
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
