import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test/controller/home/qrcodecontroller.dart';

class QrcodeScreen extends GetView<QrcodecontrollerImp> {
  const QrcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F2A43),

      appBar: AppBar(title: const Text("QR Code"), centerTitle: true),

      body: Center(
        child: Obx(() {
          final qr = controller.qr.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔥 حالة وجود QR
              Text(
                qr.isEmpty ? "ما عندك QR لسه" : "عندك QR جاهز 🎉",
                style: TextStyle(
                  fontSize: 18,
                  color: qr.isEmpty ? Colors.red : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // 🔥 عرض QR
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: qr.isEmpty
                    ? const Text("No QR Found")
                    : QrImageView(data: qr, size: 220),
              ),

              const SizedBox(height: 20),

              // 🔥 نص الكود
              Text(qr, style: const TextStyle(color: Colors.grey)),
            ],
          );
        }),
      ),
    );
  }
}
