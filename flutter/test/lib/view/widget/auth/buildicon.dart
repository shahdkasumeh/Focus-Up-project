import 'package:flutter/material.dart';

class Buildicon extends StatelessWidget {
  final IconData iconData;
  final sizeIcon;
  const Buildicon({super.key, required this.iconData, this.sizeIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //CONTAINER
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: Color(0xFFEAF2FF),
            shape: BoxShape.circle,
          ),
          //ICON
          child: Icon(iconData, color: Color(0xFF1A3A5C), size: sizeIcon),
        ),
      ],
    );
  }
}
