import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/CustomInput.dart';
import 'package:hospital_app/Validators.dart';

import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';

import 'package:hospital_app/size_config.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController;

  TextEditingController _passController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email, _password;

  checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(
            context, 'SignUpOpt');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    this.checkAuth();
    super.initState();
  }

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } catch (e) {
        showError(e.message);
      }
    }
  }

  void showError(String message) {
    showDialog(
        context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text("error"),
        content: Text(message),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Ok"))
        ],
      );
    });
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
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
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
            SizedBox(
              height: getProportionateScreenHeight(41),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomInput(
                      hintText: "Email",
                      iconImage: "assets/images/profile.png",
                      keyBoardType: TextInputType.emailAddress,
                      validation: validateEmail,
                      controller: _emailController,
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    CustomInput(
                      hintText: "Password",
                      iconImage: "assets/images/lock.png",
                      isPasswordField: true,
                      validation: validatePass,
                      controller: _passController,
                      onSaved: (value) => _password = value,
                    ),
                  ],
                )),
            Spacer(),
            DefaultButton(
              text: "LOGIN",
              onPressed: () {
                login();
              },
            ),
            Spacer(
              flex: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context,'SignUp');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey[500],
                  ),
                  Text(
                    "Don’t have an account? Sign Up",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: getProportionateScreenHeight(14)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }


}
