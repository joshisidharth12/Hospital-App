import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/CustomInput.dart';
import 'package:hospital_app/Validators.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/home_screen/home_screen.dart';
import 'package:hospital_app/screens/sign_up_screen/SignUpOption.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _namecontroller;

  TextEditingController _emailcontroller;

  TextEditingController _passcontroller;

  String _name, _password, _email;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    _namecontroller = TextEditingController();
    _emailcontroller = TextEditingController();
    _passcontroller = TextEditingController();

    this.checkAuth();
    super.initState();
  }

  signup() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        if(user != null){

          /*UserUpdateInfo updateuser = UserUpdateInfo();
          updateuser.displayName = _name;
          user.updateProfile(updateuser);*/

          await _auth.currentUser.updateProfile(displayName: _name);
        }
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
                      onSaved: (value) => _name = value,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20),),
                    CustomInput(
                      hintText: "Email",
                      iconImage: "assets/images/profile.png",
                      keyBoardType: TextInputType.emailAddress,
                      validation: validateEmail,
                      onSaved: (value) => _email = value,
                    ),
                    SizedBox(height: getProportionateScreenHeight(20),),
                    CustomInput(
                      hintText: "Password",
                      iconImage: "assets/images/lock.png",
                      isPasswordField: true,
                      validation: validatePass,
                      onSaved: (value) => _password = value,
                    ),
                  ],
                )
            ),
            Spacer(),
            DefaultButton(
              text: "CREATE ACCOUNT",
              onPressed: () {
                signup();
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
