// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_build_context_synchronously, unused_local_variable, must_be_immutable, unused_element
import 'dart:convert';
import 'package:atbmtptpmdd_employer/controllers/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/provider.dart';
import '../../../model/employer.dart';
import '../home.dart';
import 'login-body.dart';

class LoginScreen extends StatefulWidget {
  String? email;
  LoginScreen({Key? key, this.email}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email ?? "";
    _passwordController.text = "";
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
      builder: (context, user, child) => Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/1.jpg"), fit: BoxFit.fill),
              color: Color.fromARGB(255, 54, 154, 236)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoginScreenBody(
                controller: _emailController,
                passWordController: _passwordController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      child: const Text('Đăng nhập'),
                      onPressed: () async {
                        processing();
                        var requestBody = {
                          "userName": _emailController.text,
                          "password": _passwordController.text
                        };
                        var response =
                            await httpPostLogin(requestBody, context);
                        var body = jsonDecode(response['body']);
                        if (body['success']) {
                          EmployerLogin emloyer = EmployerLogin.fromJson(body);
                          user.changeAuthorization(body['accessToken']);
                          user.changeUser(emloyer);
                          LocalStorage().saveAuthorization(body['accessToken']);
                          LocalStorage().saveId(emloyer.id.toString());
                          // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
                          Navigator.pushNamed(context, "/home",
                              arguments: HomeScreen());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(body['message']),
                            backgroundColor: Colors.blue,
                          ));
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Chưa có tài khoản?",
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/sign");
                      },
                      child: Text("Đăng ký")),
                  const SizedBox(width: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
