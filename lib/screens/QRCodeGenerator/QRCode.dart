import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/size_config.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatefulWidget {
  @override
  _QRCodeGeneratorState createState() => _QRCodeGeneratorState();
}

class _QRCodeGeneratorState extends State<QRCodeGenerator> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _info, _age, _name, _emergencyNo;

  checkAuth() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, "SignUpOpt");
      } else {
        _getUserName();
      }
    });
  }

  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc((_auth.currentUser.uid))
        .get()
        .then((value) {
      setState(() {
        _info = value.data()['pdf'];
        _name = value.data()['name'];
        _age = value.data()['age'].toString();
        _emergencyNo = value.data()['emergencyNo'].toString();
      });
    });
  }

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: getProportionateScreenWidth(60),
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage("assets/images/defaultProfile.png"),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              "Medical Report Link",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            _info == null || _info == "-1"
                ? Center(
                    child: Text(
                      "Please Upload your PDF",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                : QrImage(
                    data: _info,
                    version: QrVersions.auto,
                    size: getProportionateScreenHeight(200)),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              "Age : $_age",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              "Name : $_name",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Text(
              "Emergency Number : $_emergencyNo",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
