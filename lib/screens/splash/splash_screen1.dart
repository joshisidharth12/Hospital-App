import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/screens/splash/splash_screen2.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {

  static String routeName = "/splash1";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.push(
            context,
            PageTransition(
                child: SplashScreen2(), type: PageTransitionType.fade)));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: kPrimaryGradientColor,
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
                "assets/images/white_logo.png",
                width: getProportionateScreenWidth(74),
              ),
              Text(
                "Company\nname",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenHeight(28),
                    fontFamily: "Overpass Bold"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(second: 1), child: DetailScreen()));
