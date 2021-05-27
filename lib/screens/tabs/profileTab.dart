import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/screens/sign_up_screen/SignUpOption.dart';
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
        Navigator.pushReplacementNamed(
            context, 'SignUpOpt');
      }
    });
  }

  getuser() async{
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if(user != null){
      this.user = firebaseUser;
      this.isloggedin = true;
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
          Text("Hi your email is"),
          ElevatedButton(
            onPressed: (){
              _auth.signOut();
            },
            child: Text("Sign out"),
          ),
          Spacer(),
        ],
      ),
    );
  }
}