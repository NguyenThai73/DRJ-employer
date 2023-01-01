import 'package:atbmtptpmdd_employer/model/recruitment.dart';
import 'careers.dart';
import 'employer.dart';

class Jobs {
  int? id;
  EmployerLogin employer;
  Careers careers;
  String name;
  String? qty;
  String? salary;
  String? age;
  String? englishLevel;
  String? exp;
  String? expirationDate;
  String? otherRequirements;
  String? addRess;
  int? provinceCode;
  int? status;
  List<Recruitment> listRecruitment;
  Jobs({
    this.id,
    required this.employer,
    required this.careers,
    required this.name,
    this.qty,
    this.salary,
    this.age,
    this.englishLevel,
    this.expirationDate,
    this.otherRequirements,
    this.provinceCode,
    this.status,
    this.exp,
    this.addRess,
    required this.listRecruitment
  });
  factory Jobs.fromJson(Map<dynamic, dynamic> json) {
    return Jobs(
      id: json['id'],
      employer: EmployerLogin.fromJson(json['employerName']),
      careers: Careers.fromJson(json['careerName']),
      qty: json['qty'] ?? "",
      name: json['name'] ?? "",
      salary: json['salary'] ?? "",
      age: json['age'] ?? "",
      englishLevel: json['englishLevel'] ?? "",
      expirationDate: json['expirationDatety'] ?? "",
      otherRequirements: json['otherRequirements'] ?? "",
      addRess: json['addRess'] ?? "",
      provinceCode: json['provinceCode'],
      status: json['status'],
      exp: json['exp'] ?? "",
      listRecruitment:[]
    );
  }
}
