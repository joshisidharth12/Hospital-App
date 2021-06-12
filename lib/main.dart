import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hospital_app/screens/create_account/CreateAcc.dart';
import 'package:hospital_app/screens/home_screen/home_screen.dart';
import 'package:hospital_app/screens/login/login_screen.dart';
import 'package:hospital_app/screens/onboarding/OnBoardingBody.dart';
import 'package:hospital_app/screens/sign_up_screen/SignUpOption.dart';

import 'package:hospital_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences =await SharedPreferences.getInstance();
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
  String latitude,longitube;

  String location;

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    latitude = '$lat';
    longitube = '$long';
    setState(() {
      location="Lat: $latitude, Long: $longitube";
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
      home: initScreen == 0 || initScreen == null ? OnBoardingBody() : SignUpOption(),
      routes: <String,WidgetBuilder>{
        "Login" : (BuildContext context) => LoginScreen(),
        "SignUp" : (BuildContext context) => CreateAccount(),
        "SignUpOpt" : (BuildContext context) => SignUpOption(),
        "HomeScreen" : (BuildContext context) => HomePage(
          location: location,
        ),
      },
    );
  }
}
