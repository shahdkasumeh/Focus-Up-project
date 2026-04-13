import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Textsignup extends StatelessWidget {
  final String textone;
  final String texttwo;
  final void Function() onTap;
  const Textsignup({
    super.key,
    required this.textone,
    required this.texttwo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textone,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            texttwo,
            style: TextStyle(
              color: Appcolor.scondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
//  Container(
//           width: 500,
//           height: 400,
//           decoration: BoxDecoration(
//             color: Colors.grey.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(20),
//           )
//  )