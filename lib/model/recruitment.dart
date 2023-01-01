import 'package:atbmtptpmdd_employer/model/user.dart';

import 'jobs.dart';

class Recruitment {
  int? id;
  User? user;
  int? jobId;
  Jobs? job;
  int? status;
  int? apply;
  String? applyNote;
  String? applyDate;
  String? pv;
  Recruitment({
    this.id,
    this.user,
    this.jobId,
    this.job,
    this.status,
    this.apply,
    this.applyNote,
    this.applyDate,
    this.pv
  });
  factory Recruitment.fromJson(Map<dynamic, dynamic> json) {
    return Recruitment(
      id: json['id'],
      user: json['user_id'],
      jobId: json['jobs']['id'],
      status: json['status'],
      apply: json['apply'],
      applyNote: json['applyNote'],
      applyDate: json['applyDate'],
    );
  }
}
