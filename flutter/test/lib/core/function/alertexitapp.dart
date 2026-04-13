import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

Future<bool> alertExitApp() async {
  final completer = Completer<bool>();

  Get.defaultDialog(
    title: "Warning",
    middleText: " Do you want to exit the app",
    actions: [
      ElevatedButton(
        onPressed: () {
          completer.complete(true);
          Get.back();
          exit(0);
        },
        child: const Text("Confirm"),
      ),
      ElevatedButton(
        onPressed: () {
          completer.complete(false);
          Get.back();
        },
        child: const Text("Cancel"),
      ),
    ],
  );

  return Future.value(true);
}
