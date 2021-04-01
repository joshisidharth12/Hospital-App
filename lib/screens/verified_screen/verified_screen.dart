import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/home_screen/home_screen.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class VerifiedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          children: [
            Spacer(flex: 2,),
            Image.asset(
              "assets/images/regisSuccess.png",
              height: getProportionateScreenHeight(200.57),
              width: getProportionateScreenWidth(260.18),
            ),
            SizedBox(
              height: getProportionateScreenHeight(51.29),
            ),
            Text("Phone Number Verified",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: getProportionateScreenHeight(24))),
            SizedBox(
              height: getProportionateScreenHeight(16),
            ),
            Text(
              "Congradulations, your phone number has been verified. You can start using the app",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: getProportionateScreenHeight(16)),
            ),
            Spacer(flex: 2,),
            DefaultButton(text: "CONTINUE",onPressed: (){
              Navigator.push(context, PageTransition(
                  child: HomePage(), type: PageTransitionType.rightToLeft,duration: kAnimationDuration));
            },),
            Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}
