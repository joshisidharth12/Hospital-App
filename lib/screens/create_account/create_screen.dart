import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/otp/otp_screen.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class CreateAccount extends StatelessWidget {
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
            Spacer(
              flex: 1,
            ),
            Row(
              children: [
                Text(
                  "Create your account",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenHeight(32),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Your Name",
            )),
            Spacer(
              flex: 1,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                  counterText: "",
                )),
            Spacer(
              flex: 1,
            ),
            TextFormField(
                decoration: InputDecoration(
              labelText: "Email",
            )),
            Spacer(),
            TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: Icon(Icons.remove_red_eye_outlined))),
            Spacer(),
            DefaultButton(
              text: "CREATE ACCOUNT",
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: OtpScreen(),
                        type: PageTransitionType.rightToLeft,
                        duration: kAnimationDuration));
              },
            ),
            Spacer(
              flex: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey[500],
                  ),
                  Text(
                    "Already have account?  Login",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: getProportionateScreenHeight(14)),
                  )
                ],
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
