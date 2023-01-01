import 'package:flutter/cupertino.dart';
import '../model/employer.dart';
import 'dart:html';
import 'package:flutter/material.dart';

class Employer with ChangeNotifier {
  String authorization = "";
  EmployerLogin emloyer = EmployerLogin();

  changeAuthorization(String authorizationNew) {
    authorization = authorizationNew;
    notifyListeners();
  }

  changeUser(EmployerLogin emloyerUser) {
    emloyer = emloyerUser;
    notifyListeners();
  }
}

class LocalStorage {
  final Storage _localStorage = window.localStorage;
  Future saveAuthorization(String authorization) async {
    _localStorage['authorization'] = authorization;
  }

  String getAuthorization() => _localStorage['authorization'] ?? "";

  Future rmAuthorization() async {
    _localStorage.remove('authorization');
  }

  Future saveId(String id) async {
    _localStorage['id'] = id;
  }

  String getId() => _localStorage['id'] ?? "";

  Future rmId() async {
    _localStorage.remove('id');
  }
}
