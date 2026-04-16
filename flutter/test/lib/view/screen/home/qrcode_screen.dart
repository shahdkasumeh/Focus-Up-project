import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test/controller/home/qrcodecontroller.dart';

class QrcodeScreen extends GetView<QrcodecontrollerImp> {
  const QrcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF172F4F),
        leading: BackButton(color: Colors.white),
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
            final qr = controller.qr.value;
            final data = controller.attendanceData.value;

            if (qr.isEmpty) {
              return const Center(
                child: Text(
                  "No QR Found",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "QR Code",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      QrImageView(data: qr, size: 200),

                      const SizedBox(height: 20),

                      Text(
                        qr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 20),

                      // =========================
                      // 📊 ATTENDANCE DATA
                      // =========================
                      if (data != null) ...[
                        Text("Status: ${data["status"] ?? "-"}"),
                        Text("Start: ${data["actual_start"] ?? "-"}"),

                        if (data["actual_end"] != null)
                          Text("End: ${data["actual_end"]}"),

                        if (data["hours"] != null)
                          Text("Hours: ${data["hours"]}"),

                        if (data["total_price"] != null)
                          Text("Total: ${data["total_price"]}"),

                        if (data["discount_percent"] != null)
                          Text("Discount %: ${data["discount_percent"]}"),

                        if (data["discount_amount"] != null)
                          Text("Discount: ${data["discount_amount"]}"),
                      ] else ...[
                        const Text(
                          "No attendance data yet",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                      const SizedBox(height: 20),

                      // =========================
                      // 🔴 / 🟢 STATUS
                      Text(
                        controller.isInside ? "Inside 🟢" : "Outside 🔴",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: controller.isInside
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
