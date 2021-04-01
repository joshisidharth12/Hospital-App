
import 'package:flutter/material.dart';
import 'package:hospital_app/screens/splash/splash_screen1.dart';
import 'package:hospital_app/screens/splash/splash_screen2.dart';

final Map<String,WidgetBuilder> routes = {
  SplashScreen.routeName : (context) => SplashScreen(),
  SplashScreen2.routeName : (context) => SplashScreen2(),
};