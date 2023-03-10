import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:proximity/colors/color.dart';
import 'package:proximity/pages/navigation_page_worker/homepage.dart';
import 'navigation_page_worker/addpage.dart';
import 'navigation_page_worker/favoritepage.dart';
import 'navigation_page_worker/messagepage.dart';
import 'navigation_page_worker/settingpage.dart';

class LandingPageWorker extends StatefulWidget {
  @override
  State<LandingPageWorker> createState() => _LandingPageWorkerState();
}

class _LandingPageWorkerState extends State<LandingPageWorker> {
  int index = 0;

  final screens = [
    HomePage(),
    FavoritePageWorker(),
    AddPage(),
    MessagePage(),
    SettingPage(),
  ];

  final items = <Widget>[
    Icon(Icons.home),
    Icon(Icons.favorite),
    Icon(Icons.person),
    Icon(Icons.message),
    Icon(Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: skyBlue,
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
