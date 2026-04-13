import 'package:flutter/material.dart';
import 'package:test/core/class/constant/imageassets.dart';

class Buildlogoscreen extends StatelessWidget {
  const Buildlogoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [Image.asset(Imageassets.logo, width: 150, height: 150)],
      ),
    );
  }
}
