import 'package:flutter/material.dart';
import 'package:hospital_app/size_config.dart';

class SliderTab extends StatelessWidget {
  const SliderTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.all(14),
      height: getProportionateScreenHeight(140),
      width: getProportionateScreenWidth(326),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image: AssetImage("assets/images/pills_slide.png"),
              fit: BoxFit.cover)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Save extra on\nevery order",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: getProportionateScreenHeight(20),
                  color: Color(0xFF1987FB),
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(10),
              ),
              Text(
                "Etiam mollis \nmetus non faucibus . ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: getProportionateScreenHeight(16),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}
