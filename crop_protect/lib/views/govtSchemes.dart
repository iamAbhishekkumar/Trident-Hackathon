import 'package:crop_protect/widgets/myColorPallete.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GovtSchemes extends StatefulWidget {
  @override
  _GovtSchemesState createState() => _GovtSchemesState();
}

class _GovtSchemesState extends State<GovtSchemes> {
  List _listOfSchemes = [
    [
      "Pradhan Mantri Fasal Bima Yojana",
      "images/PMFBY.png",
      "It is an actual premium based scheme where farmer has to pay maximum premium of 2% for Kharif , 1.5%  for Rabi and 5% for horticultural crops .",
      "Its main aim is to facilitate quick claims settlement and even give share of premium subsidy by the State Government .",
      "https://pmfby.gov.in/"
    ],
    [
      "Pradhan Mantri Kisaan Maan-dhan Yojana",
      "images/PMKMY.png",
      "This Scheme is launched by the present PM of our country Sri Narendra Modi .",
      "Its helps 5 Crore marginalised farmers by providing them Rs 3000 per month as pension on attaining the age of 60.",
      "https://pmkmy.gov.in/",
    ],
    [
      "Prime Minister Krishi Sinchayee Yojana",
      "images/PMKSY.png",
      "Government of India is committed to accord high priority to water conservation and its management. ",
      "To this effect Pradhan Mantri Krishi Sinchayee Yojana has been formulated with the vision of extending the coverage of irrigation 'Har Khet ko pani' and improving water use efficiency 'More crop per drop' in a focused manner with end to end solution on source creation, distribution, management, field application and extension activities.",
      "http://pmksy.gov.in/",
    ],
    [
      "Livestock insurance Scheme",
      "images/LI.png",
      "This scheme aims to provide protection mechanism to the farmers and cattle rearers against any eventual loss of their animals due to death and to demonstrate the benefit of the insurance of livestock to the people and popularize it with the ultimate goal of attaining qualitative improvement in livestock and their products.",
      "The Livestock Insurance Scheme, a centrally sponsored scheme was implemented on a pilot basis during 2005-06 and 2006-07 of the 10th Five Year Plan and 2007-08 of the 11th Five Year Plan in 100 selected districts. The scheme was later implemented on a regular basis from 2008-09 in 100 newly selected districts of the country.",
      "https://www.pashudhanpraharee.com/",
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPallete.bg,
          title: Text(
            "Government Schemes",
            style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 22),
          ),
        ),
        body: buildSchemeCard());
  }

  Widget buildSchemeCard() {
    return ListView(
      children: _listOfSchemes.map((element) => buildcard(element)).toList(),
    );
  }

  Widget buildcard(List element) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ExpansionTile(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              element[2],
              style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 18),
            ),
          ),
          InkWell(
            onTap: () => launchURL(element[4]),
            child: Container(
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.all(5),
              child: Text("Official site",
                  style: TextStyle(
                      fontFamily: "PoppinsMedium",
                      fontSize: 20,
                      color: Colors.blue,
                      decoration: TextDecoration.underline)),
            ),
          )
        ],
        subtitle: Text(
          element[3],
          style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 18),
        ),
        title: Row(
          children: [
            Expanded(
              child: Container(
                child: Image.asset(element[1]),
                height: 100,
              ),
            ),
            Expanded(
              child: Text(
                element[0],
                style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 21),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
