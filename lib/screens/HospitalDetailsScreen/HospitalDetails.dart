import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hospital_app/model/hospitalModel.dart';
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

  final docReference = FirebaseDatabase.instance.reference().child('Doctors');

  String _pdf, _age, _name, _aptid;
  List<DoctorModel> doctors = List();

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

  Future<void> getDoctor(){
    docReference.once().then((DataSnapshot snap) {
      doctors.clear();
      print(snap.value);
      var data = snap.value;
      data.forEach((key, value) {
        DoctorModel doc = new DoctorModel(
            value['d_name'], value['department'], value['speciality'],value['status']);
        doctors.add(doc);
      });
      print("DocList has ${doctors.length}");
    });
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
    getDoctor();
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
                DatabaseService()
                    .documentFileUpload(_name, _pdf, _age, "PENDING", _aptid);
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
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            TitleWidget(
                              title: "Location",
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
                            TitleWidget(
                              title: "Specialities : ",
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
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
                            TitleWidget(
                              title: "Doctors",
                            ),
                            Container(
                              height: (doctors.length/2.ceil())* 100.toDouble(),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 2.0,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: doctors.length,
                                  itemBuilder: (context,index){
                                    return DocAvailTile(
                                      name: doctors[index].d_name.toString(),
                                      speciality: doctors[index].speciality.toString(),
                                      isAvailable: doctors[index].status,
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            TitleWidget(
                              title: "About the Hospital",
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(20),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: Text("${documentData['info']}",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                      color: Colors.black)),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(40),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Text(title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
    );
  }
}

class DocAvailTile extends StatelessWidget {
  const DocAvailTile({
    Key key,
    this.name,
    this.speciality,
    this.isAvailable,
  }) : super(key: key);

  final String name, speciality;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isAvailable
              ? Colors.green.withOpacity(0.7)
              : Colors.red.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color:
                    isAvailable ? Colors.green.shade100 : Colors.red.shade100,
                spreadRadius: 3,
                blurRadius: 6)
          ]),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/images/doctor.svg",
            width: getProportionateScreenWidth(40),
            color: Colors.white,
          ),
          SizedBox(
            width: getProportionateScreenWidth(10),
          ),
          Container(
            width: getProportionateScreenWidth(80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(5),
                ),
                Text(
                  speciality,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
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
