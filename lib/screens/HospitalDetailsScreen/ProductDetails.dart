import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                              padding: EdgeInsets.only(left: 20,top: 20),
                              child: Text(
                                "Location",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(height: getProportionateScreenHeight(10),),
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
                                margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
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
                              padding: EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("About the Hospital",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black)),
                                  SizedBox(height: getProportionateScreenHeight(10),),
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
                child: Column(
                  children: [CircularProgressIndicator(), Text('Loading....')],
                ),
              ),
            );
          },
        ));
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
