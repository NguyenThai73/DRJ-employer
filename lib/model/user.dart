// Future<List<Depart>> getPhongBan() async {
//   List<Depart> resultPhongBan = [];
//   var response1 = await httpGet("/api/phongban/get/page?sort=id,asc&filter=parentId:0 and id>2 and status:1", context);
// if (response1.containsKey("body")) {
//   var body = jsonDecode(response1['body']);
//   var content = [];
//   setState(() {
//     content = body['content'];
//     resultPhongBan = content.map((e) {
//       return Depart.fromJson(e);
//     }).toList();
//     Depart all = new Depart(id: -1, departName: "Tất cả");
//     resultPhongBan.insert(0, all);
//   });
// }
//   return resultPhongBan;
// }

import 'package:intl/intl.dart';

class User {
  int? id;
  String? email;
  String? fullname;
  String? birthday;
  String? sdt;
  int? gender;
  String? idCardNo;
  String? addRess;
  String? cv;
  String? avatar;
  String? career;
  int? status;
  int? height;

  User({
    this.id,
    this.email,
    this.fullname,
    this.birthday,
    this.sdt,
    this.gender,
    this.idCardNo,
    this.addRess,
    this.cv,
    this.avatar,
    this.career,
    this.status,
    this.height,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      fullname: json['fullname'],
      birthday: (json['birthday'] != null && json['birthday'] != "")
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(json['birthday']).toLocal())
          : null,
      sdt: json['sdt'],
      gender: json['gender'],
      idCardNo: json['idCardNo'],
      addRess: json['addRess'],
      cv: json['cv'],
      avatar: json['avatar'],
      career: json['career'],
      status: json['status'],
      height: json['height'],
    );
  }
  Map<String, dynamic> toMap(birthdayFormat) {
    return {
      "fullname": fullname,
      "birthday": (birthdayFormat != "") ? birthdayFormat : null,
      "sdt": sdt,
      "gender": gender,
      "idCardNo": idCardNo,
      "addRess": addRess,
      "cv": cv,
      "avatar": avatar,
      "career": career,
      "height": height
    };
  }
}
