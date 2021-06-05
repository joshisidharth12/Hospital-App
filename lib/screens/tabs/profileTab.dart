import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/size_config.dart';
class ProfileTab extends StatefulWidget {
  const ProfileTab({
    Key key,
  }) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloggedin = false;
  User user;
  checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "SignUpOpt");
      }
    });
  }

  getuser() async {
    User firebaseUser = _auth.currentUser;
    print(firebaseUser);
    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    this.checkAuth();
    this.getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Spacer(),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/images/defaultProfile.png",),
          ),
          SizedBox(height: getProportionateScreenHeight(20),),
          Text("${user.displayName}",style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),),
          SizedBox(height: getProportionateScreenHeight(20),),
          DefaultButton(
            onPressed: (){
              _auth.signOut();
            },
            text: "SIGN OUT",
          ),
          Spacer(),
        ],
      ),
    );
  }
}