import 'package:flutter/material.dart';
import 'package:hospital_app/CustomInput.dart';
import 'package:hospital_app/Validators.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/home_screen/home_screen.dart';
import 'package:hospital_app/screens/otp/otp_screen.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  TextEditingController _namecontroller ;
  TextEditingController _emailcontroller ;
  TextEditingController _passcontroller ;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _namecontroller = TextEditingController();
    _emailcontroller = TextEditingController();
    _passcontroller = TextEditingController();
    super.initState();
  }

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
            Spacer(),
            Form(
              key: _formKey,
                child: Column(
                  children: [
                    CustomInput(
                      hintText: "Name",
                      iconImage: "assets/images/profile.png",
                      validation: validateName,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20),),
                    CustomInput(
                      hintText: "Email",
                      iconImage: "assets/images/profile.png",
                      keyBoardType: TextInputType.emailAddress,
                      validation: validateEmail,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20),),
                    CustomInput(
                      hintText: "Password",
                      iconImage: "assets/images/lock.png",
                      isPasswordField: true,
                      validation: validatePass,
                    ),
                  ],
                )
            ),
            Spacer(),
            DefaultButton(
              text: "CREATE ACCOUNT",
              onPressed: () {
                if(_formKey.currentState.validate()){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                }
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
