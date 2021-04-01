import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/create_account/create_screen.dart';
import 'package:hospital_app/screens/login/login_screen.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class Signup extends StatelessWidget {
  //static String routeName = "/signup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(
              //   height: getProportionateScreenHeight(50),
              // ),
              Spacer(flex: 2,),
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
                "Welcome to company name",
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
                  Navigator.push(context, PageTransition(
                      child: CreateAccount(),
                      type: PageTransitionType.rightToLeft,
                      duration: kAnimationDuration));
                },
              ),
              Spacer(),
              Container(
                height: getProportionateScreenHeight(50),
                width: getProportionateScreenWidth(311),
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(47)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/facebook.png",
                      width: getProportionateScreenWidth(18),
                    ),
                    Text(
                      "CONTINUE WITH FACEBOOK",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13),
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFDBDBDB)),
                    borderRadius: BorderRadius.circular(57)),
              ),
              Spacer(),
              Container(
                height: getProportionateScreenHeight(50),
                width: getProportionateScreenWidth(311),
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(47)),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/google-hangouts.png",
                      width: getProportionateScreenWidth(18),
                    ),
                    Text(
                      "CONTINUE WITH GOOGLE",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13),
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFDBDBDB)),
                    borderRadius: BorderRadius.circular(57)),
              ),
              //Google

              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, PageTransition(child: LoginScreen(),
                      type: PageTransitionType.rightToLeft,
                      duration: kAnimationDuration));
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: getProportionateScreenHeight(14),
                      color: Colors.grey[600]),
                ),
              ),
              Spacer(flex: 2,)
            ],
          ),
        )
    );
  }
}
