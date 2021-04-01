import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/screens/home_screen/components/bottom_tabs.dart';
import 'package:hospital_app/screens/tabs/cart_tab.dart';
import 'package:hospital_app/screens/tabs/home_tab.dart';
import 'package:hospital_app/screens/tabs/notifi_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView(
            controller: _tabPageController,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
              });
            },
            children: [
              HomeTab(),
              NotificationTab(),
              //Center(child: Text("Cart"),),
              CartTab(),
              Center(
                child: Text("Profile"),
              )
            ],
          ),
        ),
        Align(
          child: Bottomtabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              _tabPageController.animateToPage(num,
                  duration: kAnimationDuration, curve: Curves.easeOutCubic);
            },
          ),
          alignment: Alignment.bottomCenter,
        ),
      ],
    ));
  }
}
