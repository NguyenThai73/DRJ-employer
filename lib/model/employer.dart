class EmployerLogin {
  int? id;
  String? name;
  String? userName;
  String? avatar;
  String? logo;
  String? addRess;
  String? sdt;
  String? email;
  String? career;
  String? scale;
  String? introduce;
  int? status;
  EmployerLogin({
    this.id,
    this.name,
    this.userName,
    this.avatar,
    this.logo,
    this.addRess,
    this.sdt,
    this.email,
    this.career,
    this.scale,
    this.introduce,
    this.status,
  });

  factory EmployerLogin.fromJson(Map<dynamic, dynamic> json) {
    return EmployerLogin(
      id: json['infor']['id'],
      email: json['infor']['email'],
      name: json['infor']['name'],
      sdt: json['infor']['sdt'],
      userName: json['infor']['userName'],
      avatar: json['infor']['avatar'],
      logo: json['infor']['logo'],
      addRess: json['infor']['addRess'],
      introduce: json['infor']['introduce'],
      career: json['infor']['career'],
      status: json['infor']['status'],
      scale: json['infor']['scale'],
    );
  }
}
