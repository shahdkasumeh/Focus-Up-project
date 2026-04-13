import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Customtextformauth extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final IconData iconData;
  final TextEditingController mycontroller;
  final String? Function(String?)? valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;

  const Customtextformauth({
    super.key,
    required this.hinttext,
    required this.labeltext,
    required this.iconData,
    required this.mycontroller,
    required this.valid,
    required this.isNumber,
    this.obscureText,
    this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      child: TextFormField(
        keyboardType: isNumber
            ? TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        validator: valid,
        controller: mycontroller,
        obscureText: obscureText == null || obscureText == false ? false : true,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          focusColor: Appcolor.scondary,
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(color: Appcolor.scondary),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          label: Text(labeltext),
          labelStyle: TextStyle(color: Appcolor.scondary),
          suffixIcon: InkWell(
            child: Icon(iconData, color: Appcolor.scondary),
            onTap: onTapIcon,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
