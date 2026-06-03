import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test/controller/home/qrcodecontroller.dart';

class QrcodeScreen extends GetView<QrcodecontrollerImp> {
  const QrcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF172F4F),
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        title: const Text(
          "MY QR",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        actions: [
          Obx(
            () => controller.isLoading.value
                ? const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Center(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      controller.refreshQr();
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                  ),
          ),
        ],
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

            return RefreshIndicator(
              onRefresh: () async {
                controller.refreshQr();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
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
                            "Show this QR to check in/out",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    if (bookingData != null)
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
                            buildInfoRow(
                              "Actual End",
                              controller.actualEndText,
                            ),
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
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Text(
                          "No booking data yet. Tap refresh after check in/out.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF172F4F),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
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
