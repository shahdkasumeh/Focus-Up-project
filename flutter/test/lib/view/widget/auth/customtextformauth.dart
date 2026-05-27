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
      margin: const EdgeInsets.only(bottom: 22),

      child: TextFormField(
        controller: mycontroller,
        validator: valid,

        obscureText: obscureText ?? false,

        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.emailAddress,

        cursorColor: Appcolor.scondary,
        cursorHeight: 24,
        cursorWidth: 2.5,

        style: const TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),

        decoration: InputDecoration(
          hintText: hinttext,
          labelText: labeltext,

          filled: true,
          fillColor: Colors.white,

          contentPadding: const EdgeInsets.all(15),

          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,

          labelStyle: const TextStyle(
            color: Appcolor.scondary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),

          floatingLabelStyle: const TextStyle(
            color: Appcolor.scondary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),

          suffixIcon: InkWell(
            onTap: onTapIcon,
            borderRadius: BorderRadius.circular(12),

            child: Icon(iconData, color: Appcolor.scondary, size: 24),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: const BorderSide(color: Appcolor.primary, width: 1.5),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),

            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),

            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),

          errorStyle: const TextStyle(fontSize: 12, height: 1.2),
        ),
      ),
    );
  }
}
