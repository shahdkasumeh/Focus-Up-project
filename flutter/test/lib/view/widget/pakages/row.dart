import 'package:flutter/material.dart';
import 'package:test/core/class/constant/appcolor.dart';

class Rows extends StatelessWidget {
  final String title;
  final String value;

  const Rows({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          Flexible(
            child: Text(
              value,

              textAlign: TextAlign.right,

              style: const TextStyle(
                fontSize: 15,

                color: Appcolor.scondary,

                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Text(
            ':$title ',

            style: const TextStyle(
              fontSize: 15,

              color: Appcolor.black,

              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}