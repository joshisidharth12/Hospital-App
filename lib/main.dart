import 'package:flutter/material.dart';
import 'package:hospital_app/screens/onboarding/OnBoardingBody.dart';
import 'package:hospital_app/screens/sign_up_screen/SignUpOption.dart';

import 'package:hospital_app/screens/splash/splash_screen1.dart';
import 'package:hospital_app/screens/splash/splash_screen2.dart';

import 'package:hospital_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences =await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: initScreen == 0 || initScreen == null ? OnBoardingBody() : SignUpOption(),
    );
  }
}
