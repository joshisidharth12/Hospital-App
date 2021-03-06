import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/screens/home_screen/components/bottom_tabs.dart';
import 'package:hospital_app/screens/tabs/home_tab.dart';
import 'package:hospital_app/screens/tabs/notifi_tab.dart';
import 'package:hospital_app/screens/tabs/profileTab.dart';

class HomePage extends StatefulWidget {

  final String location;

  HomePage({this.location});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabPageController = PageController();
  }

  @override
  void dispose() {
    _tabPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.location);
    return Scaffold(
        bottomNavigationBar: Bottomtabs(
          selectedTab: _selectedTab,
          tabPressed: (num) {
            _tabPageController.animateToPage(num,
                duration: kAnimationDuration, curve: Curves.easeOutCubic);
          },
        ),
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
                  HomeTab(
                    location: widget.location,
                  ),
                  //Center(child: Text("Cart"),),
                  NotificationTab(),
                  ProfileTab()
                ],
              ),
            ),
          ],
        ));
  }
}
