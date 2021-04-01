import 'dart:async';

import 'package:flutter/material.dart';

import 'package:hospital_app/screens/onboarding/OnBoardingBody.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen2 extends StatefulWidget {

  static String routeName = "/splash1";

  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
            () => Navigator.push(
            context,
            PageTransition(
                child: OnBoardingBody(), type: PageTransitionType.rightToLeft)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  "assets/images/background.png",
                  fit: BoxFit.cover,
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/purple_logo.png",
                width: getProportionateScreenWidth(74),
              ),
              Text(
                "Company\nname",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenHeight(28),
                    fontFamily: "Overpass Bold",
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
