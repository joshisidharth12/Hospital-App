import 'package:flutter/material.dart';
import 'package:hospital_app/size_config.dart';


class DefaultButton extends StatelessWidget {
  DefaultButton({
    Key key,
    this.text,
    this.onPressed
  }) : super(key: key);

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return /*GestureDetector(
      onTap: onPressed,
      child: Container(
        height: getProportionateScreenHeight(50),
        width: getProportionateScreenWidth(311),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),
            color: Color(0xFF4157FF),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFB3BAFF),
                blurRadius: 30.0,
                offset: const Offset(5.0, 10.0),
                spreadRadius: 5.0,
              )
            ]),
        child: Text(
          text,
          style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
      ),
    );*/
      ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: getProportionateScreenHeight(50),
          width: getProportionateScreenWidth(311),
        ),
        child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shadowColor: Color(0xFF4157FF).withOpacity(0.4),
              primary: Color(0xFF4157FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              textStyle: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            child: Text(text)),
      );

  }
}
