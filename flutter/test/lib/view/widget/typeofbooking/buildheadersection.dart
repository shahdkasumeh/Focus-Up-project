import 'package:flutter/material.dart';

class Buildheadersection extends StatelessWidget {
  const Buildheadersection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            "خطوتك التالية",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xff2E7D32),
            ),
          ),
          SizedBox(height: 10),

          SizedBox(height: 18),
          Text(
            "اختر نوع المساحة التي تناسب إنتاجيتك اليوم. نوفر بيئات\nمصممة خصيصًا للتفكير العميق والتعاون المشترك.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              height: 1.9,
              color: Color(0xff4B4B4B),
            ),
          ),
        ],
      ),
    );
  }
}
