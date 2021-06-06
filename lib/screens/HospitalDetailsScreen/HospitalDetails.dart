import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_app/services/database.dart';
import 'package:hospital_app/size_config.dart';

class ProductDetails extends StatefulWidget {
  final String id, hospitalName;

  ProductDetails({this.id, this.hospitalName});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final CollectionReference _hospitals =
      FirebaseFirestore.instance.collection('Hospital');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _pdf, _age, _name, _aptid;

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
        _pdf = value.data()['pdf'];
        _name = value.data()['name'];
        _age = value.data()['age'].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          widget.hospitalName,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Arial Bold'),
        )),
        bottomNavigationBar: Container(
          height: getProportionateScreenHeight(100),
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 4,
                )
              ]),
          child: AppointmentButton(
            onPressed: () {
              if (_pdf == null || _pdf == "-1") {
                Fluttertoast.showToast(
                    msg: "PDF does not exist",
                    toastLength: Toast.LENGTH_SHORT,
                    fontSize: 16,
                    textColor: Colors.red,
                    gravity: ToastGravity.BOTTOM);
              } else {
                _aptid = DatabaseService().createCryptoRandomString();
                DatabaseService().documentFileUpload(
                    _name, _pdf, _age, "PATIENT", "PENDING", _aptid);
                Fluttertoast.showToast(
                    msg: "Appointment has been booked",
                    toastLength: Toast.LENGTH_SHORT,
                    textColor: Colors.green,
                    gravity: ToastGravity.BOTTOM);
              }
            },
          ),
        ),
        body: FutureBuilder(
          future: _hospitals.doc(widget.id).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text('Error : ${snapshot.error}'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> documentData = snapshot.data.data();

              List specialities = documentData['speciality'];

              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("${documentData['image']}"),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Text(
                                "Location",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(10),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text("${documentData['location']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Container(
                                height: getProportionateScreenHeight(40),
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        getProportionateScreenWidth(20)),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green.withOpacity(0.3)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Available Beds",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${documentData['beds'].toString()}",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Text("Specialities : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black)),
                            ),
                            Container(
                              height: getProportionateScreenHeight(70),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (var i = 0; i < specialities.length; i++)
                                    SpecialityTile(
                                        specialities: specialities, i: i)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("About the Hospital",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black)),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Text("${documentData['info']}",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }
}

class AppointmentButton extends StatelessWidget {
  const AppointmentButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: double.infinity,
        height: getProportionateScreenHeight(50),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: Colors.green,
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontFamily: 'Overpass Bold',
                fontWeight: FontWeight.bold)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Appointment"),
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}

class SpecialityTile extends StatelessWidget {
  const SpecialityTile({
    Key key,
    @required this.specialities,
    @required this.i,
  }) : super(key: key);

  final List specialities;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      margin: EdgeInsets.only(
          top: getProportionateScreenWidth(10),
          bottom: getProportionateScreenWidth(10),
          left: getProportionateScreenWidth(20)),
      decoration: BoxDecoration(
          color: Colors.yellow[900],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                spreadRadius: 2,
                color: Colors.yellow[900].withOpacity(0.3),
                blurRadius: 5)
          ]),
      child: Center(
        child: Text(
          "${specialities[i]}",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
