// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/provider.dart';

class SideMenu extends StatefulWidget {
  Function callBackIndex;
  SideMenu({Key? key, required this.callBackIndex}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<Employer>(
        builder: (context, employer, child) => ListView(
          children: [
            DrawerHeader(
              child: CachedNetworkImage(
                imageUrl: employer.emloyer.logo ??
                    "https://media.istockphoto.com/id/1016744004/tr/vekt%C3%B6r/profil-yer-tutucu-resmi-gri-siluet-hi%C3%A7-bir-foto%C4%9Fraf.jpg?s=612x612&w=0&k=20&c=rK0pDALbkG0ZNNMPvkv7IYrDMDbEs6CO_a42y3LGOFY=",
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: Icon(Icons.dashboard),
              press: () {
                index = 0;
                widget.callBackIndex(index);
              },
            ),
            DrawerListTile(
              title: "Quản lý việc làm",
              svgSrc: Icon(Icons.work),
              press: () {
                index = 1;
                widget.callBackIndex(index);
              },
            ),
            DrawerListTile(
              title: "Quản lý ứng viên",
              svgSrc: Icon(Icons.group),
              press: () {
                index = 2;
                widget.callBackIndex(index);
              },
            ),
            DrawerListTile(
              title: "Các tiện ích",
              svgSrc: Icon(Icons.more_horiz),
              press: () {
                index = 3;
                widget.callBackIndex(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title;
  final Widget svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: svgSrc,
      title: Text(
        title,
        style: const TextStyle(color: Color.fromARGB(137, 53, 53, 53)),
      ),
    );
  }
}
