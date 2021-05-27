import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/home_screen/home_screen.dart';
import 'package:hospital_app/size_config.dart';

class SignUpOption extends StatefulWidget {
  //static String routeName = "/signup";

  @override
  _SignUpOptionState createState() => _SignUpOptionState();
}

class _SignUpOptionState extends State<SignUpOption> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloggedin = false;

  User user;

  checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  void initState() {
    this.checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: getProportionateScreenHeight(50),
          // ),
          Spacer(
            flex: 2,
          ),
          Image.asset(
            "assets/images/welcomesignup.png",
            height: getProportionateScreenHeight(282),
            width: getProportionateScreenWidth(255),
          ),
          // SizedBox(
          //   height: getProportionateScreenHeight(34),
          // ),
          Spacer(),
          Text(
            "Welcome to Hospital Helper",
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.w700),
          ),
          // SizedBox(
          //   height: getProportionateScreenHeight(16),
          // ),
          Spacer(),
          Text(
            "Do you want some help with your\nhealth to get better life?",
            textAlign: TextAlign.center,
          ),
          // SizedBox(
          //   height: getProportionateScreenHeight(34),
          // ),
          Spacer(),
          DefaultButton(
            text: "SIGN UP WITH EMAIL",
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'SignUp');
            },
          ),
          Spacer(),
          DefaultButton(
            text: "LOGIN",
            onPressed: () {
              Navigator.pushReplacementNamed(context,'Login');
            },
          ),
          Spacer(
            flex: 2,
          )
        ],
      ),
    ));
  }
}
