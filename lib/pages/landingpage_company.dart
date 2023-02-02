import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'navigation_page_company/addpage.dart';
import 'navigation_page_company/favoritepage.dart';
import 'navigation_page_company/homepage.dart';
import 'navigation_page_company/messagepage.dart';
import 'navigation_page_company/settingpage.dart';

class LandingPageCompany extends StatefulWidget {

  @override
  State<LandingPageCompany> createState() => _LandingPageCompanyState();
}

class _LandingPageCompanyState extends State<LandingPageCompany> {
  int index = 0;

  final screens = [
    HomePage(),
    FavoritePage(),
    AddPage(),
    MessagePage(),
    SettingPage(),
  ];

  final items = <Widget>[
    Icon(Icons.home),
    Icon(Icons.favorite),
    Icon(Icons.add),
    Icon(Icons.message),
    Icon(Icons.settings),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: items,
        height: 60,
        animationCurve: Curves.easeOut,
        animationDuration: Duration(milliseconds: 300),
        index: index,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
