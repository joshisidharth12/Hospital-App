import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/screens/components/Deal_List.dart';
import 'package:hospital_app/screens/components/FeatBrands.dart';
import 'package:hospital_app/screens/components/SliderTab.dart';
import 'package:hospital_app/screens/components/TopCat.dart';
import 'package:hospital_app/screens/sign_up_screen/SignUpOption.dart';
import 'package:hospital_app/size_config.dart';

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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpOption()));
      }
    });
  }

  getuser() async{
    User firebaseUser = _auth.currentUser;
    print(firebaseUser);
    if(firebaseUser != null){
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

    return !isloggedin ? CircularProgressIndicator() : SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(10),
                    horizontal: getProportionateScreenWidth(20)),
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
                        Container(
                          width: getProportionateScreenWidth(38),
                          height: getProportionateScreenHeight(42),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(42)),
                        ),
                        // SizedBox(
                        //   width: getProportionateScreenWidth(210),
                        // ),
                        Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications_none,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(20),
                              ),
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 30,
                                color: Colors.white,
                              )
                            ],
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
                      "Welcome to company name",
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
              TopCat(),
              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              //SLIDER

              Container(
                margin: EdgeInsets.only(left: 20),
                height: getProportionateScreenHeight(140),
                child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SliderTab();
                    }),
              ),

              SizedBox(
                height: getProportionateScreenHeight(20),
              ),
              DealOfTheDay(),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),

              //Featured Brand
              FeatBrands(),
            ],
          ),
          Positioned(
            top: getProportionateScreenHeight(215),
            left: getProportionateScreenWidth(32),
            child: Container(
              width: getProportionateScreenWidth(315),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 4,
                        offset: Offset(0, 6))
                  ]),
              padding: EdgeInsets.all(10),
              height: getProportionateScreenHeight(50),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Search Medicine & Healthcare products"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
