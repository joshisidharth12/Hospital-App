import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/otp/components/otp_form.dart';
import 'package:hospital_app/screens/verified_screen/verified_screen.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class OtpScreen extends StatelessWidget {
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
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            Row(
              children: [
                Text(
                  "Enter the verify code",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenHeight(32),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(8),
            ),
            Row(
              children: [
                Text(
                  "We just send you a verification code via phone\n+65 556 798 ***",
                  style: TextStyle(fontSize: getProportionateScreenHeight(14)),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            OtpForm(),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            DefaultButton(text: "SUBMIT CODE", onPressed: () {
              Navigator.push(context, PageTransition(
                  child: VerifiedScreen(), type: PageTransitionType.rightToLeft,duration: kAnimationDuration));
            },),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("The code will expire in"),
                // TweenAnimationBuilder(
                //   tween: Tween(begin: 30, end: 0),
                //   duration: Duration(seconds: 30),
                //   onEnd: () {},
                // ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(15),
            ),
            Text(
              "Resent Code",
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: getProportionateScreenWidth(14)),
            )
          ],
        ),
      ),
    );
  }
}
