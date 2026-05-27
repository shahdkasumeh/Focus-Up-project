import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showOptionsSheetProfile({
  required String title,
  required List<String> options,
  required void Function(String option) onSelected,
}) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 45,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),
          ...options.map(
            (option) => InkWell(
              onTap: () {
                onSelected(option);
                Get.back();
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffF7F8FA),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  option,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    isScrollControlled: true,
  );
}