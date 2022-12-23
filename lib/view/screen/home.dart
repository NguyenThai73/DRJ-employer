// ignore_for_file: no_logic_in_create_state

import 'package:atbmtptpmdd_employer/controllers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'menu.dart';

class HomeScreen extends StatefulWidget {
  int? idEmployer;
  HomeScreen({Key? key, this.idEmployer}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showMenu = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<Employer>(
        builder: (context, user, child) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                      if (showMenu) {
                        showMenu = false;
                      } else {
                        showMenu = true;
                      }
                    });
                  },
                  icon: const Icon(Icons.menu_open),
                ),
              ),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(
                  children: [
                    (showMenu)
                        ? SideMenu(
                            callBackIndex: (value) {
                              print(value);
                            },
                          )
                        : Container(),
                    Expanded(
                      child: Container(
                        // width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Text("Alooooo:${user.authorization}"),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
