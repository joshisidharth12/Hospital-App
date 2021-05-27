import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/screens/components/Deal_List.dart';
import 'package:hospital_app/services/database.dart';
import 'package:hospital_app/size_config.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
    return !isloggedin
        ? CircularProgressIndicator()
        : StreamProvider<QuerySnapshot>.value(
            value: DatabaseService().hosp,
            initialData: null,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(
                      getProportionateScreenHeight(20),
                    ),
                    height: getProportionateScreenHeight(245),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12)),
                        gradient: kPrimaryGradientColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  height: getProportionateScreenHeight(60),
                                  width: getProportionateScreenHeight(60)),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFF6161),
                                    padding: EdgeInsets.all(5),
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                child: Icon(
                                  Icons.notifications_none,
                                  size: 27,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(20),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  height: getProportionateScreenHeight(60),
                                  width: getProportionateScreenHeight(60)),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    padding: EdgeInsets.all(5),
                                    onPrimary: Color(0xFF2F80ED),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                child: Icon(
                                  Icons.qr_code_scanner,
                                  size: 27,
                                  color: Color(0xFF2F80ED),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Hi, ${user.displayName}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(24),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome to Hospital Helper",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            Text("Pune, Maharashtra",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(16),
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                  DealOfTheDay(),
                  SizedBox(
                    height: getProportionateScreenHeight(30),
                  ),
                ],
              ),
            ),
          );
  }
}
