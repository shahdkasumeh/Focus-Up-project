
import 'package:flutter/material.dart';
import 'package:test/view/widget/profile/summary_item.dart';

class AccountSummaryCard extends StatelessWidget {
  final bool hasProfile;
  final String address;
  final String studyLevel;

  const AccountSummaryCard({
    required this.hasProfile,
    required this.address,
    required this.studyLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF172F4F).withValues(alpha: 0.07),
            blurRadius: 25,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SummaryItem(
              icon: Icons.account_circle_outlined,
              title: "الحساب",
              value: hasProfile ? "مكتمل" : "جديد",
            ),
          ),
          _divider(),
          Expanded(
            child: SummaryItem(
              icon: Icons.location_on_outlined,
              title: "العنوان",
              value: address.isEmpty ? "غير محدد" : "مضاف",
            ),
          ),
          _divider(),
          Expanded(
            child: SummaryItem(
              icon: Icons.school_outlined,
              title: "الدراسة",
              value: studyLevel.isEmpty ? "غير محدد" : studyLevel,
            ),
          ),
        ],
      ),
    );
  }
  Widget _divider() {
    return Container(height: 43, width: 1, color: Colors.grey.shade200);
  }
}
