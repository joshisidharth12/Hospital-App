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
    return
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
