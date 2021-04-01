import 'package:flutter/material.dart';

import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/home_screen/home_screen.dart';

import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';


class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding:
        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20),),
            Row(
              children: [
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenHeight(32),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(41),),
            TextFormField(
                decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Image.asset(
                      "assets/images/profile.png",
                      height: getProportionateScreenHeight(7),
                    ))),
            SizedBox(height: getProportionateScreenHeight(33),),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    suffixText: "Forgot?",
                    prefixIcon: Image.asset(
                      "assets/images/lock.png",
                      height: getProportionateScreenHeight(16),
                    ))),
            Spacer(),
            DefaultButton(text: "LOGIN", onPressed: () {
              Navigator.push(context, PageTransition(child: HomePage(),
                  type: PageTransitionType.rightToLeft,
                  duration : kAnimationDuration
                  ));
            },),
            Spacer(flex: 8,),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.grey[500],),
                  Text("Don’t have an account? Sign Up", style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: getProportionateScreenHeight(14)
                  ),)
                ],
              ),
            ),
            SizedBox(height: 15,)
          ],
        ),
      ),
    );
  }
}
