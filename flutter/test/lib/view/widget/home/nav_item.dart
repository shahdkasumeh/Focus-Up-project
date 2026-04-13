// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:test/controller/home/homepagecontroller.dart';
// import 'package:test/core/class/constant/appcolor.dart';
// import 'package:test/view/screen/home/homepage_screen.dart';
// import 'package:test/view/screen/home/profile_screen.dart';
// import 'package:test/view/screen/home/task_screen.dart';

// // class NavItem extends StatelessWidget {

//   const NavItem({
//     Key? key,
//     required this.textbutton,
//     required this.icondata,
//     required this.onPressed,
//     required this.active,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       onPressed: onPressed,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             icondata,
//             color: active == true ? Appcolor.scondary : Appcolor.grey,
//           ),
//           Text(
//             textbutton,
//             style: TextStyle(
//               color: active == true ? Appcolor.scondary : Appcolor.grey,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// class NavItem extends StatelessWidget {
//   HomePageControllerImp controller = Get.put(HomePageControllerImp());
//   NavItem({super.key});
//   final Screens = [HomepageScreen(), TaskScreen(), ProfileScreen()];

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         body: IndexedStack(
//           index: controller.selectedindex.value,
//           children: Screens,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Appcolor.scondary,
//           selectedItemColor: Appcolor.primary,
//           unselectedItemColor: Appcolor.grey,
//           currentIndex: 0,
//           onTap: (index) {
//             // Handle navigation logic here
//           },

//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//           ],
//         ),
//       ),
//     );
//   }
// }
