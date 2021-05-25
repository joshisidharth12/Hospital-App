import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/create_account/CreateAcc.dart';
import 'package:hospital_app/screens/login/login_screen.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpOption extends StatefulWidget {
  //static String routeName = "/signup";

  @override
  _SignUpOptionState createState() => _SignUpOptionState();
}


class _SignUpOptionState extends State<SignUpOption> {

  SharedPreferences preferences;
  @override
  void initState() {
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
              DefaultButton(
                text: "LOGIN",
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
              Spacer(flex: 2,)
            ],
          ),
        )
    );
  }
}
