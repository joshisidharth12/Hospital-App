import 'package:flutter/material.dart';
import 'package:hospital_app/defaultButton.dart';
import 'package:hospital_app/screens/tabs/home_tab.dart';
import 'package:hospital_app/size_config.dart';
import 'package:page_transition/page_transition.dart';

class ShopLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: getProportionateScreenWidth(335),
              height: getProportionateScreenHeight(546),
              child: Image.asset("assets/images/mapImage.png"),
            ),
            Spacer(),
            DefaultButton(
              text: "SELECT",
              onPressed: (){
                Navigator.pop(context,PageTransition(child: HomeTab(),type: PageTransitionType.topToBottom, duration: Duration(milliseconds: 700)));
              },
            ),
            Spacer(flex: 2,)
          ],
        ),
      ),
    );
  }
}
