import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hospital_app/screens/create_account/CreateAcc.dart';
import 'package:hospital_app/screens/home_screen/home_screen.dart';
import 'package:hospital_app/screens/login/login_screen.dart';
import 'package:hospital_app/screens/onboarding/OnBoardingBody.dart';
import 'package:hospital_app/screens/sign_up_screen/SignUpOption.dart';

import 'package:hospital_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await Firebase.initializeApp();
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String location,add1,add2;

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    final coordinates = Coordinates(lat, long);
    var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    add1 = address.first.locality;
    add2 = address.first.subLocality;

    setState(() {
      location = "$add2, $add1";
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: initScreen == 0 || initScreen == null
          ? OnBoardingBody()
          : SignUpOption(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => LoginScreen(),
        "SignUp": (BuildContext context) => CreateAccount(),
        "SignUpOpt": (BuildContext context) => SignUpOption(),
        "HomeScreen": (BuildContext context) => HomePage(
              location: location,
            ),
      },
    );
  }
}
