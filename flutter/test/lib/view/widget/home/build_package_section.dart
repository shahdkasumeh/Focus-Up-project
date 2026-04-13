import 'package:flutter/material.dart';
import 'package:test/view/widget/home/package_card.dart';

class BuildPackageSection extends StatelessWidget {
  const BuildPackageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'باقتي الحالية',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'تجديد',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const PackageCard(
          name: 'باقة 100 ساعة',
          type: 'شخصية • شهرية',
          expiry: '30 أبريل',
          total: 100,
          used: 47,
        ),
      ],
    );
  }
}
