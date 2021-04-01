import 'package:flutter/material.dart';
import '../../size_config.dart';

class OnBoardingContent extends StatelessWidget {

  static String routename = "/onBoarding";

  const OnBoardingContent({
    Key key,
    this.image,
    this.text1,
    this.text2,
  }) : super(key: key);

  final String text1, text2, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 3,
        ),
        Image.asset(
          image,
          height: getProportionateScreenHeight(282),
          width: getProportionateScreenWidth(255),
        ),
        Spacer(
          flex: 1,
        ),
        Text(text1,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: getProportionateScreenHeight(24))),
        Spacer(),
        Text(
          text2,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: getProportionateScreenHeight(16)),
        ),
        Spacer(),
      ],
    );
  }
}
