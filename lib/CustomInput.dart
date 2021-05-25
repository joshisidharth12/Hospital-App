import 'package:flutter/material.dart';
import 'package:hospital_app/constants.dart';
import 'package:hospital_app/size_config.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key key,
    this.hintText,
    this.onChange,
    this.onSubmitted,
    this.focusNode,
    this.isPasswordField,
    this.textInputAction,
    this.iconImage,
    this.keyBoardType,
    this.controller, this.validation, this.onSaved,
  }) : super(key: key);

  final String hintText;
  final Function(String) onChange;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final Function validation,onSaved;
  final bool isPasswordField;
  final String iconImage;
  final TextInputType keyBoardType;
  final TextEditingController controller;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onSubmitted,
      obscureText: _isPasswordField,
      textInputAction: textInputAction,
      keyboardType: keyBoardType,
      validator: validation,
      onSaved: onSaved,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: kPrimaryColor,
          fontFamily: 'Overpass Regular',
          fontSize: getProportionateScreenHeight(20)),
      decoration: InputDecoration(
        fillColor: kSecondaryColor.withOpacity(0.22),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none
        ),
        errorStyle: TextStyle(
          fontSize: getProportionateScreenHeight(16),
          fontFamily: 'Overpass Regular',
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(14),
          child: Image.asset(
            iconImage,
            width: getProportionateScreenHeight(30),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(10),
            horizontal: getProportionateScreenWidth(10)),
        hintText: hintText,
        hintStyle: TextStyle(
            fontFamily: 'Overpass Regular',
            color: kPrimaryColor,
            fontSize: getProportionateScreenHeight(20)),
      ),
    );
  }
}
