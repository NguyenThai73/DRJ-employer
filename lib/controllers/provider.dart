import 'package:flutter/cupertino.dart';
import '../model/employer.dart';

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
