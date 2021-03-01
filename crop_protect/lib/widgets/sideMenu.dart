import 'package:crop_protect/views/govtSchemes.dart';
import 'package:crop_protect/widgets/myColorPallete.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: ColorPallete.bg),
            accountName: Text(
              "User 1",
              style: TextStyle(
                fontFamily: "PoppinsMedium",
                fontSize: 22,
              ),
            ),
            accountEmail: Text(
              "mobile number",
              style: TextStyle(
                fontFamily: "PoppinsMedium",
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.book_rounded),
            title: Text(
              "Government Schemes",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GovtSchemes(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.public_rounded),
            title: Text(
              "Farmar Portal",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 20,
              ),
            ),
            onTap: () async {
              String url = "https://farmer.gov.in/";
              if (await canLaunch(url)) {
                await launch(url, forceSafariVC: false, forceWebView: false);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }
}
