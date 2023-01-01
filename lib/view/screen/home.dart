// ignore_for_file: no_logic_in_create_state, must_be_immutable, library_private_types_in_public_api

import 'dart:convert';

import 'package:atbmtptpmdd_employer/controllers/provider.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/api.dart';
import '../../model/employer.dart';
import 'dasboad-screen/dasboad-screen.dart';
import 'employer-screen.dart/employer-screen.dart';
import 'jobs/jobs_screen.dart';

class HomeScreen extends StatefulWidget {
  int? idEmployer;
  HomeScreen({Key? key, this.idEmployer}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showMenu = true;
  getEmployerLogin() async {
    var employer = Provider.of<Employer>(context, listen: false);
    var authorization = LocalStorage().getAuthorization();
    employer.changeAuthorization(authorization);
    var id = LocalStorage().getId();
    var response = await httpGet("/api/employer/$id", context);
    if (response.containsKey("body")) {
      var body = jsonDecode(response['body']);
      EmployerLogin emloyerNew = EmployerLogin.fromJson1(body);
      employer.changeUser(emloyerNew);
    }
  }

  bool statusData = false;
  void callAPI() async {
    setState(() {
      statusData = false;
    });
    await getEmployerLogin();
    setState(() {
      statusData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  PageController page = PageController();
  @override
  Widget build(BuildContext context) {
    return Consumer<Employer>(
      builder: (context, employer, child) => Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SideMenu(
              controller: page,
              style: SideMenuStyle(
                  displayMode: SideMenuDisplayMode.open,
                  hoverColor: Colors.blue[100],
                  selectedColor: Colors.lightBlue,
                  selectedTitleTextStyle: const TextStyle(color: Colors.white),
                  selectedIconColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 124, 147, 158)),
              title: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    height: 220,
                    color: Color.fromARGB(255, 76, 76, 76),
                    child: Image.network(
                      "${employer.emloyer.logo}",
                      height: 170,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                ],
              ),
              footer: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Nhóm 22',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              items: [
                // SideMenuItem(
                //   priority: 0,
                //   title: 'Dashboard',
                //   onTap: () {
                //     page.jumpToPage(0);
                //   },
                //   icon: const Icon(Icons.home),
                // ),
                SideMenuItem(
                  priority: 0,
                  title: 'Quản lý việc làm',
                  onTap: () {
                    page.jumpToPage(0);
                  },
                  icon: const Icon(Icons.business_center),
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'Thiết lập cá nhân',
                  onTap: () {
                    page.jumpToPage(1);
                  },
                  icon: const Icon(Icons.account_circle),
                ),
                SideMenuItem(
                  priority: 7,
                  title: 'Exit',
                  onTap: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: page,
                children: [
                  // DashboardScreen(),
                  JobsScreen(),
                  EmployerScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
