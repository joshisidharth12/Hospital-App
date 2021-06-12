import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/screens/HospitalDetailsScreen/HospitalDetails.dart';
import 'package:hospital_app/screens/QRCodeGenerator/QRCode.dart';
import 'package:hospital_app/screens/QRCodeScanner/QRScannerScreen.dart';
import 'package:hospital_app/services/database.dart';
import 'package:hospital_app/size_config.dart';


class HomeTab extends StatefulWidget {

  final String location;

  HomeTab({this.location});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _hospitals =
  FirebaseFirestore.instance.collection('Hospital');

  bool isloggedin = false;
  User user;
  File file;

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
    super.initState();
    this.checkAuth();
    this.getuser();
  }

  @override
  Widget build(BuildContext context) {
    return !isloggedin
        ? CircularProgressIndicator()
        : Scaffold(
      body: Container(
        width: double.infinity,
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        QRCodeGenerator()));
                          },
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        QRScanScreen()));
                          },
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
                      Text(widget.location??"Pune, Maharashtra",
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
              height: getProportionateScreenHeight(20),
            ),
            UpdateFormButton(
              onPressed: () {
                selectFile();
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Hospitals",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenHeight(24),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  height: getProportionateScreenHeight(300),
                  child: FutureBuilder<QuerySnapshot>(
                    future: _hospitals.get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text("${snapshot.hasError}"),
                          ),
                        );
                      }

                      if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return Container(
                          height: 270,
                          margin: EdgeInsets.only(bottom: 15),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data.docs.map((doc) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetails(
                                                id: doc.id.toString(),
                                                hospitalName:
                                                doc.data()['name'],
                                              )));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 20, left: 20, bottom: 12),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey[200],
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                            offset: Offset(0, 0))
                                      ]),
                                  width: getProportionateScreenWidth(165),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    doc.data()['image']),
                                                fit: BoxFit.cover),
                                            color: Color(0xFFEEEEF0),
                                            borderRadius:
                                            BorderRadius.circular(
                                                15)),
                                        height:
                                        getProportionateScreenHeight(
                                            154),
                                      ),
                                      Spacer(),
                                      Text(
                                        doc.data()['name'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                            getProportionateScreenWidth(
                                                14),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Text(
                                        doc.data()['location'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer()
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }

                      return Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future selectFile() async {
    var rng = new Random();
    String randomName = "";
    for (var i = 0; i < 10; i++) {
      print(rng.nextInt(100));
      randomName += rng.nextInt(100).toString();
    }
    File result = await FilePicker.getFile(fileExtension: 'pdf');
    String fileName = '$randomName.pdf';
    savePdf(result.readAsBytesSync(), fileName);
  }

  savePdf(List<int> asset, String name) async {
    Reference reference = FirebaseStorage.instance.ref().child(name);
    UploadTask uploadTask = reference.putData(asset);
    String url = await(await uploadTask).ref.getDownloadURL();
    await DatabaseService(uid: _auth.currentUser.uid).updatePdf(url);
    Fluttertoast.showToast(
        msg: "File uploaded successfully",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.green,
        gravity: ToastGravity.BOTTOM);
  }

}

class UpdateFormButton extends StatelessWidget {
  const UpdateFormButton({
    Key key, this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: getProportionateScreenHeight(50),
        width: getProportionateScreenWidth(311),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 10,
            shadowColor: Color(0xFF2F80ED).withOpacity(0.4),
            primary: Color(0xFF2F80ED),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            textStyle: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          child: Text("UPDATE FORM")),
    );
  }
}
