import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:test/controller/home/homepagecontroller.dart';
import 'package:test/core/class/constant/appcolor.dart';
import 'package:test/view/widget/home/build_package_section.dart';
import 'package:test/view/widget/home/buildaction.dart';

class HomepageScreen extends GetView<HomePageControllerImp> {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageControllerImp());

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [],
        ),
      ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Appcolor.scondary,
            elevation: 0,
            floating: true,
            snap: true,
            pinned: false,

            title: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Focus',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Appcolor.backgroundcolor,
                    ),
                  ),
                  TextSpan(
                    text: 'Up',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Appcolor.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Buildaction(),
                  SizedBox(height: 20),
                  //   BuildHallsSection(),
                  SizedBox(height: 20),
                  BuildPackageSection(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
