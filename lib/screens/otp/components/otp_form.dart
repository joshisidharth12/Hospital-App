import 'package:flutter/material.dart';
import 'package:hospital_app/size_config.dart';


class OtpForm extends StatefulWidget {
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
    super.dispose();
  }

  void nextField({String value, FocusNode focusNode}){
    if(value.length == 1){
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: getProportionateScreenWidth(50),
          child: TextFormField(
            autofocus: true,
            obscureText: true,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value){
              nextField(value: value,focusNode: pin2FocusNode);
            },
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),

        SizedBox(
          width: getProportionateScreenWidth(50),
          child: TextFormField(
            focusNode: pin2FocusNode,
            keyboardType: TextInputType.number,
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value){
              nextField(value: value,focusNode: pin3FocusNode);
            },
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),

        SizedBox(
          width: getProportionateScreenWidth(50),
          child: TextFormField(
            focusNode: pin3FocusNode,
            keyboardType: TextInputType.number,
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value){
              nextField(value: value,focusNode: pin4FocusNode);
            },
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),

        SizedBox(
          width: getProportionateScreenWidth(50),
          child: TextFormField(
            focusNode: pin4FocusNode,
            keyboardType: TextInputType.number,
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value){
              nextField(value: value,focusNode: pin5FocusNode);
            },
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),

        SizedBox(
          width: getProportionateScreenWidth(50),
          child: TextFormField(
            keyboardType: TextInputType.number,
            focusNode: pin5FocusNode,
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value){
              nextField(value: value,focusNode: pin6FocusNode);
            },
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),

        SizedBox(
          width: getProportionateScreenWidth(50),
          child: TextFormField(
            focusNode: pin6FocusNode,
            keyboardType: TextInputType.number,
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value){
              pin6FocusNode.unfocus();
            },
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    ));
  }
}
