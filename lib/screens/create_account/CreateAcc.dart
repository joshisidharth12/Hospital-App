import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/CustomInput.dart';
import 'package:hospital_app/Validators.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/services/database.dart';
import 'package:hospital_app/size_config.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _name, _password, _email,_age,_emergencyNo;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushReplacementNamed(
            context, 'HomeScreen');
      }
    });
  }

  @override
  void initState() {
    this.checkAuth();
    super.initState();
  }

  signup() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        User firebaseUser = user.user;

        await DatabaseService(uid: firebaseUser.uid).setUserData(_name,_emergencyNo,_age);
        if(user != null){
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
        child: SingleChildScrollView(
          child: Column(
            children: [
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
              SizedBox(height: getProportionateScreenHeight(10),),
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
                        iconImage: "assets/images/email.png",
                        keyBoardType: TextInputType.emailAddress,
                        validation: validateEmail,
                        onSaved: (value) => _email = value,
                      ),
                      SizedBox(height: getProportionateScreenHeight(20),),
                      CustomInput(
                        hintText: "Age",
                        iconImage: "assets/images/ageIcon.png",
                        keyBoardType: TextInputType.number,
                        validation: validateAge,
                        onSaved: (value) => _age = value,
                      ),
                      SizedBox(height: getProportionateScreenHeight(20),),
                      CustomInput(
                        hintText: "Emergency Number",
                        iconImage: "assets/images/smartphone.png",
                        keyBoardType: TextInputType.phone,
                        validation: validatePhone,
                        onSaved: (value) => _emergencyNo = value,
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
              SizedBox(height: getProportionateScreenHeight(10),),
              DefaultButton(
                text: "CREATE ACCOUNT",
                onPressed: () {
                  signup();
                },
              ),
              SizedBox(height: getProportionateScreenHeight(10),),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context,'Login');
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
            ],
          ),
        ),
      ),
    );
  }
}
