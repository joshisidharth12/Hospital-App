import 'package:flutter/material.dart';

import 'package:hospital_app/screens/map_view/shop_location.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class Bottomtabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;

  Bottomtabs({this.selectedTab, this.tabPressed});

  @override
  _BottomtabsState createState() => _BottomtabsState();
}

class _BottomtabsState extends State<Bottomtabs> {
  int _selectedTabs;

  @override
  Widget build(BuildContext context) {
    _selectedTabs = widget.selectedTab ?? 0;

    return Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey[500],
            blurRadius: 30,
            spreadRadius: 1,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomTabBtn(
              iconPath: Icons.home_outlined,
              selected: _selectedTabs == 0 ? true : false,
              onPressed: () {
                widget.tabPressed(0);
              },
            ),
            BottomTabBtn(
              iconPath: Icons.notifications_none,
              selected: _selectedTabs == 1 ? true : false,
                onPressed: () {
                  widget.tabPressed(1);
                },
            ),
            BottomTabBtn(
              iconPath: Icons.medical_services,
              selected: _selectedTabs == 2 ? true : false,
                onPressed: () {
                  widget.tabPressed(2);
                },
            ),
            BottomTabBtn(
              iconPath: Icons.perm_identity_rounded,
              selected: _selectedTabs == 3 ? true : false,
              onPressed: () {
                widget.tabPressed(3);
              },
            ),
          ],
        ));
  }
}

class BottomTabBtn extends StatelessWidget {
  final IconData iconPath;
  final bool selected;
  final Function onPressed;

  BottomTabBtn({this.iconPath, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(20)),
        child: Icon(
          iconPath ?? Icons.home_outlined,
          size: getProportionateScreenHeight(30),
          color: _selected ? Color(0xFF4157FF) : Colors.black,
        ),
      ),
    );
  }
}
