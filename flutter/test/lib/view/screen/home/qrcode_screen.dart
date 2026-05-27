import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test/controller/home/qrcodecontroller.dart';

class QrcodeScreen extends GetView<QrcodecontrollerImp> {
  const QrcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF172F4F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF172F4F),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "MY QR",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF172F4F), Color(0xFF1E4D6B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            final qrValue = controller.qr.value;
            final bookingData = controller.bookingData;

            final displayedUserName = controller.userName.value.isEmpty
                ? "User"
                : controller.userName.value;

            if (qrValue.isEmpty) {
              return const Center(
                child: Text(
                  "No QR Found",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 26,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Scan this QR",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF172F4F),
                          ),
                        ),
                        const SizedBox(height: 24),
                        RepaintBoundary(
                          child: QrImageView(
                            data: qrValue,
                            size: 210,
                            gapless: false,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),

                        /// اسم المستخدم فقط ظاهر
                        Text(
                          displayedUserName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF172F4F),
                          ),
                        ),

                        const SizedBox(height: 10),
                        const Text(
                          "Show this QR to check in",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  if (bookingData != null) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        children: [
                          buildInfoRow(
                            "Status",
                            bookingData["status"]?.toString() ?? "-",
                          ),
                          buildInfoRow(
                            "Actual Start",
                            controller.actualStartText,
                          ),
                          buildInfoRow("Actual End", controller.actualEndText),
                          buildInfoRow(
                            "Hours",
                            bookingData["hours"]?.toString() ?? "-",
                          ),
                          buildInfoRow(
                            "Total Price",
                            bookingData["total_price"]?.toString() ?? "-",
                          ),
                          buildInfoRow(
                            "Discount Percent",
                            bookingData["discount_percent"]?.toString() ??
                                "0.00",
                          ),
                          buildInfoRow(
                            "Discount Amount",
                            bookingData["discount_amount"]?.toString() ?? "-",
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.grey)),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF172F4F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
