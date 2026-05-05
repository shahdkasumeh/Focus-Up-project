import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controller/home/study_companion_controller.dart';
import 'package:test/core/class/constant/appcolor.dart';

class ComposeBox extends GetView<StudyCompanionController> {
  const ComposeBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "نشر إعلان",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffE6F2EC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "أنت فقط تراه كمرسل",
                  style: TextStyle(
                    color: Appcolor.scondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller.contentController,
            maxLines: 3,
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: "شارك ما تدرسه أو اطرح سؤالاً على زملائك...",
              fillColor: Colors.white,
              filled: true,
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xffD7D7D7)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xffD7D7D7)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Appcolor.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: controller.posts,

                  child: const Text("نشر"),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
